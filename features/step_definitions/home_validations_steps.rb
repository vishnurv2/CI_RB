And(/^I save the data for the Applicants$/) do
  applicant = []
  additional_party = []
  total_applicant = []
  @parser.for_tag(:PersonName).within(:InsuredOrPrincipal).each { |name| applicant.append("#{name['GivenName']} #{name['Surname']}") }
  @parser.for_tag(:PersonName).within(:PersAutoLineBusiness).each { |name| additional_party.append("#{name['GivenName']} #{name['Surname']}") unless additional_party.include? ("#{name['GivenName']} #{name['Surname']}") }
  additional_party = additional_party.uniq
  total_applicant = applicant + additional_party
  expect(total_applicant.size > 0)
end

Then(/^I verify the details at policy summary screen$/) do
  arr = []
  @parser.for_tag(:ContractTerm).within(:PersPolicy).each { |name| arr.append("#{name['EffectiveDt']}") }
  Date.parse(arr.first).strftime('%m/%d/%Y')
  abc = []
  @parser.within(:FormatCurrencyAmt).each { |name| abc.append(name) }
  coverage_a = abc.uniq.first
  coverage_c = abc.uniq[3]
  coverage_e = abc.uniq[4]
  coverage_f = abc.uniq[5]

end

Then(/^I add effective date before 2017$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_general_info_modal
    modal.effective_date = '11/09/2015'
  end
end

And(/^I try to add new address to check the fields$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_general_info_modal
    modal.policy_mailing_address = 'New Address'
    modal.save_and_continue
  end
end

And(/^I clear the effective date field and click save and close button$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_general_info_modal
    modal.effective_date_text_field_element.clear
    #modal.effective_date_text_field_element.click
    modal.save_and_continue
  end
end

And(/^I click modify on general information modal and then save and close the modal$/) do
  on(AutoPolicySummaryPage).general_info_panel.modify
  on(PolicyManagementPage) do |page|
    modal = page.auto_general_info_modal
    modal.save_and_close_button
  end
end

And(/^I click edit on the applicant panel and save and close the modal$/) do
  on(AutoPolicySummaryPage).applicants_panel.applicants.first.edit
  on(PolicyManagementPage) do |page|
    modal = page.add_applicant_modal
    modal.save_and_close
  end
end

And(/^I clear the address and click on protection class override checkbox and save and close the modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.protection_class_override_checkbox_element.click
    modal.clear_element.click
    #modal.save_and_close
  end
end

And(/^I close the property info modal and open it again$/) do
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.close_button_element.click
    on(AutoPolicySummaryPage).property_panel.edit_element.click
    on(PolicyManagementPage).property_info_modal.save_and_close
    page.wait_for_overlay_no_ajax_wait
  end
end

And(/^I click modify on property information panel and then save and close the modal$/) do
  on(AutoPolicySummaryPage).property_panel.edit_element.click
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.save_and_close_button
  end
end

And(/^I open the property info modal again$/) do
  on(AutoPolicySummaryPage).property_panel.edit_element.click
  on(PolicyManagementPage) do |page|
    page.property_info_modal.save_and_close
    page.wait_for_overlay_no_ajax_wait
  end
end

And(/^I fill the data in policy coverages modal with (.*) fixture file and save and close it$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for('auto_policy_level_coverages_modal')
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    page.wait_for_ajax
    modal.populate_with(data)
    modal.save_changes
  end
end

And(/^I fill the data in auto vehicle coverages modal with (.*) fixture file and save and close it$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @coverage = data_for('auto_vehicle_coverages_modal')
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    #page.other_vehicle_modal.wait_for_loading_to_disappear
    page.auto_vehicle_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    modal = page.auto_vehicle_coverages_modal
    modal.custom_equipment_panel.custom_equipment = true
    modal.electronic_equipment_coverage_panel.electronic_equipment_check_box = true
    modal.towing_and_labor_panel.towing_and_labor = true
    modal.extended_transportation_panel.extended_transportation = true
    modal.manual_coverage = true
    modal.save_and_close
  end
end

And(/^I clear all the currency input fields$/) do
  on(PolicyManagementPage) do |page|
    page.wait_for_processing_overlay_to_close
    modal = page.auto_policy_optional_coverages_modal
    modal.clear_currency_input_field_elements
  end
end

And(/^I click on protection class override checkbox and save and close the modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.protection_class_override_checkbox_element.click
    modal.save_and_close
  end
end


When(/^I start with issue wizard modal till Billing Information section$/) do
  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    page.issue
    modal = page.issue_wizard_modal
    modal.next_button
    modal.distribution_section.navigate_defaults
    modal.next_button
    modal.next_button
  end
end

And(/^I should see the following red alerts on the top right corner$/) do |table|
  on(PolicyManagementPage) do |page|
    expected = table.raw.flatten
    expected.each do |message|
      issue = page.toast_container.errors
      expect(issue).to eq(message), "Expected to find an issue containing the text #{message}, but it was not found"
    end
  end
end

And(/^I select '(.*)' type for optional coverage 'Farming Personal Liability \- Away From Premises'$/) do |opt|
  on(PolicyManagementPage) do |page|
    page.wait_for_processing_overlay_to_close
    modal = page.auto_policy_optional_coverages_modal
    modal.farmers_personal_liability.click
    page.wait_for_processing_overlay_to_close
    modal.farmers_personal_liability_type= opt
  end
end

And(/^I select '(.*)' location for optional coverage 'Permitted Incidental Occupancies'$/) do |opt|
  on(PolicyManagementPage) do |page|
    page.wait_for_processing_overlay_to_close
    modal = page.auto_policy_optional_coverages_modal
    modal.home_permitted_incidental_occupancies_in_residence.click
    page.wait_for_processing_overlay_to_close
    modal.home_permitted_incidental_occupancies_in_residence_location= opt
  end
end

When(/^I start with issue wizard modal till Billing Account modal$/) do
  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    page.issue
    modal = page.issue_wizard_modal
    modal.next_button
    modal.distribution_section.navigate_defaults
    modal.next_button
    modal.billing_section.add_billing_account
    on(PolicyManagementPage) do |page|
      modal = page.billing_account_add_product_modal
      modal.payor = @name+" (Applicant)"
      modal.bill_plan_monthly.click
      page.wait_for_processing_overlay_to_close
      modal.payment_method_manual.click
    end
  end
end

And(/^I should see the warning message on billing Add product modal$/) do |table|
  on(PolicyManagementPage) do |page|
    expected = table.raw.flatten
    expected.each do |message|
      found_message = page.field_validation_errors
      #expect(found_message.join(',')).to eq(message+" "+@number)
      expect(found_message.join(',').include?(message)).to be_truthy
    end
  end
end

And(/^I click on save and continue button on dwelling policy coverages$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    modal.save_and_continue
  end
end

And(/^I fill the data in "([^"]*)" modal with (.*) fixture file and save and close it$/) do |which, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for("#{which.snakecase}_modal")
  on(PolicyManagementPage) do |page|
    modal = page.send("#{which.snakecase}_modal")
    page.wait_for_ajax
    modal.populate_with(data)
    modal.save_changes
  end
end

And(/^I open the optional policy coverage modal again$/) do
  on(AutoPolicySummaryPage).policy_optional_coverages_panel.modify_element.click
  on(PolicyManagementPage) do |page|
    page.auto_policy_optional_coverages_modal.save_and_close
    page.wait_for_overlay_no_ajax_wait
  end
end

And(/^I (|clear|) the field with dismiss cross in "([^"]*)" modal$/) do |what, modal|
  on_current_page do |page|
    page.send("#{modal.downcase.snakecase}_modal").send("#{what.downcase.snakecase}_element").click
  end
end


Then(/^I change the vehicle type to "([^"]*)" on vehicle modal$/) do |type|
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    modal.type_of_vehicle = type
  end
end

And(/^I save and close add applicant modal$/) do
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    modal.save_and_close_ignore_validation
  end
end

And(/^I populate data in vehicle coverages modal for Collision and save and close it$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    #page.other_vehicle_modal.wait_for_loading_to_disappear
    page.auto_vehicle_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    modal = page.auto_vehicle_coverages_modal
    modal.other_than_collision = false
    modal.save_and_close
  end
end

And(/^I populate data in vehicle coverages modal for Loan Lease guard and save and close it$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    #page.other_vehicle_modal.wait_for_loading_to_disappear
    page.auto_vehicle_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    modal = page.auto_vehicle_coverages_modal
    modal.other_than_collision = false
    modal.collision = false
    modal.lease_guard.lease_load_guard = true
    modal.lease_guard.lease_guard_button_element.click
    modal.save_and_close
  end
end

And(/^I remove the vehicles and driver from vehicle and driver found modal$/) do
  on(PolicyManagementPage) do |page|
    page.vehicles_and_drivers_found_modal.present?
    modal = page.vehicles_and_drivers_found_modal
    modal.vehicle_and_driver.click
  end
end

And(/^I populate data in watercraft coverages modal for deductible$/) do
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_vehicle_panel.scroll.to
    vehicle = page.watercraft_vehicle_panel.vehicles.last
    vehicle.edit_element.click
    #page.other_vehicle_modal.wait_for_loading_to_disappear
    page.hull_and_motor_information_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    modal = page.hull_and_motor_information_modal
    modal.hull_deductible = '$100'
    modal.save_and_close
  end
end

Then(/^I change the motor type$/) do
  on(PolicyManagementPage) do |page|
    modal = page.hull_and_motor_information_modal
    modal.motor_type = 'Water Jet'
    modal.motor_type = 'Outboard'
    modal.engine_size = '56'
    modal.save_and_close
  end
end

When(/^I update the year for trailer to "([^"]*)"$/) do |year|
  on(PolicyManagementPage) do |page|
    modal = page.trailer_information_modal
    modal.year = year
    modal.save_and_close
  end
end


Then(/^I should see "([^"]*)" on the page$/) do |validation_message|
  on(PolicyManagementPage) do |page|
    found = page.field_validation_errors.include? validation_message.downcase
    expect(found).to be_truthy, "Expected to find \"#{validation_message}\" validation error on the page/modal!"
  end
end

When(/^I select the below Home Policy Level Optional Coverages$/) do |table|
  # table is a table.hashes.keys # => [:Actual Cash Value Loss Settlement]
  on(PolicyManagementPage) do |page|
    page.wait_for_processing_overlay_to_close
    modal = page.auto_policy_optional_coverages_modal
    opts = table.raw.flatten
    opts.each do |op|
      val = case op
            # when 'Actual Cash Value Loss Settlement'
            #   'actual_cash_value_loss_settlement'
            when 'Assisted Living Care'
              'assisted_living_care'
            when 'Business Property - Increased Limit'
              'business_property_increased_limit'
            when 'Coverage C - Increased Limits of Liability - Firearms'
              'coverage_c_increased_limits_firearms'
            when 'Coverage C - Increased Limits of Liability - Jewelry, Watches & Furs'
              'coverage_c_increased_limits_jewelry'
            when 'Coverage C - Increased Limits of Liability - Money'
              'coverage_c_increased_limits_money'
            when 'Coverage C - Increased Limits of Liability - Portable Electronic Equipment in or upon a Motor Vehicle'
              'coverage_c_increased_limits_electronic'
            when 'Coverage C - Increased Limits of Liability - Securities'
              'coverage_c_increased_limits_securities'
            when 'Coverage C - Increased Limits of Liability - Silverware, Goldware & Pewterware'
              'coverage_c_increased_limits_silverware'
            when 'Credit Card / Forgery'
              'credit_card_forgery'
            when 'Home Business Plus'
              'home_business_plus'
            when "Landlord's Furnishings Coverage"
              'home_landlords_furnishings_coverage'
            when 'Loss Assessment - Residence Premises'
              'home_loss_assessment_resident_premises'
            when 'Ordinance or Law - Increased Limit'
              'home_ordinance_or_law'
            when 'Other Structures - Specifically Insured - Off Premise'
              'home_other_structures_specifically_insured'
            when 'Other Structures - Specifically Insured - On Premise'
              'other_structures_specifically_insured_on_premise'
            when 'Farming Personal Liability - Away From Premises'
              'farmers_personal_liability'
            when 'Incidental Farming Liability'
              'home_farming_liability_off_premise'
            when 'Inland Flood'
              'home_inland_flood'
            when 'Liability Extension - Occupied by Insured'
              'home_liability_extension'
            when 'Liability Extension - Rented to Others'
              'home_liability_extension_rented_to_others'
            when 'Loss Assessment - Additional Locations'
              'home_loss_assessment_additional_locations'
            when 'Manual Coverage'
              'home_manual_coverage'
            when 'Motorized Golf Cart - Physical Loss Coverage'
              'home_motorized_golf_cart'
            when 'Other Structures - Rented to Others - Residence Premise'
              'home_other_structures_rented_premise'
            when 'Permitted Incidental Occupancies'
              'home_permitted_incidental_occupancies_in_residence'
            when 'Personal Cyber Protection'
              'home_personal_cyber_protection'
            when 'Personal Injury'
              'home_personal_injury'
            when 'Personal Property Located in a Self-Storage Facility-Increased Limit'
              'home_property_located_self_storage'
            when 'Personal Property-Increased Limit-Other Residences'
              'home_personal_property_other_residence'
            when 'Replacement Cost on the Home-Additional Amount'
              'home_replacement_cost_on_home'
            when 'Residence Employees -Additional Rate for More Than Two Employees'
              'home_residence_additional_rate'
            when 'Snowmobile Coverage'
              'home_snowmobile_coverage'
            when 'Special Loss Settlement'
              'home_special_loss_settlement'
            when 'Theft of Building Materials'
              'home_theft_of_building_materials'
            when 'Theft of Personal Property Dwelling Under Construction'
              'home_theft_of_personal_property'
            when 'Theft of Tools Optional Deductible'
              'home_theft_of_tools'
            else
              op.snakecase
            end
      modal.send("#{val.snakecase}").click if !modal.send("#{val.snakecase}_element").div.attribute('class').include? 'p-checkbox-checked'
      page.wait_for_processing_overlay_to_close
    end
  end
end

And(/^I click on protection class override checkbox$/) do
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.protection_class_override_checkbox_element.click
  end
end

Then(/^I verify watercraft liablity and medpay should be same as cov E and Cov F of home$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    expect(modal.personal_liability_value).to eq(@personal_liability)
    expect(modal.medpay_value).to eq(@medical_payment)
  end
end

And(/^I deselect Agreed field from vehicle modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    modal.agreed_value = false
  end
end

And(/^I populate garage address of Ohio$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    modal.garage_address = 0
    address_section = modal.address_details
    address_section.address_line_1 = '800 S Washington St'
    address_section.city = 'Van Wert'
    address_section.state = 'Ohio'
    address_section.zip_code_ohio = '45891'
  end
end

And(/^I add the address for residence premises$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    address_section = modal.address_details
    address_section.address_line_1 = '800 S Washington St'
    address_section.city = 'FORT WAYNE'
    address_section.state = 'Indiana'
    address_section.postal_code = '46885'
  end
end

And(/^I select "([^"]*)" from Location of Incidental Occupancy modal$/) do |arg|
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    modal.location_of_incidental_occupancy = arg
    modal.save_and_close_button
  end
end

And(/^I fill data for rating tier and premise address$/) do
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.rating_tier = 'Central'
    modal.premise_address = 1
  end
end