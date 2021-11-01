# frozen_string_literal: true

Given(/^I have files to clean$/) do
  #find the path first:
  @path = File.expand_path('../..')
  files = Dir.glob("#{@path}/accounts/*.#{Nenv.instance.test_env}")
  @count = files.count
  STDOUT.puts "FILE COUNT: #{@count}"
end


Then(/^I remove the accounts from the system$/) do
  files = Dir.glob("#{@path}/accounts/*.#{Nenv.instance.test_env}")
  if @count >= 1
    files.each do |file|
      STDOUT.puts "Cleaning up accounts listed in file: #{file}"
      CleanupHelper.post_run_cleanup(file, @token)
    end
  else
    STDOUT.puts 'NO files available!'
  end
end
