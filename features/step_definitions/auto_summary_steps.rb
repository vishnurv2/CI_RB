# frozen_string_literal: true


# ------ Everything below this line is unverified ------------------------------------- #
#


And(/^the auto general info modal (should|should not) be displayed$/) do |which|
  visible = which == 'should'
  on(AutoPolicySummaryPage) do |page|
    Watir::Wait.until { page.auto_general_info_modal? == visible }
    page.raise_page_errors
  end
end

When(/^I add a driver from the auto summary page$/) do
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.add_driver
    page.wait_for_processing_overlay_to_close
    page.auto_driver_modal.populate
    page.auto_driver_modal.save_and_close
  end
end

When(/^I add a driver from the policy summary page using the data for "([^"]*)"$/) do |data|
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.add_driver
    if page.auto_prefill_modal.present?
      page.auto_prefill_modal.deselect_all
      page.auto_prefill_modal.save_and_continue
    end
    page.auto_driver_modal.populate_with data_for(data.snakecase)
    page.auto_driver_modal.save_and_close
  end
end

When(/^I add a driver from the auto summary page followed by the (save and close|save and continue|dismiss) button$/) do |button|
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.add_driver
    page.auto_driver_modal.populate
    page.auto_driver_modal.send(button.snakecase)
  end
end

Then(/^The driver (should|should not) display in the driver grid on the auto summary page$/) do |should_or_not|
  expected_driver = EDSL::PageObject.fixture_cache['auto_driver_modal']
  on(AutoPolicySummaryPage) do |page|
    found_driver = page.driver_info_panel.find_driver_by_hash(expected_driver)
    driver_data = '{ '
    AutoDriverInformationPanel::FIELDS.keys.each { |k| driver_data += "#{k}: \"#{expected_driver[k]}\" " }
    driver_data += '}'
    expect(found_driver.nil? == (should_or_not == 'should not')).to be_truthy, "Expected#{should_or_not.gsub('should', '')} to find #{driver_data} in the driver grid, but the driver was#{'should not'.gsub(should_or_not, '')} found"
  end
end

And(/^my vehicles should not have a class code in the vehicle grid$/) do
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      page.vehicle_info_panel.vehicles.each do |vehicle|
        expect(vehicle.class_code?).to be_falsey, "#{vehicle.vehicle} have a class code"
        # expect(vehicle.class_code.to_s.empty?).to be(false), "#{vehicle.vehicle} does not have a class code"
      end
    end
  end
end

When(/^I add a vehicle with type "([^"]*)"$/) do |_vehicle_type|
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_vehicle_by_type(:camper)
  end
  ovm = data_for('other_vehicle_modal')
  @added_other_vehicle = {'year' => ovm['vehicle_year'], 'make' => ovm['vehicle_make'], 'model' => ovm['vehicle_model'], 'id' => ovm['id_number'], 'type' => ovm['type_of_vehicle']}
end

When(/^I add a vehicle from the fixture file "([^"]*)"$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  ovm = data_for('other_vehicle_modal')
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_button
    modal = page.other_vehicle_modal
    modal.populate_with(ovm)
    modal.save_and_close_button
    page.wait_for_ajax
  end
  @added_other_vehicle = {'year' => ovm['vehicle_year'], 'make' => ovm['vehicle_make'], 'model' => ovm['vehicle_model'], 'id' => ovm['vehicle_identification_number'], 'type' => ovm['type_of_vehicle']}
end

When(/^I add the specified other vehicle$/) do
  ovm = data_for('other_vehicle_modal')
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_button

    if page.auto_prefill_modal?
      prfl = data_for('auto_prefill_modal')
      page.auto_prefill_modal.populate_with(prfl)
      page.auto_prefill_modal.save_and_continue
    end

    modal = page.other_vehicle_modal
    modal.populate_with(ovm)
    modal.save_and_close_button
    page.wait_for_ajax
  end
  @added_other_vehicle = {'year' => ovm['vehicle_year'], 'make' => ovm['vehicle_make'], 'model' => ovm['vehicle_model'], 'id' => ovm['id_number'], 'type' => ovm['type_of_vehicle']}
end

And(/^the other vehicle (.*) I added should be present in the other vehicle grid$/) do |ov|
  on(AutoPolicySummaryPage) do |page|
    other_vehicle = page.vehicle_info_panel.other_vehicles_element.trs(class: /ui-widget-header/).find { |row| row.text.downcase.include? ov.downcase }
    expect(other_vehicle).not_to be_nil, "Expected to find #{@added_other_vehicle} in the other vehicles grid"
    @other_vehicle = other_vehicle
  end
end

