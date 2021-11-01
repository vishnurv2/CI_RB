# frozen_string_literal: true

Given(/^I start adding a new vehicle to an existing auto policy$/) do
  RouteHelper.navigate_to_existing_auto
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_button
    page.wait_for_modal_or_error
    page.wait_for_processing_overlay_to_close
  end
end

When(/^I start adding another new vehicle to the auto policy$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_button
    page.wait_for_modal_or_error
    page.wait_for_processing_overlay_to_close
  end
end

When(/^I enter a vehicle (.*) in the auto vehicle modal by ymm$/) do |which|
  data = data_for 'auto_vehicle_modal'
  key = "vehicle_#{which.downcase.snakecase}"
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal

    selected_button = modal.enter_vehicle_by_text.selected_element.text
    modal.enter_vehicle_by = 'Year/Make/Model' if selected_button != 'Year/Make/Model'

    modal.send("#{key}=", data[key])
  end
end

When(/^I enter a vehicle (.*) in the auto vehicle modal$/) do |which|
  data = data_for 'auto_vehicle_modal'
  key = "vehicle_#{which.downcase.snakecase}"
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    modal.send("#{key}=", data[key])
  end
end

Then(/^the vehicle details should be returned$/) do
  data = data_for 'auto_vehicle_modal'
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    RSpec.capture_assertions do
      %w[year make model].each do |what|
        expect(modal.send("#{what}_result")).to eq(data["vehicle_#{what}"])
      end
    end
  end
end

When(/^I try to submit the auto vehicle modal without filling it out$/) do
  on(AutoPolicySummaryPage).auto_vehicle_modal.save_changes
end

Then(/^I should see the following errors on the auto vehicle modal:$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    expected = table.raw.flatten
    expected.each do |message|
      found = page.field_validation_errors.include? message.downcase
      expect(found).to be_truthy, "Expected to find \"#{message}\" validation error on the page/modal!"
    end
    # expect(page.field_validation_errors).to eq(expected)
  end
end

Then(/^I should see (.*) for (.*) in the auto vehicle modal$/) do |expected, which|
  key = which.downcase.snakecase
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    expect(modal.send(key).text).to eq(expected)
  end
end

When(/^I select (.*) for vehicle use in the auto vehicle modal$/) do |use_type|
  on(AutoPolicySummaryPage).auto_vehicle_modal.vehicle_use = use_type
end

Then(/^I (.*) see the (.*) input in the auto vehicle modal$/) do |what, which|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    page.wait_for_processing_overlay_to_close
    expect(modal.send("#{which.downcase.snakecase}?")).to match(what.casecmp('should').zero?)
  end
end

Then(/^an invalid VIN error should be displayed$/) do
  on(AutoPolicySummaryPage) do |page|
    # modal = page.auto_vehicle_modal
    expect(page.invalid_vin_alert?).to eq(true)
    expect(page.invalid_vin_alert_element.text.include? "Invalid Vin")
  end
end

Then(/^the black book (.*) field (should|should not) be visible in the auto vehicle modal$/) do |what, which|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    expect(modal.send("black_book_#{what.downcase}?")).to eq(which.casecmp('should').zero?)
  end
end

When(/^I select (.*) for the vehicle value type on the auto vehicle modal$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    page.auto_vehicle_modal.vehicle_value_types = which
  end
end

Then(/^the currency widget should update with the (.*) of the vehicle$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    #control = modal.vehicle_value_type_element
    #toggle = which.casecmp('msrp').zero? ? control.toggles.first : control.toggles.last

    button = modal.vehicle_value_button_text(which).text
    price = button.split('$').last
    expect(modal.vehicle_value).to eq(modal.strip_currency(price))
  end
end

Then(/^the (.*) should have a currency$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    price = modal.send("#{which.snakecase}_currency")
    strip_currency = modal.strip_currency(price)
    expect(strip_currency.to_i).to be_kind_of(Numeric), "Expected \"#{which}\" text to include a currency value, but did not!"
  end

end

When(/^I populate the auto vehicle modal$/) do
  on(AutoPolicySummaryPage) do |page|
    page.wait_for_processing_overlay_to_close

    page.auto_vehicle_modal.populate
    page.auto_vehicle_modal.save
    page.auto_general_info_modal.dismiss_button if page.auto_general_info_modal?
  end
end

Then(/^the vehicle I added should be present in the vehicle grid$/) do
  on(AutoPolicySummaryPage) do |page|
    data = data_for 'vehicle_information_panel'
    actual_vehicle = page.vehicle_info_panel.vehicles.last.vehicle.gsub("\n", ' ')
    expected_vehicle = "#{data['vehicle_year']} #{data['vehicle_make']} #{data['vehicle_model'].upcase} #{data['vehicle_vin']}"
    expect(expected_vehicle.downcase).to eq(actual_vehicle.downcase)
    page.wait_for_modal_masker
  end
end

Then(/^the edited vehicle should be present in the vehicle grid$/) do
  on(AutoPolicySummaryPage) do |page|
    data = data_for 'expected_vehicle_info'
    vehicle = page.vehicle_info_panel.vehicles.last.vehicle
    actual_vehicle = vehicle.gsub("\n", ' ')
    expected_vehicle = "#{data['vehicle_year']} #{data['vehicle_make']} #{data['vehicle_model'].upcase} #{data['vehicle_vin']}"
    RSpec.capture_assertions do
      expect(expected_vehicle.downcase).to eq(actual_vehicle.downcase)
    ensure
      page.wait_for_modal_masker
      page.vehicle_info_panel.vehicles.last.safe_delete
    end
  end
end

And(/^I edit the vehicle I just added$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    page.auto_vehicle_modal.populate_with data_for('vehicle_edit_info')

    page.auto_vehicle_modal.save # populate_with uses the save and close!
    page.wait_for_processing_overlay_to_close
    page.auto_vehicle_modal.save if page.auto_vehicle_modal.notice_icon?
    page.auto_vehicle_modal.save if page.auto_vehicle_modal.invalid_vin_alert?
    page.auto_vehicle_modal.save_and_close if page.auto_vehicle_modal.invalid_vin_alert?
  end
end

Then(/^the vehicle (.*) select list should contain options$/) do |which|
  key = which.downcase.snakecase
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    element = modal.send("vehicle_#{key}_element")
    Watir::Wait.while(message: "Timed out waiting for #{which} to have options.") { element.option_elements.empty? }
  end
end

# ------ Everything below this line is unverified ------------------------------------- #
#

Then(/^the vehicle identification number should be populated$/) do
  on(AutoPolicySummaryPage) do |page|
    vin_regex = Regexp.new('[A-HJ-NPR-Z0-9]{8}.[A-HJ-NPR-Z0-9]')
    modal = page.auto_vehicle_modal
    expect(modal.vehicle_identification_number).to match(vin_regex)
  end
end

And(/^I select (Yes|No) for agreed value in the auto vehicle modal$/) do |which|
  on(AutoPolicySummaryPage).auto_vehicle_modal.agreed_value = which
end

When(/^I enter a black book (.*) in the auto vehicle modal$/) do |which|
  data = data_for 'auto_vehicle_modal'
  key = "black_book_#{which.downcase.snakecase}"
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    modal.send("#{key}=", data[key])
  end
end

And(/^I have entered the black book fields on the auto vehicle modal$/) do
  data = data_for 'auto_vehicle_modal'
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    modal.agreed_value = 'Yes'
    %w[series style].each do |which|
      key = "black_book_#{which}"
      modal.send("#{key}=", data[key])
    end
    modal.get_vehicle_value
  end
end

Then(/^I should see options for the vehicle value displayed on the auto vehicle modal$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    modal.vehicle_value_types = 'Other Value'
    expect(modal.vehicle_value?).to eq(true)
  end
end

When(/^I enter the VIN (.*) in the auto vehicle modal$/) do |vin|
  on(AutoPolicySummaryPage) do |page|
    page.auto_vehicle_modal.vehicle_identification_number = vin
  end
end

And(/^I choose (.*) for the identification type$/) do |what|
  on(AutoPolicySummaryPage).auto_vehicle_modal.enter_vehicle_by = what
end

Then(/^I should see an error message for the (.*) field saying "([^"]*)"$/) do |field, message|
  on(AutoPolicySummaryPage) do |page|
    expect(page.field_validation_errors).to include(message.downcase)
  end
end

And(/^I switch to the coverages tab in the auto vehicle modal$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    modal.tabs.active_tab = 'Coverage'
  end
end

And(/^I edit the first "([^"]*)" and ignore validations$/) do |object_to_edit|
  on(AutoPolicySummaryPage) do |page|
    object_to_edit = object_to_edit.snakecase
    page.send("#{object_to_edit}_info_panel").send("#{object_to_edit}s").first.edit
    page.send("auto_#{object_to_edit}_modal").populate_with data_for("#{object_to_edit}_edit_info")
    page.send("auto_#{object_to_edit}_modal").save_and_close_button
    page.send("auto_#{object_to_edit}_modal").dismiss
  end
end

Then(/^the vehicle I just added (should|should not) have the "([^"]*)" coverage$/) do |which, coverage_name|
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.vehicles.first.edit
    page.auto_vehicle_modal.next_modal

    coverage = page.auto_vehicle_coverages_modal.coverage_list.find_coverage coverage_name
    expect(coverage.checked?).to eq(which == 'should')
  end
end

When(/^I select "([^"]*)" for the type of vehicle$/) do |type|
  on(AutoPolicySummaryPage).auto_vehicle_modal.type_of_vehicle = type
end

Then(/^I (should|should not) see the "([^"]*)" field in the auto vehicle modal$/) do |which, field|
  modal = on(AutoPolicySummaryPage).auto_vehicle_modal
  expect(modal.send("#{field.snakecase}?")).to eq(which == 'should')
end

Then(/^I should see all territory codes appear in the drop down$/) do
  modal = on(AutoPolicySummaryPage).auto_vehicle_modal
  RSpec.capture_assertions do
    data_for('territories').keys.each do |k|
      expect(modal.territory_element.include?(k)).to be_truthy, "Expected the auto vehicle modal territory drop down to include #{k} but it did not"
    end
  end
end

Then(/^The vehicle year, make, or model has changed validation should be visible$/) do
  on(PolicyManagementPage) do |page|
    alert = page.auto_vehicle_modal.div(class: 'alert-warning')
    expect(!alert.nil? && alert.present?).to be_truthy, "Expected to see an alert on the auto vehicle modal warning about a changed year, make, or model; but it was not found"
  end
end

When(/^I edit the first vehicle with the data from "([^"]*)"$/) do |file_name|
  on(AutoPolicySummaryPage) do |page|
    page.vehicles.first.edit unless page.auto_vehicle_modal.present?
    Helpers::Fixtures.load_fixture(file_name)
    page.auto_vehicle_modal.populate
    page.auto_vehicle_modal.save_and_close
  end
end

Then(/^I should see the invalid full vin validation$/) do
  expect(on(AutoPolicySummaryPage).auto_vehicle_modal.full_invalid_vin_validation.present?).to be_truthy, 'Expected to see the during issuance invalid vin validation, but it was not found'
end

When(/^I select "(use as entered|remain and correct)" for the invalid full vin validation$/) do |validation_selection|
  on(PolicyManagementPage) do |page|
    validation_section = page.auto_vehicle_modal.full_invalid_vin_validation
    validation_section.send("#{validation_selection.snakecase}_element").click!
    validation_section.confirm_selection
  end
end

When(/^I add another vehicle from the fixture "([^"]*)"$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_button
    modal = page.auto_vehicle_modal
    modal.populate
    modal.save_and_close
  end
end

And(/^I open the vehicle I just added$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    page.wait_for_ajax
    page.other_vehicle_modal.wait_for_loading_to_disappear #this looks for territory field.?
    #page.auto_vehicle_coverages_modal.tabs.active_tab = 'Coverage'
    page.wait_for_ajax
    Watir::Wait.until(message: 'Timed Out Waiting for other_vehicle_modal.tabs to Be Present') { page.other_vehicle_modal.tabs.present? }
    page.other_vehicle_modal.tabs.active_tab = 'Coverage'
  end
end

When(/^I populate the auto vehicle modal with the data in the (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @data_from_fixture = data_for('auto_vehicle_modal')

  on(AutoPolicySummaryPage) do |page|
    page.wait_for_processing_overlay_to_close
    page.auto_vehicle_modal.populate
    page.auto_vehicle_modal.save
    page.auto_general_info_modal.dismiss_button if page.auto_general_info_modal?
  end
end

When(/^I populate the auto vehicle modal with the data in the (.*) fixture without saving modal$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @data_from_fixture = data_for('auto_vehicle_modal')
  on(AutoPolicySummaryPage) do |page|
    page.wait_for_processing_overlay_to_close
    page.auto_vehicle_modal.populate
  end
end

Then(/^I select vehicle type as "([^"]*)"$/) do |opt|
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    modal.type_of_vehicle = opt
  end
end

And(/^I validate fields displayed for private passenger$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    expect(modal.purchase_date_element.present?).to be_truthy
    expect(modal.annual_miles_element.present?).to be_truthy
    expect(modal.purchase_date_unknown_element.present?).to be_truthy
    modal.purchase_date = Date.today.to_date.strftime('%m/%d/%Y')
    modal.purchase_date_unknown = true
    expect(modal.purchase_date_element.disabled?).to be_truthy
    modal.purchase_date_unknown = false
    expect(modal.purchase_date_element.enabled?).to be_truthy
  end
end

And(/^I validate fields displayed for limited use auto$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    modal.enter_vehicle_by = "Year/Make/Model"
    modal.vehicle_year = (Date.today.year - 2)
    expect(modal.error_message).to eq("The Vehicle must be 25 years or older to qualify as Limited Use Auto.")
    expect(modal.purchase_date_element.present?).to be_falsey
    expect(modal.annual_miles_element.present?).to be_falsey
    expect(modal.purchase_date_unknown_element.present?).to be_falsey
  end
end

When(/^I click on edit the first vehicle$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.first
    vehicle.edit_element.click
    page.wait_for_ajax
  end
end

Then(/^I validate fields displayed on vehicle modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    expect(modal.vehicle_identification_number?).to be_falsey
    expect(modal.vehicle_year?).to be_falsey
    expect(modal.vehicle_make?).to be_falsey
    expect(modal.vehicle_model?).to be_falsey
    expect(modal.purchase_date?).to be_falsey
    expect(modal.annual_miles?).to be_falsey
    expect(modal.agreed_value?).to be_truthy
    expect(modal.garage_address?).to be_truthy
    expect(modal.vehicle_use?).to be_truthy
    expect(modal.performance?).to be_truthy
    expect(modal.anti_theft_device?).to be_truthy
    expect(modal.passive_restraint_device?).to be_truthy
    modal.save_and_close
  end
end

And(/^I validate overridden status on Territory field on vehicle modal$/) do
  on(PolicyManagementPage) do |page|
    if page.add_policy_change_modal?
      page.add_policy_change_modal.save_and_continue_button
      page.wait_for_ajax
    end
    modal = page.auto_vehicle_modal
    expect(modal.territory_label).to eq("OVERRIDDEN")
  end
end

And(/^I validate message on changing vehicle on auto vehicle modal$/) do
  on(PolicyManagementPage) do |page|
    page.wait_for_ajax
    modal = page.auto_vehicle_modal
    modal.enter_vehicle_by = "Year/Make/Model"
    modal.vehicle_year = "2010"
    modal.vehicle_make = "Acura"
    modal.vehicle_model = "MDX"
    modal.vehicle_style = "UTL4X44D 3.7"
    page.wait_for_ajax
    expect(modal.warning_message.include? 'Notice: Your vehicle year, make, or model has changed.').to be_truthy
  end
end

Then(/^I update the vin$/) do
  on(AutoPolicySummaryPage) do |page|
    page.send("vehicles").first.edit_element.click
    modal = page.auto_vehicle_modal
    modal.vehicle_identification_number_field = '2HGFB2F57CH330013'
    modal.save_and_close_button
    page.wait_for_ajax
  end
end

Then(/^I update the Type as "([^"]*)"$/) do |type|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    modal.type_of_vehicle = type
  end
end

Then(/^I change garage address and validate status on Territory field$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    modal.garage_address = "New Address"
    address_section = modal.address_details
    address_section.address_line_1 = "6801 Ford Ridge Rd"
    address_section.city= 'Nashville'
    address_section.state= 'Indiana'
    address_section.zip= '47448'
    address_section.county= 'Brown'
    expect(modal.territory_label?).to be_falsey
  end
end