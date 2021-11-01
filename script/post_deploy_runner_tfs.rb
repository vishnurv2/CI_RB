# frozen_string_literal: true
#
# POST_DEPLOY_RUNNER_TFS
#
# Description:
# This script is essential for TFS to execute parallel cucumber tests.
# This script can also be called from any of the batch scripts in the script directory
# Adjustments can be made to the actual cucumber call
#
#

require 'optimist'
require 'open3'
require 'pry'
require 'socket'

opts = Optimist.options do
  opt :env, 'Name of the env the suite was run in', type: :string, default: 'N/A'
  opt :cuke, 'Cucumber options', type: :string
  opt :changeset, 'The changeset number', type: :string
  opt :reports, 'The folder to place the report files, use forward slashes.  Must have a slash at the end', type: :string, default: 'reports/'
  opt :threads, "The number of thread to run", type: :string, default: '4'
  opt :timestamp, "timestamp of the job start", type: :string
  opt :release, "which application is running", type: :string, default: 'Unknown'
  opt :retries, "The number of retries after a failure", type: :string, default: '2'
end

STDOUT.puts "TIMESTAMP: #{opts[:timestamp]}"

if opts[:timestamp] == "" || opts[:timestamp] == nil
  puts "Timestamp Empty!!!\n\n"
  #opts[:timestamp] = Time.now.strftime("%Y%m%d%H%M")
end

# These params are essential
Optimist.die :env, 'must be specified' unless opts[:env]
Optimist.die :cuke, 'must be specified' unless opts[:cuke]

if opts[:reports_given]
  opts[:reports].gsub!("\\", '/')
  opts[:reports] = "#{opts[:reports]}/" unless opts[:reports].end_with?('/')
end

ENV['REPORT_DIR'] = opts[:reports]
ENV['TEST_ENV'] = opts[:env]
ENV['RELEASE'] = opts[:release]
ENV['RETRIES'] = opts[:retries]

# CONVERT - DEVL to dev until reporting tool is fixed.
newEnv = if opts[:env].downcase == 'devl'
           'dev'
         else
           opts[:env].downcase
         end

ENV['FILE_KEY'] = "#{Socket.gethostname.to_s}-#{opts[:timestamp]}-#{newEnv}"

Dir.chdir '..' if Dir.pwd =~ /script/

puts "PCName: #{Socket.gethostname.to_s}"
puts 'Installing gems'
system('bundle install')

#AMN 4-26-2021 Progress Bar Testing
feature_folder = 'features/personal_auto'
begin
  require 'fileutils'
  feature_count = Dir.glob(File.join("./#{feature_folder}", '**', '*.feature')).select { |file| File.file?(file) }.count
  FileUtils.touch("#{opts[:reports]}/progress/starting-#{Socket.gethostname.to_s}-#{opts[:timestamp]}-#{opts[:env]}-#{feature_count}")
rescue
end



# Run Cucumber
CMD = "bundle exec parallel_cucumber -n #{opts[:threads].to_i} -- #{opts[:cuke]} -p parallel -p kb -p no_regression -p should_work -- #{feature_folder}"

puts "Launching cucumber via: #{CMD}"

stdout, stderr, status = Open3.capture3(CMD)

puts "ERROR OUTPUT: \n #{stderr}\n\n" unless stderr.empty?

# Check for failures
puts "Test output: \n#{stdout}"
exit_code = /cucumbers Failed/i.match?(stderr) ? -1 : 0

puts "Exiting with status #{exit_code}"
exit exit_code