And(/^I open the other vehicle I just added's optional coverages$/) do
  on(AutoPolicySummaryPage) do |page|
    vehicle_name = @other_vehicle.following_sibling(class: /row-expanded/).text
    ov = page.vehicle_info_panel.other_vehicles.find { |row| row.text.downcase == vehicle_name.downcase }
    ov.edit
    page.wait_for_ajax
    page.other_vehicle_modal.wait_for_loading_to_disappear
    page.auto_vehicle_modal.tabs.active_tab = 'Coverage'
    sleep(2)
    on(PolicyManagementPage).wait_for_ajax
  end
end

Then(/^The garage risk state validation message should be present$/) do
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      expect(page.auto_vehicle_modal.present?).to be_falsey, 'Expected the auto vehicle modal to be gone so that the validation could be confirmed on the summary page, but the modal was found'
      expect(page.vehicle_info_panel.risk_state_validation?).to be_truthy, 'Expected the risk state validation message to be present within the vehicle info panel but it was not'
    end
  end
end

And(/^I edit the first (vehicle|applicant) from the auto policy summary page with the file "([^"]*)"$/) do |item_to_edit, fixture_file|
  # modal = (Helpers::Fixtures.load_fixture(fixture_file.snakecase).find { |key, value| key.include? 'modal' }).first
  modal = (RubyExcelHelper.safe_load_fixture_file(fixture_file).find { |key, value| key.include? 'modal' }).first
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
    page.send("#{item_to_edit}s").first.edit_element.click
    if page.add_policy_change_modal?
      page.add_policy_change_modal.save_and_continue_button
      page.wait_for_ajax
      page.send("#{item_to_edit}s").first.edit if !page.send(modal).present?
    end
    page.auto_vehicle_modal.agreed_value = false if page.auto_vehicle_modal?
    page.send(modal).populate
    page.send(modal).save_and_close
    page.wait_for_ajax
  end
end

And(/^I open the policy level optional coverages$/) do
  on(AutoPolicySummaryPage).open_policy_optional_coverages
end

And(/^I open the policy level coverages$/) do
  on(AutoPolicySummaryPage).policy_coverages_panel.modify
end

And(/^I validate in filter view "([^"]*)" and "([^"]*)" or "([^"]*)" should be present$/) do |policy_change, inforce, issued|
  on(AutoPolicySummaryPage) do |page|
    new_date = Chronic.parse("today").strftime('%m/%d/%Y')
    expect(page.filter_view_dropdown_element.options.last).to eq("#{policy_change} - #{new_date} 0 - 1")
    page.filter_view_dropdown_element.click!
    expect(page.filter_view_dropdown_element.options.first == "#{inforce} - #{new_date}" || page.filter_view_dropdown_element.options.first == "#{issued} - #{new_date}")
    # expect(page.filter_view_dropdown_element.options.first).to eq("#{inforce} - #{new_date}")
  end
end

And(/^I validate in filter view data$/) do
  on(AutoPolicySummaryPage) do |page|
  new_date = Chronic.parse("today").strftime('%m/%d/%Y')
  expect(page.filter_view_dropdown_element.options.last).to eq("Policy Change #{new_date} 0-2")
  end
end

When(/^I edit the first property from the home policy summary page with the file "([^"]*)"$/) do |fixture_file|
  #modal = (Helpers::Fixtures.load_fixture(fixture_file.snakecase).find { |key, value| key.include? 'modal' }).first
  modal = (RubyExcelHelper.safe_load_fixture_file(fixture_file).find { |key, value| key.include? 'modal' }).first
  on(PolicyManagementPage) do |page|
    header = on(AutoPolicySummaryPage)
    unless header.policy_summary_h4.include? 'IN - Homeowners'
      if page.left_nav.find_option("Policies").present?
        collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
        page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"
      else
        collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
        page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
      end
      menu_item = page.left_nav.find_option_containing('IN - Homeowners')
      menu_item.click unless menu_item.active?
    end
  end
  on(AutoPolicySummaryPage) do |page|
    page.property
    page.property_panel.edit_element.click
    if page.add_policy_change_modal?
      page.add_policy_change_modal.save_and_continue_button
      page.wait_for_ajax
      page.property_panel.edit_element.click
    end
    page.send(modal).populate
    page.send(modal).save_and_close
    page.wait_for_ajax
  end
end

When(/^I edit the first coverage information from the umbrella policy summary page with the file "([^"]*)"$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(AutoPolicySummaryPage) do |page|
    page.umbrella_coverage
    page.umbrella_policy_coverages_panel.modify
  end
  on(PolicyManagementPage) do |page|
    if page.add_policy_change_modal?
      page.add_policy_change_modal.save_and_continue_button
      page.wait_for_ajax
    end
    data = data_for('auto_policy_level_coverages_modal')
    modal = page.auto_policy_coverages_modal
    modal.populate_with(data)
    modal.save_and_close
    page.wait_for_processing_overlay_to_close
  end
