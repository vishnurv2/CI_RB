# frozen_string_literal: true

# Add our lib folder to the library search path
$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../../lib")

require 'framework_support'

Mail.defaults do
  delivery_method :smtp, address: 'exchange.central-insurance.com'
end

# See RouteHelper for routes

Faker::Config.locale = 'en-US'

Helpers::PathHelper.create_paths

World(EDSL::PageObject::Visitation)
World(DataMagic)

EDSL::PageObject::JavascriptFrameworkFacade.framework = :jquery
EDSL::PageObject::Population.fixture_fetcher = :data_for

if Nenv.use_allure_reports.include? 'true'
  Allure.configure do |config|
    if Nenv.grid_reports.include? 'true'
      config.results_directory = "//vsqvwcucumber01/Shared/allure/#{Nenv.test_env.upcase}/allure-report"
      config.clean_results_directory = false
    else
      config.results_directory = "reports/allure-results"
      config.clean_results_directory = true
    end
    config.logging_level = Logger::DEBUG
  end

  AllureCucumber.configure do |config|
    config.tms_prefix = 'TestCaseKey='
    # # these are used for creating links to bugs or test cases where {} is replaced with keys of relevant items
    # config.link_tms_pattern = "http://www.jira.com/browse/{}"
    # config.link_issue_pattern = "http://www.jira.com/browse/{}"
  end
end


# rubocop:disable Lint/Debugger
binding.pry if Nenv.cuke_env_debug?
# rubocop:enable Lint/Debugger

Watir.default_timeout = Nenv.implicit_wait.to_i
