# frozen_string_literal: true

class PolicyManagementPage < BasePage
  page_url "#{Nenv.base_url}/PolicyAdminWeb/PL/account"

  div(:page_header_text, xpath: '//div[@id="pageTitleSubheader"]//div[contains(@class,"sub-headers")]/div')
  text_field(:search_box, id: 'headerSearchBar')
  button(:get_account_button, text: 'Get Account')
  section(:page_footer, PageFooter, xpath: '//app-cmi-footer/footer', how: :footer)

  link(:toggle_side_navbar_link, xpath: './/div[@id="Quotes"]//a[contains(@href,"/PL/") and not(contains(@href,"quote"))]', default_method: :click)
  li(:product_collapsed, xpath: './/div[@id="PersonalAutoProductSection"]/li[contains(@class, "aria-collapsed")]')

  link(:in_auto_link, xpath: './/div[@id="Quotes"]//a[contains(@href,"/PL/") and not(contains(@href,"quote"))]', default_method: :click)
  section(:left_nav, LeftNavbar, xpath: '//div[contains(@class, "sidebar-body")]') # LEFT nav bar

  button(:add_account_button, xpath: './/p-button[@id="addAccountButton"]/button')
  link(:issue_to_resolve, xpath: './/a[.//*[contains(text(), "Issues to Resolve")]]')
  link(:new_personal_account, xpath: './/a[.//*[contains(text(), "Add Personal Account")]]')
  link(:new_commercial_account, xpath: './/a[.//*[contains(text(), "Add Commercial Account")]]')
  div(:applicant_error_message, xpath: '//*[@id="toast-container"]/div/div')
  link(:applicant_name, xpath: '//p-table[@id="tblParties" or @id="grdPolicyApplicants"]//td[@data-label="Name"]//a')

  div(:user_avatar, class: 'user-avatar')
  button(:log_out, class: 'logout')

  section(:alerts_side_bar, AlertsSideBar, xpath: '//div[contains(@class,"alerts-sidebar")]')
  span(:bell, class: 'fa-bell', default_method: :click)
  #--- Modals ----#
  section(:e_options_modal, EOptionsModal, xpath: '//app-text-e-option/div') # renamed from e_options_modal
  section(:add_applicant_modal, AddApplicantModal, xpath: '//div[@role="dialog" and (.//div[contains(text(), "Is this applicant a contact?")] or .//label[contains(text(), "Is this applicant a contact?")] or .//div/span[contains(@class,"modal-title")])]')
  section(:add_product_modal, AddProductModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Add Product")]]')
  section(:auto_general_info_modal, AutoGeneralInfoModal, xpath: '//div[@role="dialog" and (.//div[contains(text(), "Rating State")] or .//div[contains(text(), "Rating State")])]')
  section(:applicant_prefill_modal, ApplicantPrefillModal, xpath: '//div[@role="dialog" and .//div/./span[contains(text(), "Applicants") or contains(text(), "Vehicles")]]')
  section(:driver_assignment_modal, AutoDriverAssignmentModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Driver Assignment")]]')
  section(:account_general_info_modal, AccountGeneralInfoModal, xpath: '//div[@role="dialog" and (.//div[contains(text(), "Agency")] or .//span[contains(text(), "Agency")])]')
  section(:auto_driver_modal, AutoDriverModal, xpath: '//div[@role="dialog" and (.//span[contains(text(), "Driver Info")] or .//span[contains(text(), "Driver Info")])]')
  section(:remove_driver_modal, RemoveDriverModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Remove Driver")]]')
  section(:auto_vehicle_modal, AutoVehicleModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Vehicle Info")]]') ## UGH - Instead of going off of Span Title, im keying off of Vehicle Info tab
  section(:new_personal_account_modal, NewPersonalAccountModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Log New Personal Account")]]')
  section(:billing_account_add_product_modal, BillingAccountAddProductModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Billing")]]')
  section(:auto_policy_coverages_modal, AutoPolicyLevelCoveragesModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Policy Level Coverages")]]')
  section(:auto_policy_optional_coverages_modal, AutoPolicyOptionalCoveragesModal, xpath: '//div[@role="dialog" and (.//span[contains(text(), "Policy Level Optional Coverages")])]')
  section(:existing_client_modal, ExistingClientModal, xpath: '//div[@role="dialog" and .//div/span = "Existing Account Found"]')
  section(:auto_vehicle_coverages_modal, AutoVehicleCoveragesModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Vehicle Info")]]')
  section(:premium_change_modal, PremiumChamgeModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Premium Change")]]')
  section(:other_vehicle_modal, OtherVehicleModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Vehicle Info")]]')
  section(:ready_to_begin_issuance_modal, ReadyToBeginIssuanceModal, xpath: '//div[@role="dialog" and .//div[contains(text(), "You are ready to begin issuance!")]]')
  section(:premium_modal, PremiumModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Total Auto premium") or contains(text(), "Total Watercraft premium") or contains(text(), "Quote")]]')
  section(:auto_prefill_modal, AutoPrefillModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Vehicles & Drivers Found")]]')
  section(:issues_to_resolve_modal, IssuesToResolveModal, xpath: '//div[contains(@class, "p-sidebar-content") and .//span[contains(text(), "Issues to Resolve")]]')
  section(:policy_change_issued_modal, PolicyChangeIssuedModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Policy Change Issued") or contains(text(), "Policy Changes Issued")]]')
  section(:advanced_search_modal, AdvancedSearchModal, xpath: '//div[@role="dialog" and .//*[contains(text(), "Advanced Search")]]')
  section(:log_activity_modal, LogActivityModal, xpath: '//div[@role="dialog" and .//div[contains(text(), "Log") or contains(text(), "Send Email")]]')
  section(:scheduled_property_classes_modal, ScheduledPropertyClassesModal, xpath: '//div[@role="dialog" and (.//div[contains(text(), "Select scheduled property classes to add to the product.")])]')
  section(:scheduled_property_policy_level_coverages_modal, ScheduledPropertyPolicyLevelCoveragesModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Policy Level Coverages")]]')
  section(:watercraft_operator_modal, WatercraftOperatorModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Watercraft  /  Drivers  / ")]]')
  #Activity Document Upload modals
  section(:insert_file_modal, InsertFileModal, xpath: '//div[@class="modal" and .//span[contains(text(), "Insert File")]]')
  section(:hull_and_motor_information_modal, HullAndMotorInformationModal, xpath: '//div[@class="modal" and .//span[contains(text(), "Hull and Motor")]]')

  #issuance modals
  section(:issue_policies_modal, IssuePoliciesModal, xpath: '//div[@role="dialog" and (.//span[contains(text(), "Select Products to Issue")] or .//span[contains(text(), "Issue Wizard")])]')
  section(:policy_distribution_modal, PolicyDistributionModal, xpath: '//div[@role="dialog" and .//div[contains(text(), "Policy Distribution")]]')
  section(:policies_issued_modal, PoliciesIssuedModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Policies Issued")]]')
  section(:cancel_non_renew_modal, CancelNonRenewModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Cancel  /  Non - Renew") or contains(text(), "Cancel")]]')
  section(:exposures_insured_modal, ExposuresInsuredModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Exposures Insured with Central")]]')
  section(:parcels_of_vacant_land_modal, ParcelsOfVacantLandModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Parcels of Vacant Land")]]')
  section(:exposures_insured_with_another_carrier_modal, ExposuresInsuredWithAnotherCarrierModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Exposures Insured with Another Carrier")]]')
  section(:agency_of_record_change_modal, AgencyOfRecordChangeModal, xpath: '//div[contains(@class,"p-dialog-content") and .//span[contains(text(),"Upload")]]')
  section(:thank_you_modal, ThankYouModal, xpath: '//app-modal-content[.//*[contains(text(), "You have begun") or contains(text(), "Thank")]]', how: :element)

  # Home modals
  section(:property_info_modal, PropertyInfoModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Property Information")]]')

  div(:processing_page_overlay, id: 'modalLoadingOverlay', visible: true)
  div(:modal_content, role: 'dialog', visible: true)
  section(:toast_container, ToastContainer, id: 'toast-container')

  #policy change modal
  section(:add_policy_change_modal, AddPolicyChangeModal, xpath: '//div[contains(@class,"p-dialog-content") and .//span[text()="Policy Change"]]')
  section(:edit_policy_change_modal, EditPolicyChangeModal, xpath: '//div[contains(@class,"p-dialog-content") and .//span[text()="Edit Policy Change"]]')
  section(:underwriting_referrals_modal, UnderwritingReferralsModal, xpath: '//div[contains(@class,"p-dialog-content") and .//span[text()="Underwriting Referrals"]]')
  section(:underlying_limit_confirmation_modal, UnderlyingLimitConfirmationModal, xpath: '//div[contains(@class,"p-confirm-dialog") and .//span[text()="Underlying Limit Confirmation"]]')
  section(:leave_page_confirmation_modal, LeavePageConfirmationModal, xpath: '//p-confirmdialog[@key="confirmChangeAccount"]//div[contains(@class,"p-confirm-dialog")]')
  ## Domestic abuse Insert files
  section(:insert_file_modal_domestic_abuse, InsertFileModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Insert File")]]')

  section(:add_domestic_abuse_flag_modal, AddDomesticAbuseFlagModal, xpath: '//span[contains(text(),"Add Domestic Abuse Flag")]/ancestor::div[@class="modal"]')
  section(:remove_domestic_abuse_flag_modal, RemoveDomesticAbuseFlagModal, xpath: '//span[contains(text(),"Remove Domestic Abuse Flag")]/ancestor::div[@class="modal"]')


  div(:one_inc_modal, id: /oneIncModal/)
  i(:issues_to_resolve_close_button, class: /sidebar-close-button pi pi-times/)

  section(:quote_snapshot_modal, QuoteSnapshotModal, xpath: '//div[@role="dialog" and .//div[contains(@class,"quote-snapshot")]]')
  section(:vehicles_and_drivers_found_modal, VehiclesAndDriversFoundModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Vehicles & Drivers Found")]]')
  section(:trailer_information_modal, TrailerInformationModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Trailer Information")]]')
  span(:premium_change_toast_message, xpath: '//div[contains(@class,"p-toast-message")]//span[contains(@class,"mr")]')
  b(:premium_change_view_details, xpath: '//div[contains(@class,"p-toast-message")]//b[contains(@class,"view-detail-link")]')
  button(:premium_change_toast_close, xpath: '//p-toastitem//button[contains(@class,"p-toast-icon-close")]')
  section(:order_reports_modal, OrderReportsModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "View & Order Reports")]]')
  section(:review_referrals_modal, ReviewReferralsModal, xpath: '//div[@role="dialog" and .//label[contains(text(),"Review Referrals")]]')
  section(:move_products_modal, MoveProductsModal, xpath: '//div[@role="dialog" and .//span[contains(text(),"Move Products")]]')

  def provide_card_details
    wait_for_processing_overlay_to_close
    if one_inc_modal?
      one_inc_modal_element.iframe.click
      one_inc_modal_element.iframe.text_field(:id, /NameOnCard/).set('FAKE CARD')
      one_inc_modal_element.iframe.text_field(:id, /CardNumber/).set('4111111111111111')
      one_inc_modal_element.iframe.text_field(:id, /SecurityCode/).set('123')
      one_inc_modal_element.iframe.button(text: /Continue/).click
      wait_for_overlay_no_ajax_wait
    end
  end

  def provide_checking_account_details
    wait_for_processing_overlay_to_close
    if one_inc_modal?
      one_inc_modal_element.iframe.click
      one_inc_modal_element.iframe.text_field(:id, /AccountHolderName/).set('FAKE CARD')
      one_inc_modal_element.iframe.text_field(:id, /RoutingNumber/).set('121042882')
      one_inc_modal_element.iframe.text_field(:id, /AccountNumber/).set('8273823454')
      one_inc_modal_element.iframe.text_field(:id, /ConfirmAccountNumber/).set('8273823454')
      one_inc_modal_element.iframe.button(text: /Save Bank Account/).click
      wait_for_overlay_no_ajax_wait
    end
  end

  def refresh_alerts
    # Keep this ONLY for UAT!
    #
    if Nenv.test_env == "uat"
      bell
      Watir::Wait.until { alerts_side_bar.present? }
      bell
      Watir::Wait.while { alerts_side_bar.present? }
    end
  end

  def wait_for_processing_overlay_to_close
    ## for now we need to wait 500ms for the overlay to even be even fired
    wait_for_ajax
    sleep 0.6
    Watir::Wait.until { !processing_page_overlay? }

    # raise_page_errors 'waiting for processing overlay to disappear'
    # # This looks up the OLD exception viewer
  end

  def wait_for_overlay_no_ajax_wait
    sleep 0.6
    Watir::Wait.until(timeout: 30) { !processing_page_overlay? }
  end

  def wait_for_processing_overlay_to_appear
    Watir::Wait.until { processing_page_overlay? }
  end

  def wait_for_processing_overlay
    return if Nenv.browser_brand == :chrome ## Watch out for this!!!

    wait_for_processing_overlay_to_appear
    wait_for_ajax
    wait_for_processing_overlay_to_close
    wait_for_ajax
  end

  def get_account(id)
    search_box_element.set(id)
    get_account_button
  end

  def toggle_side_navbar
    unless in_auto_link?
      toggle_side_navbar_link
    end
  end

  def toggle_quotes
    collapsed = left_nav.find_option("Quotes").attribute_value('class').split(" ")
    left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
  end

  def left_navigate_to(option)
    # toggle_side_navbar
    left_nav.navigate_to option
  end

  def left_navigate_to_if_not_on(left_nav_page_text)
    left_navigate_to(left_nav_page_text) unless left_nav.find_option(left_nav_page_text).active? # if page_h2.nil? || !page_h2.present?
  end

  def left_navigate_to_toggle(left_nav_page_text)
    toggle_quotes
    left_navigate_to(left_nav_page_text) unless left_nav.find_option(left_nav_page_text).active?
  end

  # Return all the elements containing validation error messages
  def field_validation_error_elements
    #divs(xpath: './/div[contains(@class, "invalid") or (contains(@class, "error"))]')
    elements(xpath: './/span[contains(@class, "invalid")] | .//div[contains(@class, "invalid") or (contains(@class, "error ")) or (contains(@class, "message-warn"))]')
  end

  # Returns an array of hashes with validation errors and the name of the field the reported on
  def field_validation_errors
    errors = field_validation_error_elements.map { |e| e.text.downcase }.reject { |e| e.empty? }
    exclude = "Please fill the required fields."

    if errors.include?(exclude)
      errors.delete(exclude)
    end

    errors
  end

  def select_new_account(account)
    case account.downcase
    when 'personal'
      new_personal_account
    when 'commercial'
      new_commercial_account
    else
      return
    end
  end

  ## The below methods are being used for the Route Helper ##
  def add_new_account(account)
    new_personal_account_modal.close_icon_element.click if new_personal_account_modal?
    clear_all_toasts
    add_account_button
    select_new_account(account)
  end

  def save_and_continue_personal_account
    new_personal_account_modal.save_and_continue if new_personal_account_modal.save_and_continue_element.present?
    new_personal_account_modal.create_account if new_personal_account_modal.create_account_element.present?
    wait_for_ajax
    msg = "Timed out waiting on saving the NEW PERSONAL ACCOUNT MODAL!\n\n"
    msg += "Automation caught the following alert message text: \n#{Toaster.errors.uniq.join("\n\n")}\n\n"
    Watir::Wait.until(timeout: Nenv.browser_timeout, message: msg) { !new_personal_account_modal? }
  end

  def save_and_begin_quote
    add_product_modal.save_and_begin_quote
    wait_for_ajax
    msg = "Timed out waiting on saving the SELECT PRODUCT MODAL!\n\n"
    msg += "Automation caught the following alert message text: \n#{Toaster.errors.uniq.join("\n\n")}\n\n"
    Watir::Wait.until(timeout: 40, message: msg) { !add_product_modal? }
  end

  def existing_account_or_new_account
    if existing_client_modal?
      existing_client_modal.save_and_continue
      wait_for_ajax
    end
  end

  def premium_modal_go_to_summary
    premium_modal.go_to_auto_summary if premium_modal?
  end

  ## End Route Helper methods ##

  section(:nav_bar, Navbar, id: 'primaryNav', how: :nav)
  section(:error_modal, ErrorModal, id: 'divErrorModal')
  section(:sidebar, SidebarMenu, how: :aside, id: 'sidebar')
  div(:server_validation_errors, class: 'validation-summary-errors')
  section(:account_summary_modal, AccountSummaryModal, xpath: '//div[@id="divModalContent" and .//div/h4 = "Account Summary - General Information"]')
  section(:package_discount_modal, PackageDiscountModal, xpath: '//div[@id="divModalContent" and .//input[@value = "AutoPackageDiscountOverrideModal"]]')
  section(:customer_loyalty_modal, CustomerLoyaltyModal, xpath: '//div[@id="divModalContent" and .//input[@value = "CustomerLoyaltyOverrideModal"]]')
  section(:discontinued_agency_modal, DiscontinuedAgencyModal, xpath: '//div[@class="modal-content" and .//div/h4[contains(text(), "Discontinued Agency")]]')
  section(:e_policy_modal, EPolicyModal, xpath: '//div[@id="divModalContent" and .//div/h4 = "E-policy"]')
  section(:policy_change_modal, PolicyChangeModal, xpath: '//div[@id="divModalContent" and .//div/h4[contains(text(), "Policy Change")]]')
  section(:underwriting_questions_modal, UnderwritingQuestionsModal, xpath: '//div[@id="divModalContent" and .//div/h4[contains(text(), "Underwriting Questions - ")]]')
  # section(:cancel_non_renew_modal, CancelNonRenewModal, xpath: '//div[@id="divModalContent" and .//div/h4[contains(text(), "Cancel / Non-Renew")]]')
  div(:modal_dialog, how: :element, xpath: './/p-dynamicdialog')
  div(:modal_masker, class: 'modal_masker', visible: true)
  div(:sidebar_masker, class: 'ui-sidebar-mask', visible: true)
  div(:modal_backdrop, class: 'modal-backdrop', visible: true)

  def policy_change_count
    left_nav.expand_collapsed_menu_items
    m = left_nav.menu_items.find { |mi| mi.text.downcase.include?('policy change') }
    return -1 if m.nil? || !m.text.include?('(') || !m.text.include?(')')
    return m.text.split('(').last.split(')').first
  end

  def discontinued_override_modal_present?
    discontinued_agency_modal? && discontinued_agency_modal.present?
  end

  def override_discontinued_agency(decision = 'yes')
    unless discontinued_override_modal_present?
      sleep(0.5)
      wait_for_ajax
    end
    discontinued_agency_modal.send(decision) if discontinued_override_modal_present?
    wait_for_modal_masker
  end

  def print_validation_table
    field_validation_errors.each do |k, v|
      STDOUT.puts "| #{k} | #{v} |"
    end
    nil
  end

  def wait_for_modal_to_close(modal_name)
    modal_close_timeout = 40
    err_message = "waiting for modal #{modal_name} to disappear - #{modal_close_timeout} seconds"
    err_message += "\n\nAutomation caught the following alert message text: \n#{Toaster.errors.uniq.join("\n\n")}\n\n"
    Watir::Wait.until(timeout: modal_close_timeout, message: err_message) { !send("#{modal_name}?") }

    ## did this funky check to skip this ajax wait.
    wait_for_ajax if modal_name.to_s != 'auto_general_info_modal'
    raise_page_errors err_message
  end

  def wait_for_modal_or_error
    Watir::Wait.until { modal_content? || errors? || field_validation_errors? }
    raise_page_errors
  end

  def wait_for_modal_or_error_take_picture
    #this is special for the vehicle modal thats having ajax problems
    opened = Watir::Wait.until { modal_content? || errors? || field_validation_errors? }

    unless opened
      AppErrorHelper.screenshot_error(nil, self)
    end
  end

  def wait_for_modal
    Watir::Wait.until { modal_content? }
  end

  def modals_gone?
    !modal_masker? && !sidebar_masker? && !modal_dialog? && !modal_backdrop? && !modal_content? && !processing_page_overlay?
  end

  def wait_for_modal_masker
    Watir::Wait.until { modals_gone? || errors? || field_validation_errors? }
    raise_page_errors
  end

  def wait_for_slideout_masker
    wait_for_modal_masker
  end

  def errors?
    error_modal? || server_validation_errors?
  end

  def field_validation_errors?
    begin
      field_validation_error_elements.count.positive?
    rescue
      return false
    end
  end

  def error_message
    return nil unless error_modal?

    { title: error_modal.title, body: error_modal.body }
  end

  def _ready?
    wait_for_ajax
    return true unless errors?

    raise_page_errors "Determining if #{self.class} is ready"
  end

  def displayed?
    !processing_page_overlay? && _ready?
  end

  def display_account_policy_number
    "\r\nAccount ID: #{BasePage.account_number}\r\nPolicy Activity ID: #{BasePage.policy_number}\r\n"
  end

  def raise_page_errors(context = nil)
    wait_for_ajax unless context.nil? == false && (context.downcase.include? 'ajax')
    # removing the server_validation_errors check because the driver assignment modal is
    # getting validation issues when modify is clicked and those are to be expected now
    return unless error_modal? # || server_validation_errors?

    _raise_message_with_context("Server validation errors exist: #{server_validation_errors}", context) if server_validation_errors?

    AppErrorHelper.screenshot_error(nil, self)
    exceptions = AppErrorHelper.lookup_exception_details.join("\n")
    msg = exceptions.empty? ? 'An unknown client error has occurred' : "An unknown client error has occurred.  The following exceptions may be the cause.: \n#{exceptions}"
    msg += display_account_policy_number

    _raise_message_with_context(msg, context)
  end

  def raise_page_loading(msg, time, opt)
    context = "\nERROR: TIMEOUT! \"#{opt}\" took #{time} seconds to load!\n"
    context += display_account_policy_number
    raise context
  end

  # Lines of business modal sequence
  AUTO_MODALS = %i[auto_general_info_modal applicant_prefill_modal auto_policy_coverages_modal auto_prefill_modal auto_vehicle_modal applicant_prefill_modal auto_driver_modal driver_assignment_modal].freeze
  HOME_MODALS = %i[auto_general_info_modal applicant_prefill_modal property_info_modal auto_policy_coverages_modal auto_policy_optional_coverages_modal].freeze
  UMBRELLA_MODALS = %i[auto_general_info_modal applicant_prefill_modal auto_policy_coverages_modal exposures_insured_modal].freeze
  WATERCRAFT_MODALS = %i[auto_general_info_modal applicant_prefill_modal auto_policy_coverages_modal hull_and_motor_information_modal watercraft_operator_modal].freeze
  SCHEDULED_PROPERTY_MODALS = %i[auto_general_info_modal applicant_prefill_modal scheduled_property_policy_level_coverages_modal scheduled_property_classes_modal].freeze
  DWELLING_MODALS = %i[auto_general_info_modal applicant_prefill_modal property_info_modal auto_policy_coverages_modal auto_policy_optional_coverages_modal].freeze

  def auto_modals
    AUTO_MODALS
  end

  def home_modals
    HOME_MODALS
  end

  def umbrella_modals
    UMBRELLA_MODALS
  end

  def watercraft_modals
    WATERCRAFT_MODALS
  end

  def scheduled_property_modals
    SCHEDULED_PROPERTY_MODALS
  end

  def dwelling_modals
    DWELLING_MODALS
  end

  # NOTE the auto vehicle tab ended next_modal with clicking the Coverages tab at the top? ( see that modals next_modal method )
  # auto_vehicle_coverages_modal  << this was what was after auto vehicle modal. BUT this is not complete yet.

  def _pause_if_needed
    return unless Nenv.cuke_step?

    STDOUT.puts "\n\nPress enter to continue"
    STDIN.gets
  end

  def populate_auto_policy_modals(last_modal = :driver_assignment_modal, mode = :close_when_done, type = 'auto')
    # modified to default to auto, use Routehelper to pass in "Home"
    send("#{type}_modals").each do |modal_name|
      STDOUT.puts " Now populating the: #{modal_name}\n\n"
      # binding.pry if modal_name == :auto_driver_modal && Nenv.cuke_debug?

      next if _should_skip_modal(modal_name)
      break if _should_stop_populating(modal_name, last_modal, mode)

      modal = populate_modal(modal_name)

      _pause_if_needed
      break if _should_exit_populating_without_save(modal_name, last_modal, mode)

      modal.send(_save_method_for_modal(modal_name, last_modal))

      # auto_general_info_modal.dismiss if auto_general_info_modal?
      wait_for_modal_to_close(modal_name)
      break if modal_name == last_modal
    end
  end

  def _should_stop_populating(modal_name, last_modal, mode)
    (modal_name == last_modal) && mode == :up_to
  end

  def _should_exit_populating_without_save(modal_name, last_modal, mode)
    (modal_name == last_modal) && mode != :close_when_done
  end

  def _save_method_for_modal(modal_name, last_modal)
    modal_name == last_modal ? :save_and_close : :next_modal
  end

  def populate_modal(modal_name)
    modal = send(modal_name)
    begin
      modal.populate

    rescue Exception => ex
      # rubocop:disable Lint/Debugger
      binding.pry if Nenv.cuke_debug?
      # rubocop:enable Lint/Debugger
      raise_page_errors "while populating #{modal_name}"
      raise "#{ActiveSupport::SafeBuffer.new(ex.message)} raised while populating #{modal_name}"
    end
    modal
  end

  private

  def _should_skip_modal(modal_name)
    %i[auto_general_info_modal applicant_prefill_modal driver_assignment_modal auto_prefill_modal auto_vehicle_modal].each do |modal|
      return true if modal_name == modal && !send("#{modal}?")
    end

    false
  end

  def _raise_message_with_context(msg, context)
    msg = "#{msg} context #{context}" if context
    raise msg
  end
end
