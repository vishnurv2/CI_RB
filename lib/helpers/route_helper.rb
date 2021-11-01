# frozen_string_literal: true

EDSL::PageObject::Visitation.routes = {
  default: [[LoginPage, :populate]],
  auto: [[PolicyManagementPage, :add_new_account, 'personal'],
         [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
         [PolicyManagementPage, :save_and_continue_personal_account],
         [PolicyManagementPage, :existing_account_or_new_account],
         [PolicyManagementPage, :populate_modal, 'add_product_modal'],
         [PolicyManagementPage, :save_and_begin_quote],
         [AutoPolicySummaryPage, :populate_auto_policy_modals]],
  home: [[PolicyManagementPage, :add_new_account, 'personal'],
         [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
         [PolicyManagementPage, :save_and_continue_personal_account],
         [PolicyManagementPage, :existing_account_or_new_account],
         [PolicyManagementPage, :populate_modal, 'add_product_modal'],
         [PolicyManagementPage, :save_and_begin_quote],
         [AutoPolicySummaryPage, :populate_auto_policy_modals, :auto_policy_optional_coverages_modal, :close_when_done, 'home']],
  umbrella: [[PolicyManagementPage, :add_new_account, 'personal'],
             [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
             [PolicyManagementPage, :save_and_continue_personal_account],
             [PolicyManagementPage, :existing_account_or_new_account],
             [PolicyManagementPage, :populate_modal, 'add_product_modal'],
             [PolicyManagementPage, :save_and_begin_quote],
             [AutoPolicySummaryPage, :populate_auto_policy_modals, :exposures_insured_modal, :close_when_done, 'umbrella']],
  watercraft: [[PolicyManagementPage, :add_new_account, 'personal'],
               [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
               [PolicyManagementPage, :save_and_continue_personal_account],
               [PolicyManagementPage, :existing_account_or_new_account],
               [PolicyManagementPage, :populate_modal, 'add_product_modal'],
               [PolicyManagementPage, :save_and_begin_quote],
               [AutoPolicySummaryPage, :populate_auto_policy_modals, :hull_and_motor_information_modal, :close_when_done, 'watercraft']],
  scheduled_property: [[PolicyManagementPage, :add_new_account, 'personal'],
                       [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
                       [PolicyManagementPage, :save_and_continue_personal_account],
                       [PolicyManagementPage, :existing_account_or_new_account],
                       [PolicyManagementPage, :populate_modal, 'add_product_modal'],
                       [PolicyManagementPage, :save_and_begin_quote],
                       [AutoPolicySummaryPage, :populate_auto_policy_modals, :scheduled_property_classes_modal, :close_when_done, 'scheduled_property']],
  dwelling: [[PolicyManagementPage, :add_new_account, 'personal'],
             [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
             [PolicyManagementPage, :save_and_continue_personal_account],
             [PolicyManagementPage, :existing_account_or_new_account],
             [PolicyManagementPage, :populate_modal, 'add_product_modal'],
             [PolicyManagementPage, :save_and_begin_quote],
             [AutoPolicySummaryPage, :populate_auto_policy_modals, :auto_policy_optional_coverages_modal, :close_when_done, 'dwelling']],
  start_umbrella: [[PolicyManagementPage, :add_new_account, 'personal'],
                   [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
                   [PolicyManagementPage, :save_and_continue_personal_account],
                   [PolicyManagementPage, :existing_account_or_new_account],
                   [PolicyManagementPage, :populate_modal, 'add_product_modal'],
                   [PolicyManagementPage, :save_and_begin_quote]],
  start_watercraft: [[PolicyManagementPage, :add_new_account, 'personal'],
                     [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
                     [PolicyManagementPage, :save_and_continue_personal_account],
                     [PolicyManagementPage, :existing_account_or_new_account],
                     [PolicyManagementPage, :populate_modal, 'add_product_modal'],
                     [PolicyManagementPage, :save_and_begin_quote]],
  start_home: [[PolicyManagementPage, :add_new_account, 'personal'],
               [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
               [PolicyManagementPage, :save_and_continue_personal_account],
               [PolicyManagementPage, :existing_account_or_new_account],
               [PolicyManagementPage, :populate_modal, 'add_product_modal'],
               [PolicyManagementPage, :save_and_begin_quote]],
  start_dwelling: [[PolicyManagementPage, :add_new_account, 'personal'],
                   [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
                   [PolicyManagementPage, :save_and_continue_personal_account],
                   [PolicyManagementPage, :existing_account_or_new_account],
                   [PolicyManagementPage, :populate_modal, 'add_product_modal'],
                   [PolicyManagementPage, :save_and_begin_quote]],
  start_scheduled_property: [[PolicyManagementPage, :add_new_account, 'personal'],
                   [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
                   [PolicyManagementPage, :save_and_continue_personal_account],
                   [PolicyManagementPage, :existing_account_or_new_account],
                   [PolicyManagementPage, :populate_modal, 'add_product_modal'],
                   [PolicyManagementPage, :save_and_begin_quote]],
  old_auto: [[AccountEntryPage, :populate], [AccountEntryPage, :save_and_continue],
             [AutoPolicySummaryPage, :populate_auto_policy_modals]],
  incomplete_auto: [[AccountEntryPage, :populate], [AccountEntryPage, :save_and_continue],
                    [AutoPolicySummaryPage, :close_general_info]],
  start_policy: [[PolicyManagementPage, :add_new_account, 'personal'],
                 [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
                 [PolicyManagementPage, :save_and_continue_personal_account],
                 [PolicyManagementPage, :existing_account_or_new_account],
                 [PolicyManagementPage, :populate_modal, 'add_product_modal'],
                 [PolicyManagementPage, :save_and_begin_quote]],
  auto_to_cmi: [[PolicyManagementPage, :add_new_account, 'personal'],
                [PolicyManagementPage, :populate_modal, 'new_personal_account_modal'],
                [PolicyManagementPage, :save_and_continue_personal_account],
                [PolicyManagementPage, :existing_account_or_new_account],
                [PolicyManagementPage, :populate_modal, 'add_product_modal'],
                [PolicyManagementPage, :save_and_begin_quote],
                [AutoPolicySummaryPage, :populate_auto_policy_modals],
                [PolicyManagementPage, :premium_modal_go_to_summary],
                [PolicyManagementPage, :left_navigate_to, 'Quote Management'],
                [PolicyManagementPage, :left_navigate_to, 'Referrals']],
  old_auto_to_cmi: [[AccountEntryPage, :populate], [AccountEntryPage, :save_and_continue],
                    [AutoPolicySummaryPage, :populate_auto_policy_modals],
                    [PolicyManagementPage, :left_navigate_to, 'Quote Options'],
                    [PolicyManagementPage, :left_navigate_to, 'CMI Employees']]
}

# Contains routes that are too complicated for the normal routing
class RouteHelper
  include Singleton
  include DataMagic
  include EDSL::PageObject::Visitation

  def self.method_missing(message, *args, &block)
    RouteHelper.instance.send(message, *args, &block)
  end

  attr_accessor :browser

  def login_if_needed
    visit(LoginPage)
    url = @browser.url
    visit(LoginPage).populate unless url.include?("/PolicyAdminWeb/PL/account") || url.include?("/PolicyAdminWeb/PL/auto") || url.include?("/PolicyAdminWeb/dashboard")
    @browser.refresh
    visit(PolicyManagementPage)
  end

  def login_with_creds
    Helpers::Fixtures.load_fixture('valid_creds')
    login_if_needed
  end

  def navigate_to_existing_account(id = nil)
    login_if_needed
    id ||= data_for('existing_account')['id']
    url = "#{Nenv.base_url}/PolicyAdminWeb/PL/account/#{id}"
    @browser.goto(url)
    on(AccountSummaryPage).ready? # Trigger a ready check
  end

  def navigate_to_existing_account_get_account_button(id = nil)
    login_if_needed
    id ||= data_for('existing_account')['id']
    on(PolicyManagementPage) do |page|
      page.get_account(id)
      page.left_nav.navigate_to('Account Summary')
    end
    on(AccountSummaryPage).when_ready # Trigger a ready check
  end

  def navigate_to_existing_auto(id = nil)
    login_if_needed
    id ||= data_for('existing_auto_policy')['id']
    url = "#{Nenv.base_url}/PolicyAdminWeb/PL/auto/#{id}"
    @browser.goto(url)
    on(AutoPolicySummaryPage) do |page|
      page.ready? # Trigger a ready check  since we got here without using page navigation
      page.auto_general_info_modal.dismiss if page.auto_general_info_modal?
    end
  end

  def add_applicant_to_existing(applicant = nil, id = nil)
    navigate_to_existing_account(id)
    applicant ||= data_for('additional_applicant')
    on(AccountSummaryPage) do |page|
      page.applicants_panel.add_applicant
      page.wait_for_processing_overlay_to_close
      modal = page.add_applicant_modal
      modal.populate_with(applicant)
      modal.save_and_close
      page.raise_page_errors
    end
    applicant
  end

  # ------ Everything below this line is unverified ------------------------------------- #

  def partial_auto_policy(last_modal, mode = :close_when_done)
    RouteHelper.login_if_needed
    navigate_all(using: :start_policy, visit: true)
    on(AutoPolicySummaryPage) do |page|
      page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode)
    end
  end

  def partial_home_policy(last_modal, mode = :close_when_done)
    RouteHelper.login_if_needed
    navigate_all(using: :start_home, visit: true)
    on(AutoPolicySummaryPage) do |page|
      page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'home')
    end
  end


  def partial_dwelling_policy(last_modal, mode = :close_when_done)
    RouteHelper.login_if_needed
    navigate_all(using: :start_dwelling, visit: true)
    on(AutoPolicySummaryPage) do |page|
      page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'dwelling')
    end
  end

  def partial_umbrella_policy(last_modal, mode = :close_when_done)
    RouteHelper.login_if_needed
    navigate_all(using: :start_umbrella, visit: true)
    on(AutoPolicySummaryPage) do |page|
      page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'umbrella')
    end
  end

  def combined_umbrella_policy(last_modal, mode = :close_when_done, product)
    on(AutoPolicySummaryPage) do |page|
     if product == 'umbrella'
       page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'umbrella')
       page.wait_for_processing_overlay_to_close
     elsif product == 'homeowners'
       page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'home')
       page.wait_for_processing_overlay_to_close
       elsif product == 'dwelling'
         page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'dwelling')
       page.wait_for_processing_overlay_to_close
     elsif product == 'watercraft'
       page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'watercraft')
       page.wait_for_processing_overlay_to_close
     end
   end
  end

  def partial_watercraft_policy(last_modal, mode = :close_when_done)
    RouteHelper.login_if_needed
    navigate_all(using: :start_watercraft, visit: true)
    on(AutoPolicySummaryPage) do |page|
      page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'watercraft')
    end
  end

  def partial_scheduled_property_policy(last_modal, mode = :close_when_done)
    RouteHelper.login_if_needed
    navigate_all(using: :start_scheduled_property, visit: true)
    on(AutoPolicySummaryPage) do |page|
      page.populate_auto_policy_modals(last_modal.snakecase.to_sym, mode, type = 'scheduled_property')
    end
  end

  def swagger_url
    return "http://proteus.cmiprog.com/PolicyApi/swagger/ui/index" if Nenv.test_env == 'dev'
    return "http://styx.cmiprog.com/PolicyApi/swagger/ui/index" if Nenv.test_env == 'test'
  end

  def swagger_policy_api_url
    return "http://proteus.cmiprog.com/PolicyApiCore/swagger/index.html" if Nenv.test_env == 'dev'
    return "http://styx.cmiprog.com/PolicyApiCore/swagger/index.html" if Nenv.test_env == 'test'
  end

  def swagger_authorization_url
    return "http://proteus.cmiprog.com/authorizationserver/swagger/index.html" if Nenv.test_env == 'dev'
    return "http://styx.cmiprog.com/authorizationserver/swagger/index.html" if Nenv.test_env == 'test'
  end
end
