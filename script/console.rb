# frozen_string_literal: true

module CentralConsole
  # Add our lib folder to the library search path
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")

  require 'framework_support'
  require 'console'
  Faker::Config.locale = 'en-US'
  EDSL::PageObject::Visitation.routes = {
    default: [[LoginPage, :populate]],
    auto: [[AccountEntryPage, :populate], [AccountEntryPage, :save_and_continue],
           [AutoPolicySummaryPage, :populate_auto_policy_modals]],
    incomplete_auto: [[AccountEntryPage, :populate], [AccountEntryPage, :save_and_continue],
                      [AutoPolicySummaryPage, :close_general_info]],
    start_policy: [[AccountEntryPage, :populate], [AccountEntryPage, :save_and_continue]]
  }

  Helpers::PathHelper.create_paths
  extend EDSL::PageObject::Visitation
  include DataMagic

  # Make sure we're talking to the correct server
  [AccountAPI, PolicyAPI].each do |api|
    api.configure do |config|
      config.host = Nenv.api_host
    end
  end

  EDSL::PageObject::JavascriptFrameworkFacade.framework = :jquery
  EDSL::PageObject::Population.fixture_fetcher = :data_for

  #@browser ||= Helpers::Browser.create_browser
  #@browser.window.move_to(Nenv.browser_x, Nenv.browser_y)
  #@browser.window.resize_to(Nenv.browser_width, Nenv.browser_height)

  Helpers::Fixtures.load_fixture('valid_creds')

  #RouteHelper.login_if_needed

  binding.pry
  #console_test
end
