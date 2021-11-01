# frozen_string_literal: true
#
# This is a modified post_deploy_runner with merge & upload removed.
# FULL SUITE
# This is separate from the POST DEPLOY due to the differences in tags & other additions we may need to make
#
require 'optimist'
require 'open3'
require 'pry'
require 'socket'
require 'httparty'

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

# Constructing the URL for failed API
server = 'http://cucumber.central-insurance.com:4000'
time_stamp = '20210822210024'
env = 'test'
app_name= 'PolicyAdminWeb'
api = "failure/get/#{time_stamp}/#{env}/#{app_name}"

url = "#{server}/#{api}"

response = HTTParty.get(url)

test_cases_arr = response.body

test_cases_arr.each do |feature|
  CMD = "bundle exec cucumber #{opts[:cuke]} -p parallel #{feature}"
  puts "Launching cucumber via: #{CMD}"
  stdout, stderr, status = Open3.capture3(CMD)
  puts "ERROR OUTPUT: \n #{stderr}\n\n" unless stderr.empty?
  puts "Test output: \n#{stdout}"
end

exit_code = /cucumbers Failed/i.match?(stderr) ? -1 : 0

puts "Exiting with status #{exit_code}"
exit exit_code