end

When(/^I edit the first property from the dwelling policy summary page with the file "([^"]*)"$/) do |fixture_file|
  #modal = (Helpers::Fixtures.load_fixture(fixture_file.snakecase).find { |key, value| key.include? 'modal' }).first
  modal = (RubyExcelHelper.safe_load_fixture_file(fixture_file).find { |key, value| key.include? 'modal' }).first
  on(PolicyManagementPage) do |page|
    header = on(AutoPolicySummaryPage)
    unless header.policy_summary_h4.include? 'IN - Special Dwelling'
      if page.left_nav.find_option("Policies").present?
        collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
        page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"
      else
        collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
        page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
      end
      menu_item = page.left_nav.find_option_containing('IN - Special Dwelling')
      menu_item.click unless menu_item.active?
    end
  end
  on(AutoPolicySummaryPage) do |page|
    page.property
    page.property_panel.edit_element.click
    if page.add_policy_change_modal?
      page.add_policy_change_modal.save_and_continue_button
      page.wait_for_ajax
      page.property_panel.edit_element.click
    end
    page.send(modal).populate
    page.send(modal).save_and_close
    page.wait_for_ajax
  end
end

When(/^I edit the first property from the scheduled property policy summary page with the file "([^"]*)"$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(AutoPolicySummaryPage) do |page|
    page.scheduled_property_panel.scroll.to :center
    page.scheduled_property_panel.edit_element.click
  end
  on(PolicyManagementPage) do |page|
    data = data_for('scheduled_property_policy_level_coverages_modal')
    modal = page.scheduled_property_policy_level_coverages_modal
    modal.populate_with(data)
    modal.save_and_close
    page.wait_for_processing_overlay_to_close
  end
end

When(/^I edit the first property from the watercraft policy summary page with the file "([^"]*)"$/) do |fixture_file|
  #modal = (Helpers::Fixtures.load_fixture(fixture_file.snakecase).find { |key, value| key.include? 'modal' }).first
  modal = (RubyExcelHelper.safe_load_fixture_file(fixture_file).find { |key, value| key.include? 'modal' }).first
  on(PolicyManagementPage) do |page|
    header = on(AutoPolicySummaryPage)
    unless header.policy_summary_h4.include? 'IN - Summit Watercraft'
      if page.left_nav.find_option("Policies").present?
        collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
        page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"
      else
        collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
        page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
      end
      menu_item = page.left_nav.find_option_containing('IN - Summit Watercraft')
      menu_item.click unless menu_item.active?
    end
  end
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_vehicle_panel.scroll.to :center
    page.watercraft_vehicle_panel.vehicles.first.edit_element.click
    if page.add_policy_change_modal?
      page.add_policy_change_modal.save_and_continue_button
      page.wait_for_ajax
      page.property_panel.edit_element.click
    end
    page.send(modal).populate
    page.send(modal).save_and_close
    page.wait_for_ajax
  end
end

And(/^I open the schedule property policy classes panel$/) do
  on(AutoPolicySummaryPage).scheduled_property_classes_and_items_panel.modify
end

Then(/^I validate all the tabs present in Account Summary page$/) do |table|
  on(AccountSummaryPage) do |page|
    RSpec.capture_assertions do
      table.rows.flatten.sort.each { |c| expect(page.send("#{c.snakecase}_element").present?).to be_truthy, "Expected to see #{c} in the actions dropdown list, but it could not be found" }
    end
  end
end

And(/^I modify the watercraft vehicle panel$/) do
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_vehicle_panel.scroll.to :center
    page.watercraft_vehicle_panel.vehicles.first.edit_element.click
  end
end

Then(/^I click on edit on (\d+) vehicle on watercraft vehicle panel$/) do |num|
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_vehicle_panel.scroll.to :center
    prods = page.watercraft_vehicle_panel.vehicles.find_all { |x| x.edit? }
    prods[num - 1].edit
    page.wait_for_modal_or_error
  end
end

And(/^I add a vehicle from the fixture file "([^"]*)" by ymm$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  ovm = data_for('auto_vehicle_modal')
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_button
    modal = page.auto_vehicle_modal
    modal.enter_vehicle_by = 'Year/Make/Model'
    modal.populate_with(ovm)
    modal.save_and_close_button
    page.wait_for_ajax
  end
  @added_other_vehicle = {'year' => ovm['vehicle_year'], 'make' => ovm['vehicle_make'], 'model' => ovm['vehicle_model'], 'id' => ovm['vehicle_identification_number'], 'type' => ovm['type_of_vehicle']}
end