# frozen_string_literal: true

require 'chauffeur'

# Helper modules should all live in the helper namespace.
module Helpers
  module Browser
    # High level function for creating a browser. Uses env variables to determine what to do.
    #
    # @param scenario [Cucumber:Scenario]
    #
    def self.create_browser(scenario = nil)
      update_chrome_driver_windows if Nenv.auto_update_chromedriver == 'true'
      Chauffeur.add_drivers_to_path unless Nenv.use_local_chrome_driver == 'true'

      # do special lamda browser stuff here.
      RouteHelper.browser = if Nenv.browser_type.to_s == 'lambda'
                              # platform ||= ENV['PLATFORM']
                              # browser_name ||= ENV['BROWSER']
                              # build ||= ENV['BUILD']
                              # version ||= ENV['VERSION']
                              #network ||= ENV['NETWORK']
                              #visual ||= ENV['VISUAL']
                              #video ||= ENV['VIDEO']
                              #console ||= ENV['CONSOLE']
                              #tunnel ||= ENV['TUNNEL']

                              create_lambda_browser(scenario)
                            else
                              send("create_#{Nenv.browser_type}_browser", scenario)
                            end

      AppErrorHelper.browser = RouteHelper.browser
    end

    # Saves job status in Sauce Labs
    #
    # @param scenario [Cucumber:Scenario] The Cucumber scenario that just completed.
    #
    # @param browser [Watir::Browser]A Watir browser.  Used to pull session_id
    #
    def self.save_sauce_status(scenario, browser)
      job_fn = scenario.passed? ? 'pass_job' : 'fail_job'
      SauceWhisk::Jobs.send(job_fn, browser.driver.send(:bridge).session_id)
    end

    # Creates a Sauce Labs browser.
    # Called by #create_browser when BROWSER_TYPE == :sauce
    #
    # @param scenario [Cucumber:Scenario] The scenario name and feature name will be used as the session name.
    #
    def self.create_sauce_browser(scenario)
      scenario ||= _mock_scenario
      caps = sauce_caps(scenario)
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = Nenv.sauce_client_timeout

      Watir::Browser.new(:remote, url: Nenv.sauce_url, desired_capabilities: caps, http_client: client)
    end

    # Testing Lambda ***
    # TO:DO move things to nenv_vars, add param for build increment
    # DONT FORGET - We need their ssh Tunnel: https://www.lambdatest.com/support/docs/underpass-tunnel-application/
    # Get the username and token from the Profile on thier Dashboard UI
    def self.create_lambda_browser(scenario)

      caps = Selenium::WebDriver::Remote::Capabilities.new
      caps[:browserName] = ENV['BROWSER'].nil? ? 'Chrome' : ENV['BROWSER']
      caps[:version] = ENV['VERSION'].nil? ? 'latest' : ENV['VERSION']
      caps[:platform] = ENV['PLATFORM'].nil? ? 'Windows 10' : ENV['PLATFORM']
      caps[:name] = "#{scenario.feature.name} - #{scenario.name}"
      caps[:build] = ENV['BUILD'].nil? ? 'Manual_Trigger_LambdaTest_chrome' : ENV['BUILD']
      caps[:network] = false
      caps[:visual] = false
      caps[:video] = true
      caps[:console] = true
      caps[:tunnel] = true
      #caps[:tunnelName] = 'Underpass Tunnel'

      url = "https://#{Nenv.lambda_username}:#{Nenv.lambda_tokan}@#{Nenv.lambda_url}"

      browser = Watir::Browser.new(:remote, :url => url, :capabilities => caps)

      browser
    end

    # Creates new watir browser object
    # @param brand - browser brand, :chrome,  :firefox
    # @param args - optional browser specific arguments
    def self.create_new_browser(brand, args = nil)
      #Watir::Browser.new(brand, args: args)
      prefs = {
        download: {
          'prompt_for_download' => false,
          'default_directory' => Nenv.download_dir.gsub('/', '\\')
        }
      }

      Watir::Browser.new :chrome, options: { prefs: prefs }
    end

    def self.ignore_certificates
      Selenium::WebDriver::Remote::Capabilities.firefox(accept_insecure_certs: true)
    end

    def self.firefox_profile
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile.assume_untrusted_certificate_issuer = false
      profile
    end

    # Creates a local browser.
    # Called by #create_browser when BROWSER_TYPE == :local
    #
    # @param _scenario [Cucumber:Scenario] Not currently used
    #
    def self.create_local_browser(_scenario = nil)
      browser = if Nenv.headless?
                  _create_headless_browser
                else
                  if Nenv.browser_brand.to_s == 'firefox'
                    capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(accept_insecure_certs: true)
                    create_new_browser(Nenv.browser_brand, capabilities)
                  elsif Nenv.browser_brand.to_s == 'chrome'
                    chrome_args = [] # ['--auto-open-devtools-for-tabs']
                    create_new_browser(Nenv.browser_brand, chrome_args)
                  else
                    create_new_browser(Nenv.browser_brand)
                  end
                end
      # browser.driver.manage.timeouts.implicit_wait = 0.3
      set_browser_pos(browser)
      set_browser_size(browser) unless Nenv.headless?
      browser
    end

    def self._create_browser_with_cache
      user_data_path = 'C:\Users\user_name\AppData\Local\Google\Chrome\User Data'
      user_data_path = user_data_path.sub 'user_name', ENV['USERNAME']
      profile_path = 'user-data-dir=' + user_data_path
      chrome_args = [profile_path]
      browser = Watir::Browser.new(Nenv.browser_brand, args: chrome_args)
      browser
    end

    def self._create_headless_browser
      # headless originally had 1920 x 3000 by Donavan
      chrome_args = ['--window-size=1900,950', '--disable-logging', '--log-level=3']
      browser = Watir::Browser.new(Nenv.browser_brand, args: chrome_args, headless: true)
      browser.wd.download_path = Nenv.download_dir
      browser
    end

    # Set the passed browser to the screen position specified in the
    # BROWSER_X and BROWSER_Y env vars
    #
    # @param browser [Watir::Browser] - The browser to reposition
    def self.set_browser_pos(browser)
      browser.window.move_to(Nenv.browser_x, Nenv.browser_y) if Nenv.move_browser?
    end

    # Resize the passed browser to the dimensions specified in the
    # BROWSER_WIDTH and BROWSER_HEIGHT env vars
    # Note: Setting BROWSER_RESOLUTION to something like '1920x1080'
    # also works since it gets parsed by Nenv if the other two
    # do not exist.
    #
    # @param browser [Watir::Browser] - The browser to reposition
    def self.set_browser_size(browser)
      browser.window.resize_to(Nenv.browser_width, Nenv.browser_height) if Nenv.size_browser?
    end

    # Creates a selenium hub browser - DESKTOP mode
    # Called by #create_browser when BROWSER_TYPE == :selenium_hub
    #
    # @param _scenario [Cucumber:Scenario] Not currently used
    #
    def self.create_selenium_hub_browser(_scenario = nil)
      browser = if Nenv.headless_grid?
                  _create_selenium_hub_headless_browser
                else
                  STDOUT.puts ' ------- WELCOME TO THE GRID ----------'
                  ## HACK until we change the args array in the future.
                  if Nenv.browser_brand.to_s == 'firefox'
                    Watir::Browser.new(:remote, url: Nenv.selenium_hub_url, browser: Nenv.browser_brand, desired_capabilities: ignore_certificates)
                  else
                    Watir::Browser.new(:remote, url: Nenv.selenium_hub_url, browser: Nenv.browser_brand)
                  end
                end
      set_browser_pos(browser)
      set_browser_size(browser) unless Nenv.headless_grid?
      browser
    end

    # Creates Selenium GRID headless remote
    # Chrome and Firefox only.
    # Called by -p headless_grid
    def self._create_selenium_hub_headless_browser
      STDOUT.puts ' ------- WELCOME TO THE GRID HEADLESS ----------'
      ## HACK for now
      if Nenv.browser_brand.to_s == 'firefox'
        STDOUT.puts "Using Firefox Headless"
        options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
        browser = Watir::Browser.new(:remote, url: Nenv.selenium_hub_url, browser: Nenv.browser_brand, desired_capabilities: ignore_certificates, options: options)
      else
        chrome_args = ['--window-size=1920,3000', '--disable-logging', '--log-level=3']
        STDOUT.puts "Using Chrome Headless"
        browser = Watir::Browser.new(:remote, url: Nenv.selenium_hub_url, browser: Nenv.browser_brand, args: chrome_args, headless: true)
      end

      set_browser_pos(browser)
      set_browser_size(browser) unless Nenv.headless_grid?
      browser
    end

    # Simple helper function for building a Sauce Labs caps file
    # It pulls the values from the environment mostly
    # however it uses the name of the feature and scenario
    # as the session name for sauce.
    def self.sauce_caps(scenario)
      {
        version: Nenv.sauce_version,
        browserName: Nenv.browser_brand,
        platform: Nenv.sauce_platform,
        name: "#{scenario.feature.name} - #{scenario.name}",
        screenResolution: Nenv.browser_resolution
      }
    end

    def self._mock_scenario
      require 'ostruct'
      OpenStruct.new(name: 'Console Scenario', feature: OpenStruct.new(name: 'Console Feature'))
    end

    def self.update_chrome_driver_windows
      chrome = Webdrivers::Chromedriver.chrome_version
      latest_chrome = Webdrivers::Chromedriver.latest_version
      Webdrivers.cache_time = 86_400
      Webdrivers.install_dir = './drivers/chromedriver/win32'
      Webdrivers::Chromedriver.update
    end

    def self.create_zalenium_browser

      caps = {
        :browserName => 'chrome',
      }

      url = Nenv.selenium_hub_url

      # browser = Watir::Browser.new(:remote, url: url, browser: Nenv.browser_brand, desired_capabilities: caps)
      browser = Selenium::WebDriver.for(:remote,
                                        :url => url,
                                        :desired_capabilities => caps)
      browser
    end

  end

end
