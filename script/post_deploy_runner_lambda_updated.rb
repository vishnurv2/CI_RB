# frozen_string_literal: true
#
# POST_DEPLOY_RUNNER_LAMBDA
#
# #ruby $($script) --env="$($ENV:ENV)"
# --cuke="$($ENV:CUKE)" ( done )
# --reports="$($ENV:REPORTS)" ( done )
# --timestamp="$($TIMESTAMP)" ( done )
# --release="$($ENV:APPLICATION)" ( done )
#
# --platform="$($ENV:PLATFORM)"#
# --browser="$($ENV:BROWSER)"
# --buildno="$($BUILD_NO)"
# --browserversion="$($ENV:BROWSER_VERSION)"
#
# Description:
# This script is essential for TFS to execute parallel cucumber tests.
# This script can also be called from any of the batch scripts in the script directory
# Adjustments can be made to the actual cucumber call
#
# ruby script\post_deploy_runner_lambda.rb --env="TEST" --reports="\\vsqvwcucumber\Shared\reports" --timestamp="20210323142656" --cuke="-p test" --release="PolicyAdminWeb" --platform="win10" --browser="chrome" --buildno="ChromeDriverTest-11" --browserversion="latest"

require 'optimist'
require 'open3'
require 'pry'
require 'socket'

opts = Optimist.options do
  opt :env, 'Name of the env the suite was run in', type: :string, default: 'N/A'
  opt :cuke, 'Cucumber options', type: :string
  opt :changeset, 'The changeset number', type: :string, default: 'ManualTrigger'
  opt :reports, 'The folder to place the report files, use forward slashes.  Must have a slash at the end', type: :string, default: 'reports/'
  opt :threads, "The number of thread to run", type: :string, default: '5'
  opt :timestamp, "timestamp of the job start", type: :string
  opt :release, "which application is running", type: :string, default: 'Unknown'
  opt :platform, "which OS", type: :string, default: 'win10'
  opt :browser, "which browser", type: :string, default: 'chrome'
  opt :buildno, "lambda build number", type: :string
  opt :browserversion, "browser version", type: :string, default: 'latest'
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
ENV['RELEASE'] = "#{opts[:release]}"  # Special label just for the Reporting tool
ENV['RETRIES'] = opts[:retries]

# CONVERT - DEVL to dev until reporting tool is fixed.
newEnv = if opts[:env].downcase == 'devl'
           'dev'
         else
           opts[:env].downcase
         end

ENV['FILE_KEY'] = "#{Socket.gethostname.to_s}-#{opts[:timestamp]}-#{newEnv}"

Dir.chdir '..' if Dir.pwd =~ /script/

puts " "
puts "-----------Lookie here--------------"
puts "PCName: #{Socket.gethostname.to_s}"
puts "Platfrom: #{opts[:platform]}"
puts "Browser: #{opts[:browser]}"
puts "Build No: #{opts[:buildno]}"
puts "Browser version: #{opts[:browserversion]}"
puts "Reports: #{opts[:reports]}"
puts "Cuke: #{opts[:cuke]}"
puts "Env: #{opts[:env]}"
puts "Threads: #{opts[:threads]}"
puts "-----------Lookie here--------------"
puts " "

puts 'Installing gems'
system('bundle install')
puts " "

#AMN 4-26-2021 Progress Bar Testing
feature_folder = 'features/ui_validations'
begin
  require 'fileutils'
  feature_count = Dir.glob(File.join("./#{feature_folder}", '**', '*.feature')).select { |file| File.file?(file) }.count
  FileUtils.touch("#{opts[:reports]}/progress/starting-#{Socket.gethostname.to_s}-#{opts[:timestamp]}-#{opts[:env]}-#{feature_count}")
rescue
end


CMD = "bundle exec parallel_cucumber -n #{opts[:threads].to_i} --verbose -- #{opts[:cuke]} -p grid -p lambda_test -- #{feature_folder}"

#"bundle exec cucumber #{opts[:cuke]} -p grid -p lambda_test -p should_work -p parallel_lb PLATFORM=#{opts[:platform]} BROWSER=#{opts[:browser]} BUILD=#{opts[:buildno]} VERSION=#{opts[:browserversion]} #{feature_folder}"
##bundle exec cucumber -p $($ENV:ENV) -p grid -p lambda_test PLATFORM=$($ENV:PLATFORM) BROWSER=$($ENV:BROWSER) BUILD=$($BUILD_NO) VERSION=$($ENV:BROWSER_VERSION) features/personal_auto
# Below is a command line version to test.
##bundle exec cucumber -p test -p grid -p lambda_test -p should_work PLATFORM=win10 BROWSER=chrome BUILD=ChromeDriverTest-11 VERSION=latest features/personal_auto
#
puts "Launching cucumber via: #{CMD}"

stdout, stderr, status = Open3.capture3(CMD)

puts "ERROR OUTPUT: \n #{stderr}\n\n" unless stderr.empty?

# Check for failures
puts "Test output: \n#{stdout}"
exit_code = /cucumbers Failed/i.match?(stderr) ? -1 : 0

puts "Exiting with status #{exit_code}"
exit exit_code
