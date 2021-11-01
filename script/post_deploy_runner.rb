# frozen_string_literal: true
require 'trollop'
require 'open3'
require 'pry'

opts = Trollop.options do
  opt :env, 'Name of the env the suite was run in', type: :string, default: 'N/A'
  opt :cuke, 'Cucumber options', type: :string
  opt :changeset, 'The changeset number', type: :string
  opt :reports, 'The folder to place the report files, use forward slashes.  Must have a slash at the end', type: :string, default: 'reports/'
  opt :threads, "The number of thread to run", type: :string, default: '20'
  opt :retries, "The number of retries after a failure", type: :string, default: '2'
end

Trollop.die :env, 'must be specified' unless opts[:env]
Trollop.die :cuke, 'must be specified' unless opts[:cuke]

if opts[:reports_given]
  opts[:reports].gsub!("\\", '/')
  opts[:reports] = "#{opts[:reports]}/" unless opts[:reports].end_with?('/')
end

ENV['REPORT_DIR'] = opts[:reports]
ENV['TEST_ENV'] = opts[:env]
ENV['FILE_KEY'] = "#{Time.now.strftime('%H%M%S%L')}-#{opts[:env]}"
ENV['RETRIES'] = opts[:retries]

Dir.chdir '..' if Dir.pwd =~ /script/

puts 'Installing gems'
system('bundle install')
#binding.pry

#AMN 4-26-2021 Progress Bar Testing
feature_folder = 'features/personal_auto'
begin
  require 'fileutils'
  feature_count = Dir.glob(File.join("./#{feature_folder}", '**', '*.feature')).select { |file| File.file?(file) }.count
  FileUtils.touch("#{opts[:reports]}/progress/starting-#{Socket.gethostname.to_s}-#{opts[:timestamp]}-#{opts[:env]}-#{feature_count}")
rescue
end




CMD = "bundle exec parallel_cucumber -n #{opts[:threads].to_i} -- #{opts[:cuke]} -p parallel -p kb -p no_regression -p should_work -- #{feature_folder}"

puts "Launching cucumber via: #{CMD}"

stdout, stderr, status = Open3.capture3(CMD)

puts "ERROR OUTPUT: \n #{stderr}\n\n" unless stderr.empty?

puts "Test output: \n#{stdout}"
exit_code = /cucumbers Failed/i.match?(stderr) ? -1 : 0

puts 'Merging results...'
system("bundle exec ruby script\\merge_json.rb \"#{opts[:reports]}#{ENV['FILE_KEY']}-results\\*.json\" \"#{opts[:reports]}/merged_results-#{ENV['FILE_KEY']}.json\"")

puts 'Submitting results...'
changeset = opts[:changeset_given] ? "--instance \"For changeset: #{opts[:changeset]}\"" : ''
system("bundle exec ruby script\\upload_result.rb --file #{opts[:reports]}merged_results-#{ENV['FILE_KEY']}.json --env #{opts[:env]} --suite \"Post Deploy Run in #{opts[:env]}\" #{changeset}")

puts "Exiting with status #{exit_code}"
exit exit_code
