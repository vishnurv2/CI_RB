# frozen_string_literal: true

class ExtendedTransportationDetailsSection < BaseSection


  # ------ Everything below this line is unverified ------------------------------------- #
  #
  label(:personal_limit, xpath: './/span[@id="ExtendedTransportationAutoPlusCoverageExpenseCoverageLimitValueLabel"]/../..//label')
  label(:enhanced_limit, xpath: './/span[@id="ExtendedTransportationSignatureAutoCoverageExpenseCoverageLimitValueLabel"]/../..//label')
end

class PropertyPanel < BasePanel
  span(:edit, class: /fa-pencil/)
end

class ScheduledPropertyPanel < BasePanel
  span(:edit, class: /fa-pencil/)
end

class MessageCardPanel < BasePanel
  link(:add_a_party, xpath: './/b[text()="Add a Party"]/..')
end

class AutoPolicySummaryPage < PolicyManagementPage

  div(:policy_summary_h4, xpath: '//div[contains(@class,"sub-headers")]')

  section(:general_info_panel, AutoGeneralInfoPanel, xpath: './/p-panel/div[.//*[contains(text(), "General Information")]]', how: :div)

  section(:applicants_panel, ApplicantsPanel, xpath: '//app-view-party-list/div', how: :div)

  section(:account_summary_applicants_panel, ApplicantsPanel, xpath: '//app-account-summary//app-view-party-list/div', how: :div)
  section(:policy_coverages_panel, AutoPolicyCoveragesPanel, xpath: './/p-panel/div[.//*[contains(text(), "Policy Level Coverages")]]', how: :div)
  section(:policy_optional_coverages_panel, AutoOptionalCoveragesPanel, xpath: './/p-panel/div[.//*[contains(text(), "Policy Level Optional Coverages")]]', how: :div)
  section(:vehicle_info_panel, AutoVehicleInformationPanel, xpath: '//app-auto-vehicle-summary/div', how: :div)
  section(:driver_info_panel, AutoDriverInformationPanel, xpath: '//app-view-driver-summary/div', how: :div)
  section(:driver_assignment_panel, AutoDriverAssignmentPanel, xpath: '//app-driver-assignment/div', how: :div)
  section(:scheduled_property_classes_and_items_panel, ScheduledPropertyClassesPanel, xpath: './/p-panel/div[.//*[contains(text(), "Scheduled Classes and Items")]]')

  select(:other_than_collision_deductible, id: /OtherThanCollision/)
  span(:quote_premium, id: 'quotePremium')
  span(:quote_number, xpath: '//div[contains(@class,"p-card-body")]//span[contains(text(),"Q-04218")]')
  div(:policy_number, xpath: '//div[contains(@class, "page-title")]/div/div')

  button(:issue, xpath: './/p-button[@id="beginIssuance"]/button')
  section(:issue_wizard_modal, IssueWizardModal, xpath: './/app-modal-content[.//span[contains(text(), "Issue Wizard")]]', how: :element)

  span(:view_trailer, xpath: './/span[contains(text()," View Trailer ")]')
  span(:view_vehicle, xpath: './/span[contains(text()," View Vehicle ")]')
  i(:right_arrow, xpath: './/i[contains(@class,"pi-chevron-right")]')
  th(:identification_num, xpath: './/thead//th[contains(text(),"Year/Make/Model")]/following-sibling::th')


  #UMBRELLA
  section(:exposures_insured_with_central_panel, ExposuresInsuredWithCentralPanel, xpath: './/p-panel/div[.//*[contains(text(), "Exposures Insured With Central")]]', how: :div )
  section(:exposures_insured_with_another_carrier_panel, ExposuresInsuredWithAnotherCarrierPanel, xpath: './/p-panel/div[.//*[contains(text(), "Exposures Insured With Another Carrier")]]', how: :div )
  section(:umbrella_policy_coverages_panel, UmbrellaAutoPolicyCoveragesPanel, xpath: './/p-panel/div[.//*[contains(text(), "Coverage Information")]]', how: :div )

  #WATERCRAFT
  section(:watercraft_optional_coverages_panel, WatercraftOptionalCoveragesPanel, xpath: './/p-panel/div[.//*[contains(text(), "Optional Coverages")]]', how: :div)
  section(:watercraft_coverages_panel, WatercraftCoveragesPanel, xpath: './/p-panel/div[.//*[contains(text(), "Optional Coverages")]]', how: :div)
  section(:watercraft_operators_panel, WatercraftOperatorsPanel, xpath: './/p-panel/div[.//*[contains(text(), "Watercraft Drivers")]]', how: :div)
  section(:watercraft_vehicle_panel, WatercraftVehiclePanel, xpath: './/p-panel/div[.//*[contains(text(), "Hull")]]', how: :div)

  #Actions
  button(:actions_menu, xpath: '//div[contains(@class,"action-menu hide-on-sm")]//p-button[@label="Actions"]/button')
  link(:do_not_issue, xpath: '//span[text()="Do Not Issue / Archive Quote"]/..')
  link(:add_note, xpath: '//span[text()="Add Note"]/..')
  link(:log_activity, xpath: '//span[text()="Log Activity"]/..')
  link(:send_email, xpath: '//span[text()="Send Email"]/..')
  link(:transfer_product_to_another_account, xpath: '//span[text()="Transfer Product to Another Account"]/..')
  link(:delete_quote, xpath: '//span[text()="Delete Quote"]/..')
  link(:begin_issuance, xpath: './/span[text()="Begin Application"]/..')
  div(:action_menu_list, xpath: '//div[contains(@class,"action-menu p-menu")]')
  link(:new_quote, xpath: '//span[text()="New Quote"]/..')
  link(:report_a_claim, xpath: '//span[text()="Report a Claim"]/..')
  link(:flag_for_domestic_abuse, xpath: '//span[text()="Flag for domestic abuse"]/..')
  link(:remove_domestic_abuse_flag, xpath: '//span[text()="Remove Domestic Abuse Flag"]/..')
  link(:move_products_to_another_account, xpath: '//span[text()="Move Product(s) to Another Account"]/..')
  link(:move_product_to_another_account, xpath: '//span[text()="Move Product to Another Account"]/..')
  link(:save_quote, xpath: '//span[text()="Save Quote"]/..')
  link(:view_and_order_reports, xpath: '//span[text()="View & Order Reports"]/..')
  link(:edit_policy_change, xpath: '//span[text()="Edit Policy Change"]/..')

  div(:invalid_vin_alert, class: ["toast-message", "ng-star-inserted"])
  link(:create_policy_change, xpath: '//span[text()="Create Policy Change"]/..')
  select(:filter_view_dropdown, xpath: '//div[contains(text(), "View")]/..//p-dropdown')
  section(:review_and_submit_policy_change, ReviewAndSubmitPolicyChange, xpath: '//div[@role="dialog" and .//span[contains(text(), "Review & Submit Policy Change")]]')
  span(:hover_changed_timestamp, xpath: './/span[contains(@id,"changedTimestamp")]')
  span(:hover_changedBy, xpath: './/span[contains(@id,"changedBy")]/span')
  button(:issue_policy_change, xpath: '//p-button[@label="Issue Policy Change"]/button')
  link(:view_policy_declaration, xpath: '//span[text()="View Policy Declaration"]/..')
  link(:view_id_card, xpath: '//span[text()="View ID Card"]/..')
  link(:view_edit_policy_distribution, xpath: '//span[text()="View/Edit Policy Distribution"]/..')
  link(:reprint_policy_declaration, xpath: '//span[text()="Reprint Policy Declaration"]/..')
  link(:cancel_non_renew, xpath: '//span[text()="Cancel / Non-Renew"]/..')
  div(:open_policy_changes_heading, xpath: './/div[contains(text(), "Open Policy Changes")]')

  #HOME
  section(:property_panel, PropertyPanel, xpath: '//app-view-property-info/div')

  #Scheduled Property
  section(:scheduled_property_panel, ScheduledPropertyPanel, xpath: './/p-panel/div[.//*[contains(text(), "Policy Level Coverages")]]')

  #Dwelling
  section(:dwelling_optional_coverages_panel, DwellingOptionalCoveragesPanel, xpath: './/p-panel/div[.//*[contains(text(), "Optional Coverages")]]', how: :div)

  section(:message_card_panel, MessageCardPanel, xpath: './/div[contains(@class, "custom-message-card")]')

  div(:message_regarding_fees, xpath: '//app-premium-card//div[contains(@class,"p-card-content")]//div[contains(@class,"font-caption")]')


  span(:premium_snapshot_endorsement, xpath: '//app-premium-card//div[contains(@class,"p-card-content")]//span[contains(text(),"END")]')
  span(:premium_snapshot_total_premium, xpath: '//app-premium-card//div[@class="p-card-content"]//span[contains(text(),"Total IN - Auto Premium")]')
  span(:premium_snapshot_new_premium, xpath: '//app-premium-card//div[@class="p-card-content"]//span[contains(text(),"New IN - Auto Premium")]')
  span(:premium_snapshot_paid_in_full, xpath: '//app-premium-card//div[@class="p-card-content"]//span[contains(text(),"Paid in Full")]')
  span(:premium_snapshot_issue_policy, xpath: '//app-premium-card//div[@class="p-card-content"]//button//span[contains(text(),"Issue Policy")]')
  span(:premium_snapshot_begin_application, xpath: '//app-premium-card//div[@class="p-card-content"]//button//span[contains(text(),"Begin Application")]')
  span(:premium_snapshot_view_quote, xpath: '//app-premium-card//div[@class="p-card-content"]//button//span[contains(text(),"View Quote")]')
  span(:premium_snapshot_current_payment_due, xpath: '//app-premium-card//div[@class="p-card-content"]//span[contains(text(),"Current Payment Due")]')
  span(:premium_snapshot_current_payment_due_date, xpath: '//app-premium-card//div[@class="p-card-content"]//span[contains(text(),"Current Payment Due Date")]')
  span(:premium_snapshot_make_payment, xpath: '//app-premium-card//div[@class="p-card-content"]//button//span[contains(text(),"Make a Payment")]')
  span(:premium_snapshot_payment_history, xpath: '//app-premium-card//div[@class="p-card-content"]//button//span[contains(text(),"View Payment History")]')
  span(:premium_snapshot_current_annual_premium, xpath: '//app-premium-card//div[@class="p-card-content"]//span[contains(text(),"Current Payment Due")]')
  span(:premium_snapshot_difference, xpath: '//app-premium-card//div[@class="p-card-content"]//span[contains(text(),"Difference")]')
  span(:premium_snapshot_issue_policy_change, xpath: '//app-premium-card//div[@class="p-card-content"]//button//span[contains(text(),"Issue Policy Change")]')
  span(:premium_snapshot_view_changes_summary, xpath: '//app-premium-card//div[@class="p-card-content"]//button//span[contains(text(),"View Summary of Changes")]')

  def navigate_issue_wizard
    issue unless issue_wizard_modal.present?
    Watir::Wait.until(message: 'Timed Out After 30 Seconds Waiting for the Issue Wizard Modal to Appear') { issue_wizard_modal.present? }
    issue_wizard_modal.navigate(billing_account_add_product_modal)
  end

  def navigate_issue_wizard_annual
    issue unless issue_wizard_modal.present?
    Watir::Wait.until(message: 'Timed Out After 30 Seconds Waiting for the Issue Wizard Modal to Appear') { issue_wizard_modal.present? }
    issue_wizard_modal.navigate_annual(billing_account_add_product_modal)
  end

  def displayed?
    browser.url.include?('PolicyAdminWeb/personal/')
  end

  def vehicles
    vehicle_info_panel.scroll.to
    vehicle_info_panel.vehicles
  end

  def property
    property_panel.scroll.to :center
  end

  def applicants
    applicants_panel.scroll.to
    applicants_panel.applicants
  end

  def umbrella_coverage
    umbrella_policy_coverages_panel.scroll.to :center
  end

  def open_policy_optional_coverages
    scroll.to :center
    policy_optional_coverages_panel.modify unless auto_policy_optional_coverages_modal?

    # auto_policy_optional_coverages_modal.handle_bool_coverage('Manual Coverage', true) # taking this out in angular suite, manual coverage should not be set to true every time the policy coverages are opened
  end

  # ------ Everything below this line is unverified ------------------------------------- #


  section(:ext_trans_details, ExtendedTransportationDetailsSection, xpath: '//div[contains(@class,"selectedCoverage") and .//label[text()="Extended Transportation"]]')
  div(:client_package_address, id: 'clientPackageAddress', default_method: nil)


  def edit_first_vehicle_otc_coverage
    vehicle_info_panel.vehicles.first.edit
    auto_vehicle_modal.tabs.active_tab='Coverage'
    wait_for_ajax
    other_than_collision_deductible.click # added a click to get the index
    index = other_than_collision_deductible.selected_index - 1
    index = 2 if index < 0
    other_than_collision_deductible.select(index)
    # panel1 = auto_vehicle_coverages_modal.panel_obj_for_coverage('Towing & Labor')
    # if panel1.present? && auto_vehicle_coverages_modal.coverages_list.coverage_selected?('Towing & Labor')
    #   panel = auto_vehicle_coverages_modal.panel_obj_for_coverage('Extended Transportation')
    #   panel.scroll.to
    #   panel1.total_limit_per_disablement_element.click
    #   panel1.total_limit_per_disablement = 1
    # end
    auto_vehicle_coverages_modal.save_and_close
  end

  def populate_general_info(save = false)
    auto_general_info_modal.populate
    return unless save

    auto_general_info_modal.save_and_close
    Watir::Wait.until { !auto_general_info_modal? }
    wait_for_ajax
  end


  def close_general_info
    Watir::Wait.until { auto_general_info_modal.dismiss_element.present? }
    auto_general_info_modal.dismiss
    Watir::Wait.until(timeout: 90) { !auto_general_info_modal? }
  end

  def client_name
    client_package_address.span(id: 'clientName', index: 0).text.strip
  end

  def client_address
    client_package_address.span(id: 'clientName', index: 1).text.strip
  end

  def _ready?
    wait_for_ajax
    sleep(1) if modal_backdrop?
    modal_backdrop? || applicants_panel?
  end

  def try_open_other_vehicle_modal
    # checking modal presence multiple times in case state changes
    try_edit_first_other_vehicle
    sleep(2) unless auto_vehicle_coverages_modal.present? || other_vehicle_modal.present?
    try_edit_first_other_vehicle
  end

  def try_edit_first_other_vehicle
    return if auto_vehicle_coverages_modal.present? || other_vehicle_modal.present?

    vehicle_info_panel.other_vehicles_element.scroll.to
    vehicle_info_panel.other_vehicles.first.edit
  end

  def open_other_vehicle_coverages
    try_open_other_vehicle_modal
    Watir::Wait.until { other_vehicle_modal.present? }
    Watir::Wait.until { !other_vehicle_modal.territory.include? 'select' }
    other_vehicle_modal.tabs.active_tab = 'Coverage' if other_vehicle_modal.present?
    Watir::Wait.until { auto_vehicle_coverages_modal.manual_coverages_element.present? }
    #auto_vehicle_coverages_modal.handle_bool_coverage('Manual Coverage', true) # im not sure why this all of a sudden started failing?
    auto_vehicle_coverages_modal.manual_coverage=true
  end

  def try_open_auto_vehicle_modal
    # checking modal presence multiple times in case state changes
    try_edit_first_vehicle
    sleep(2) unless auto_vehicle_coverages_modal.present? || auto_vehicle_modal.present?
    try_edit_first_vehicle
  end

  def try_edit_first_vehicle
    return if auto_vehicle_coverages_modal.present? || auto_vehicle_modal.present?

    vehicle_info_panel.vehicles_element.scroll.to
    vehicle_info_panel.vehicles.first.edit_element.click!
  end

  def open_vehicle_coverages
    try_open_auto_vehicle_modal
    auto_vehicle_modal.tabs.active_tab = 'Coverage' if auto_vehicle_modal.present?
    auto_vehicle_coverages_modal.handle_bool_coverage('Manual Coverage', true)
  end

  def auto_general_info_modal_present?
    auto_general_info_modal? && auto_general_info_modal.present?
  end

  def remove_last_driver_using_trash
    return unless driver_info_panel.drivers_element.present?

    return if driver_info_panel.drivers.count <= 1

    driver_info_panel.drivers.last.delete
    remove_driver_modal.remove
  end

  def resolve_issues_to_resolve(fixture_file = 'auto_policy_none_combined_none_adjusted')
    #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
    RubyExcelHelper.safe_load_fixture_file(fixture_file)
    applicants_panel.applicants.first.edit
    add_applicant_modal.populate_with(data_for('issues_to_resolve'))
    add_applicant_modal.save_and_close
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
