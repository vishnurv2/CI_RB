# frozen_string_literal: true

And(/^I add a policy change and specify the effective date$/) do
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    @found_product = page.product_list.products.first
    @original_status ||= @found_product.status
    @found_product.policy_info_btn
    @found_product.create_policy_change
    page.wait_for_processing_overlay_to_close
    modal = page.add_policy_change_modal
    modal.date.span(text: 'Specify Date').click
    modal.specific_date = Chronic.parse('1 days from now').to_date.strftime('%m/%d/%Y')
    # modal.specific_date_text = Date.today + 1
    modal.description_element.click
    modal.description = 'Updated effective date'
    modal.date.span(text: 'Specify Date').click # trying something here
    sleep(0.6)
    modal.save_and_continue_button
    page.wait_for_ajax
  end
end

And(/^I click to open the auto general info modal$/) do
  on(PolicyManagementPage) do |page|
    header = on(AutoPolicySummaryPage)
    unless header.policy_summary_h4.include? 'IN - Auto'
      if page.left_nav.find_option("Policies").present?
        collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
        page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"
      else
        collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
        page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
      end
      menu_item = page.left_nav.find_option_containing('IN - Auto')
      menu_item.click unless menu_item.active?
    end
  end
  on(AutoPolicySummaryPage) do |page|
    @browser.scroll.to :top # hack for now as navigating to IN auto is covering the button
    page.wait_for_ajax
    page.general_info_panel.modify
    if page.add_policy_change_modal?
      page.wait_for_modal_or_error
      page.add_policy_change_modal.save_and_continue_button
      page.wait_for_ajax
      page.general_info_panel.modify
    end
  end
end

Then(/^I should be able to validate that the effective date and expected date is disabled$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_general_info_modal
    expect(modal.effective_date_element.disabled?).to be_truthy, "Expected the Expected date on the auto general info modal to be disabled but it was enabled"
    expect(modal.expiration_date_element.disabled?).to be_truthy, "Expected the Expiration date on the auto general info modal to be disabled but it was enabled"
    modal.save_and_close
  end
end

Then(/^I should be able to validate that the transfer information options are disabled for the Agent$/) do
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "IN - Auto"
      page.left_nav.navigate_to('IN - Auto')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Auto')
  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    modal.modify
    modal = page.auto_general_info_modal
    modal.formal_transfer_question_element.scroll.to
    expect(modal.formal_transfer_question_element.child.attribute('class').include?('disabled-group')).to be_truthy, "Expected the Formal transfer question on the auto general info modal to be disabled but it was enabled"
    expect(modal.formal_remarket_new_business_day_question_element.child.attribute('class').include?('disabled-group')).to be_truthy, "Expected the Formal Remarket new business day question on the auto general info modal to be disabled but it was enabled"
    expect(modal.prior_carrier_element.disabled?).to be_truthy, "Expected the Prior carrier on the auto general info modal to be disabled but it was enabled"
    expect(modal.prior_premium_element.disabled?).to be_truthy, "Expected the Prior Premium on the auto general info modal to be disabled but it was enabled"
    modal.save_and_close
  end
end

And(/^I provide details of transportation network coverage in auto vehicle coverage modal from (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @coverage = data_for('transportation_network_coverage')
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    #page.other_vehicle_modal.wait_for_loading_to_disappear
    # page.auto_vehicle_coverages_modal.tabs.active_tab = 'Coverage'
    page.other_vehicle_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    modal = page.auto_vehicle_coverages_modal
    modal.transportation_network_coverage_panel.transportation_network_coverage = true
    modal.transportation_network_coverage_panel.company = @coverage['company']
    modal.transportation_network_coverage_panel.hours_per_week = @coverage['hours_per_week']
    modal.transportation_network_coverage_panel.driver = @coverage['driver']
    panel1 = modal.panel_obj_for_coverage('Towing & Labor')
    modal.save_and_close
  end
end

And(/^I provide details of Electronic Equipment coverage in auto vehicle coverage modal from (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @coverage = data_for('electronic_equipment')
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    page.other_vehicle_modal.wait_for_loading_to_disappear
    page.auto_vehicle_coverages_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    modal = page.auto_vehicle_coverages_modal
    modal.electronic_equipment_coverage_panel.electronic_equipment_check_box = true
    modal.electronic_equipment_coverage_panel.total_limit = @coverage['total_limit']
    panel1 = modal.panel_obj_for_coverage('Towing & Labor')
    if panel1.present? && modal.coverages_list.coverage_selected?('Towing & Labor')
      panel = modal.panel_obj_for_coverage('Extended Transportation')
      panel.scroll.to
      panel1.total_limit_per_disablement_element.click
      panel1.total_limit_per_disablement = 1
    end
    modal.save_and_close
  end
end

And(/^I provide details of Extended Transportation coverage in auto vehicle coverage modal from (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @coverage = data_for('extended_transportation')
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    page.other_vehicle_modal.wait_for_loading_to_disappear
    page.auto_vehicle_coverages_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    modal = page.auto_vehicle_coverages_modal
    modal.extended_transportation_panel.extended_transportation = true
    modal.extended_transportation_panel.total_limit_extended_transportation_element.click
    modal.extended_transportation_panel.total_limit_extended_transportation = @coverage['total_limit']
    modal.save_and_close
  end
end

Then(/^I validate effective date of change$/) do
  on(QuoteManagementPage) do |page|
    section = page.policy_change_summary_section
    expect(section.eff_date_of_change_text).to eq('Effective Date of Change')
    expect(section.eff_date_of_change).to eq(Chronic.parse('1 days from now').to_date.strftime('%m/%d/%Y'))
  end
end