# frozen_string_literal: true

# This file defines the various environment variables used by the suite.
#
# We define Nenv methods for many environment variables where we want to
# provide a default value if the env var is missing.
#
# See the documentation for details on the various env vars that can be
# used to tune the framework.
#
require 'nenv'
require 'socket'

# Namespace for all helpers
module Helpers
  # Cucumber doesn't require files it loads them... multiple times
  # We only want to do this once so we'll just see if Nenv responds to our method already
  unless Nenv.respond_to? :test_env
    # These constants represent defaults for, or in some cases keys for, the Nenv methods below
    ENV_KEY          = 'TEST_ENV' # What enviroment variable holds our runtime environment?
    DEFAULT_TEST_ENV = 'test' # What should the default TEST_ENV be?

    DEFAULT_CONFIG_PATH = "#{Dir.pwd}/config" # Where should Helpers::Config load it's yml data

    DEFAULT_BROWSER_TYPE         = :local # What should the default BROWSER_TYPE be?
    DEFAULT_BROWSER_BRAND        = :chrome # What should the default BROWSER_BRAND be?
    DEFAULT_BROWSER_RESOLUTION   = '1900x900' # What should the default BROWSER_RESOLUTION be? 1280 x 1024 old  1900x900
    DEFAULT_SAUCE_CLIENT_TIMEOUT = 180 # What should the default SAUCE_CLIENT_TIMEOUT be?

    DEFAULT_SELENIUM_HUB_HOST = '192.168.55.54' # What should the default host be for Selenium hub
    DEFAULT_SELENIUM_HUB_PORT = 4444 # What should the default port be for Selenium hub

    DEFAULT_FIXTURE_ROOT = 'fixtures' # Default folder for fixture files

    DEFAULT_SERVER_HOST = 'localhost'
    DEFAULT_SERVER_PORT = 8080

    DEFAULT_BROWSER_TIMEOUT = 40

    DEFAULT_DOWNLOAD_DIR = "#{Dir.pwd}/downloads"
    DEFAULT_REPORT_DIR = "#{Dir.pwd}/reports"

    # Trying to keep local development screenshots to local dirs
    DEFAULT_SCREENSHOT_DIR = if Socket.gethostname.to_s[0..2].downcase === 'vsq'
                               "//vsqvwcucumber01/Shared/screenshots"
                             else
                               "#{Dir.pwd}/screenshots"
                             end

    DEFAULT_DOCUMENT_DIR = if Socket.gethostname.to_s[0..2].downcase === 'vsq'
                             "//vsqvwcucumber01/Shared/documents"
                           else
                             "#{Dir.pwd}/downloads"
                           end

    EMBED_SCREENSHOTS = false # change to TRUE to embed base64 screenshots in json output

    LAMBDA_USERNAME = ENV['LT_USERNAME']
    LAMBDA_ACCESS_TOKEN = ENV['LT_ACCESS_KEY']
    LAMBDA_URL = "hub.lambdatest.com/wd/hub"

    DEFAULT_LOG_DIR = "#{Dir.pwd}/logs"
    DEFAULT_BASE_URL = 'http://neptune.cmiprog.com'

    DEFAULT_IMPLICIT_WAIT = 30
    DEFAULT_AJAX_WAIT = 30

    ENV_HOSTS = { dev: 'neptune.cmiprog.com', test: 'pluto.cmiprog.com', local: '192.168.55.54:4200',
                  uat: 'pisces.central-insurance.com', ci: 'vsqvwdocker01:8081' }.freeze
    API_HOSTS = { dev: 'proteus.cmiprog.com', test: 'styx.cmiprog.com', local: 'proteus.cmiprog.com',
                  uat: 'cetus.central-insurance.com', ci: 'vsqvwdocker01:8082' }.freeze

    USE_BROWSER_CACHE = 'true'

    USE_LOCAL_CHROMEDRIVER = 'false'
    AUTO_UPDATE_CHROMEDRIVER = 'false'

    # Excel data for data driven approach
    USE_EXCEL_DATA = 'true'

    EXCEL_DATA_STATE = 'IN'
    EXCEL_DATA_LINE = 'Personal Lines'
    EXCEL_DATA_PRODUCT = 'Auto'

    # JSON Data
    USE_JSON_DATA = 'true'

    # Redis Server
    USE_REDIS_SERVER = 'true'

    REDIS_SERVER = 'vsqvwcucumber01.central-insurance.com'
    REDIS_SERVER_PORT = '6379'

    # Allure Reporting
    USE_ALLURE_REPORTS = 'false'

    GRID_REPORTS = 'false'
    GRID_REPORT_FOLDER = "//vsqvwcucumber01/Shared/allure/TEST/allure-report"
    GRID_RESULTS_FOLDER = "//vsqvwcucumber01/Shared/allure/TEST/allure-results"

    Nenv.instance.create_method(:file_key) { |v| v.nil? ? 'default_file_key' : v }

    # Stuff that tunes the framework
    Nenv.instance.create_method(:config_path) { |v| v.nil? ? DEFAULT_CONFIG_PATH : v.tr('\\', '/') }
    Nenv.instance.create_method(:fixture_root) { |v| v.nil? ? DEFAULT_FIXTURE_ROOT : v.tr('\\', '/') }

    Nenv.instance.create_method(:implicit_wait) { |v| v.nil? ? DEFAULT_IMPLICIT_WAIT : v.to_i }
    Nenv.instance.create_method(:wait_for_ajax_time) { |v| v.nil? ? DEFAULT_AJAX_WAIT : v.to_i }

    # Stuff that changes based on the runtime environment for the app
    Nenv.instance.create_method(:test_env) { Nenv.send(ENV_KEY) || DEFAULT_TEST_ENV }

    #weird hack for now - Pluto is only env that has HTTPS currently
    HTTP = if Nenv.test_env == 'test'
             'https'
           else
             'http'
           end

    Nenv.instance.create_method(:base_url) { |v| v.nil? ? "#{HTTP}://#{ENV_HOSTS[Nenv.test_env.to_sym]}" : v }
    Nenv.instance.create_method(:api_host) { |v| v.nil? ? API_HOSTS[Nenv.test_env.to_sym] : v }
    Nenv.instance.create_method(:api_url) { |v| v.nil? ? "http://#{API_HOSTS[Nenv.test_env.to_sym]}" : v }
    Nenv.instance.create_method(:yml_env) { |v| v.nil? ? Nenv.test_env : v }

    # Stuff for creating browsers
    Nenv.instance.create_method(:browser_type) { |v| v.nil? ? DEFAULT_BROWSER_TYPE : v.to_sym }
    Nenv.instance.create_method(:browser_brand) { |v| v.nil? ? DEFAULT_BROWSER_BRAND : v.to_sym }
    Nenv.instance.create_method(:browser_resolution) { |v| v.nil? ? DEFAULT_BROWSER_RESOLUTION : v }
    Nenv.instance.create_method(:browser_width) { Nenv.browser_resolution.split('x').first.to_i }
    Nenv.instance.create_method(:browser_height) { Nenv.browser_resolution.split('x').last.to_i }
    Nenv.instance.create_method(:browser_x, &:to_i)
    Nenv.instance.create_method(:browser_y, &:to_i)

    # Sauce labs config
    Nenv.instance.create_method(:sauce_url) { |v| v.nil? ? Config.instance[:sauce_labs][:url] : v }
    Nenv.instance.create_method(:sauce_platform) { |v| v.to_s.tr('_', ' ') }
    Nenv.instance.create_method(:sauce_client_timeout) { |v| v.nil? ? DEFAULT_SAUCE_CLIENT_TIMEOUT : v.to_i }

    # Selenium hub config
    Nenv.instance.create_method(:selenium_hub_host) { |v| v.nil? ? DEFAULT_SELENIUM_HUB_HOST : v }
    Nenv.instance.create_method(:selenium_hub_port) { |v| v.nil? ? DEFAULT_SELENIUM_HUB_PORT : v.to_i }
    Nenv.instance.create_method(:selenium_hub_url) { |v| v.nil? ? "http://#{Nenv.selenium_hub_host}:#{Nenv.selenium_hub_port}/wd/hub" : v }

    # Output Paths
    Nenv.instance.create_method(:download_dir) { |v| v.nil? ? DEFAULT_DOWNLOAD_DIR : v }
    Nenv.instance.create_method(:documents_dir) { |v| v.nil? ? DEFAULT_DOCUMENT_DIR : v }
    Nenv.instance.create_method(:report_dir) { |v| v.nil? ? DEFAULT_REPORT_DIR : v }
    Nenv.instance.create_method(:screenshot_dir) { |v| v.nil? ? DEFAULT_SCREENSHOT_DIR : v }
    Nenv.instance.create_method(:embed_screenshots) { |v| v.nil? ? EMBED_SCREENSHOTS : v }
    Nenv.instance.create_method(:log_dir) { |v| v.nil? ? DEFAULT_LOG_DIR : v }

    # Lambda
    Nenv.instance.create_method(:lambda_username) { |v| v.nil? ? LAMBDA_USERNAME : v }
    Nenv.instance.create_method(:lambda_tokan) { |v| v.nil? ? LAMBDA_ACCESS_TOKEN : v }
    Nenv.instance.create_method(:lambda_url) { |v| v.nil? ? LAMBDA_URL : v }

    # Timeout
    Nenv.instance.create_method(:browser_timeout) { |v| v.nil? ? DEFAULT_BROWSER_TIMEOUT : v.to_i }

    # Use cache for fast loading of Angular website
    Nenv.instance.create_method(:use_local_chrome_driver) { |v| v.nil? ? USE_LOCAL_CHROMEDRIVER : v.to_bool }
    Nenv.instance.create_method(:auto_update_chromedriver) { |v| v.nil? ? AUTO_UPDATE_CHROMEDRIVER : v.to_bool }

    # Use excel data and respective files instead of old fixture files
    Nenv.instance.create_method(:use_excel_data) { |v| v.nil? ? USE_EXCEL_DATA : v }
    Nenv.instance.create_method(:excel_data_state) { |v| v.nil? ? EXCEL_DATA_STATE : v }
    Nenv.instance.create_method(:excel_data_product) { |v| v.nil? ? EXCEL_DATA_PRODUCT : v }
    Nenv.instance.create_method(:excel_data_line) { |v| v.nil? ? EXCEL_DATA_LINE : v }

    # Use json data and respective files
    Nenv.instance.create_method(:use_json_data) { |v| v.nil? ? USE_JSON_DATA : v.to_bool }

    # Use redis server for excel data caching
    Nenv.instance.create_method(:use_redis_server) { |v| v.nil? ? USE_REDIS_SERVER : v }
    Nenv.instance.create_method(:redis_server) { |v| v.nil? ? REDIS_SERVER : v }
    Nenv.instance.create_method(:redis_server_port) { |v| v.nil? ? REDIS_SERVER_PORT : v }

    # Allure reports
    Nenv.instance.create_method(:use_allure_reports) { |v| v.nil? ? USE_ALLURE_REPORTS : v }
    Nenv.instance.create_method(:grid_reports) { |v| v.nil? ? GRID_REPORTS : v }
    Nenv.instance.create_method(:grid_report_folder) { |v| v.nil? ? GRID_REPORT_FOLDER : v }
    Nenv.instance.create_method(:grid_results_folder) { |v| v.nil? ? GRID_RESULTS_FOLDER : v }

  end
end
