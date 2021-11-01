# frozen_string_literal: true

# rubocop:disable Style/GlobalVars

if Nenv.cuke_profile?
  require 'ruby-prof'
  profile = RubyProf::Profile.new(exclude_common: true)

  profile.exclude_methods!(Watir::ElementCollection, :to_a)
  profile.exclude_methods!(Watir::Logger, :info)
  profile.exclude_methods!(Cucumber)
  profile.exclude_methods!(Selenium::WebDriver::Logger, :info)
  profile.exclude_methods!(Cucumber::Runtime, :formatters)
  profile.exclude_methods!(Cucumber::Runtime, :report)
  profile.exclude_methods!(Cucumber::Configuration, :on_event)

  # profile the code
  profile.start
end

Before do |scenario|

  @scenario_name = scenario.name
  tags = scenario.send(scenario.respond_to?(:tags) ? :tags : :source_tags).map(&:name)
  BasePage.account_number = 'None Yet'
  BasePage.policy_number = 'None Yet'
  AppErrorHelper.new_scenario

  CleanupHelper.allow_registration = tags.include?('@delete_when_done')

  $browser ||= Helpers::Browser.create_browser(scenario) unless tags.include?('@no_browser')
  @browser = $browser

  # Excel Data Driven using redis as a cache
  if Nenv.use_excel_data.include?('true')
    begin
      use_redis_server = Nenv.use_redis_server.include? 'true'
      redis_key_present = RubyExcelHelper.redis_has_key?(tags)

      if use_redis_server && redis_key_present
        redis_excel_data = RubyExcelHelper.get_from_redis_cache(tags)
        DataMagic.yml = redis_excel_data
        STDOUT.puts "REDIS: Loaded excel data for scenario: #{scenario.name}"
      else
        @excel = RubyExcelHelper.fetch_global_excel_data
        key_present = RubyExcelHelper.excel_has_key?(tags)
        if key_present
          excel_data = RubyExcelHelper.load_excel_data_for(tags)
          DataMagic.yml = excel_data
          STDOUT.puts "EXCEL: Loaded Data for scenario: #{scenario.name}"
        end
      end
    rescue Exception => ex
      STDERR.puts "#{ex.message} raised in Excel Data Driven Before hook"
      exit!
    end
  else
    Helpers::Fixtures.load_fixtures_for(scenario)
  end

  # JSON Data for Parallel Testing
  if Nenv.use_json_data
    key_present = tags.any? { |x| x.include?('@json') }
    if key_present
      @json_data = JsonDataHelper.load_json_for(tags)
      count = 3
      while @json_data.nil? && count > 0
        @json_data = JsonDataHelper.load_json_for(tags)
        count = count - 1
        #TODO: Band_aid_fix - need a better way to make the program wait
        sleep(1)
      end
    end
  end

  if Nenv.cuke_trace?
    require 'tracer'

    Tracer.add_filter do |*_rest|
      file.include?('cucumber_suite') || file.include?('edsl')
    end

    STDOUT.puts 'starting trace'
    Tracer.on
  end

  @scenario_start_time = Time.now
rescue Exception => ex
  puts "#{ex.message} raised in before hook"
end

After do |scenario|
  # AMN 4-26-2021 Tracking Test Run Progress Per Scenario
  require 'fileutils'
  require 'digest/sha1'
  scenario_name_hash = Digest::SHA1.hexdigest(scenario.name)

  folder = "#{Nenv.report_dir}/progress"
  unless Dir.exist?(folder)
    Dir.mkdir(folder)
    #else
    #  Dir.foreach(folder) do |f|
    #    File.delete(File.join(folder, f)) if f != '.' && f != '..'
    #  end
  end
  f_name = 'didnt_begin'
  begin
    f_name = Nenv.file_key
  rescue
    f_name = 'failed'
  end
  f_name += '-' + scenario_name_hash
  fs = scenario.failed? ? 'f' : 's'
  retry_count = 0
  begin
    (Nenv.retries.to_i + 1).times do
      full_file_path = "#{folder}/#{f_name}-#{retry_count}-#{Nenv.retries}-#{fs}"
      if (!File.exist?(full_file_path))
        FileUtils.touch(full_file_path)
        break
      end
      retry_count += 1
    end
  rescue
    FileUtils.touch("#{folder}/#{f_name}-#{Nenv.retries}-#{fs}")
  end

  @total_thread_run_time ||= 0
  @total_scenario_time = Time.now - @scenario_start_time
  @total_thread_run_time += @total_scenario_time

  STDOUT.puts "\"#{scenario.name}\" took #{@total_scenario_time} seconds, failed: #{scenario.failed?}"
  STDOUT.puts "total thread time: #{@total_thread_run_time}, thread id: #{Thread.current.object_id}"

  if scenario.failed? && $browser
    if $browser.alert.exists?
      $browser.alert.close
      exceptions = AppErrorHelper.lookup_exception_details.join("\n")
      msg = exceptions.empty? ? 'An unexpected alert has occurred' : "An unexpected alert has occurred.  The following exceptions may be the cause.: \n#{exceptions}"
      STDOUT.puts msg
      puts msg
    end

    AppErrorHelper.record_error_details($browser) #old exception viewer
    filename = AppErrorHelper.screenshot_error(scenario, EDSL::PageObject::Visitation.current_page)

    if Nenv.embed_screenshots
      # embed base 64 png image into json output
      embed(filename, 'image/png') if filename
    else
      # embed screenshot location to save space, minus .png extension
      embed(File.basename(filename, ".*"), 'text/plain') if filename
    end

    # embed the account url for the dashboard.
    embed("#{$browser.url}", 'text/plain')
  end

  # rubocop:disable Lint/Debugger
  binding.pry if scenario.failed? && Nenv.cuke_debug?
  # rubocop:enable Lint/Debugger

  unless Nenv.keep_browser?
    $browser&.close
    $browser = nil
  end
rescue Exception => ex
  STDERR.puts "#{ex.message} raised in after hook #{ex.backtrace.join("\n")}"
end

AfterStep('@pause') do |_result, _test_step|
  #if Nenv.cuke_step?
  #STDOUT.puts "\n\nPress enter to continue"
  #STDIN.gets
  #end
  answer = 'n'
  begin
    Timeout.timeout 1 do
      # wait for a second for user to press 'p'
      answer = STDIN.gets
    end
  rescue Timeout::Error # answer is 'n' when no key is pressed during 1 second
  end

  STDIN.gets if answer == 'p' # wait until user presses any key
end

AfterConfiguration do |config|
  config.on_event :test_run_finished do |_event|
    CleanupHelper.mark_for_cleanup
    $browser&.close
    if Nenv.cuke_profile?
      result = profile.stop
      printer = RubyProf::GraphHtmlPrinter.new(result)
      puts 'Storing profile results'
      File.open('profile_data.html', 'w') { |file| printer.print(file, min_percent: 2) }
      # printer.print(STDOUT, {})
    end

    Tracer.off if Nenv.cuke_trace?
  end
rescue Exception => ex
  puts "#{ex.message} raised in AfterConfiguration hook"
end

# rubocop:enable Style/GlobalVars
