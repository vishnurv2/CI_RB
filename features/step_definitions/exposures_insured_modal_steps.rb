# frozen_string_literal: true

Then(/^I click on add exposures insured with central$/) do
  on(AutoPolicySummaryPage) do |page|
    page.exposures_insured_with_central_panel.add_new
  end
end

Then(/^I click on add exposures insured with another carrier$/) do
  on(AutoPolicySummaryPage) do |page|
    page.exposures_insured_with_another_carrier_panel.add_new
  end
end

Then(/^the product category should be "([^"]*)"$/) do |category|
  on(AutoPolicySummaryPage) do |page|
    panel = page.exposures_insured_with_central_panel
    panel.products.each do |product|
      expect(product&.category.downcase).to eq(category.downcase), "Product status of '#{product&.category}' does not match expected status of '#{category}'"
    end
  end
end

And(/^I validate following containers in "([^"]*)" modal$/) do |which, table|
  on(PolicyManagementPage) do |page|
    modal = page.send("#{which.snakecase}_modal")
    containers_heading = []
    modal.containers.each do |item|
      containers_heading << item.header_text.remove(/\d+/).strip
    end
    expect(containers_heading.sort).to eq(table.rows.flatten.sort)
  end
end

When(/^I provide values for "([^"]*)" through "([^"]*)" fixture file$/) do |container_header, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for('exposures_insured_with_another_carrier_modal')
  on_current_page do |page|
    container = page.exposures_insured_with_another_carrier_modal.containers.find { |i| i.header_text.include? container_header }
    if container_header == 'Location / Property'
      page.exposures_insured_with_another_carrier_modal.send("#{fixture_file}".snakecase)
    else
      page.exposures_insured_with_another_carrier_modal.send("#{container_header}".snakecase)
    end
    container.populate_with(data)
    page.exposures_insured_with_another_carrier_modal.save_and_close
    #page.wait_for_processing_overlay_to_close
  end
end

Then(/^I validate by save and close the exposures modal without providing fields$/) do
  on(PolicyManagementPage) do |page|
    page.exposures_insured_with_another_carrier_modal.save_and_close
  end
end

And(/^the exposures modal should be closed$/) do
  on(PolicyManagementPage) do |page|
    expect(!page.exposures_insured_with_another_carrier_modal?).to be_truthy, "Mandatory asterisk mark is present before begin issuance"
  end
end

And(/^I should see a validation error message in exposures modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    expect(modal.carrier_element.following_sibling.text).to eq("Carrier is required.")
    expect(modal.policy_number_element.following_sibling.text).to eq("Policy Number is required.")
    expect(modal.effective_date_element.parent.parent.following_sibling.text).to eq("Effective Date is required.")
    expect(modal.expiration_date_element.parent.parent.following_sibling.text).to eq("Expiration Date is required.")
  end
end

Then(/^I validate by save and close the exposures modal after providing fields using "([^"]*)" fixture file$/) do |fixture_file|
  # Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @data = data_for('exposures_insured_with_another_carrier_container_modal')
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    modal.populate_with(@data)
    modal.save_and_close
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I should see the following limits options in the modal$/) do |table|
  expected = table.rows.flatten
  field_type = table.headers.join.to_s

  on(AutoPolicySummaryPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    select_list = modal.send("#{field_type}_element".snakecase).options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found in #{field_type}"
      end
    end
  end
end

Then(/^I validate by providing fields for all the products using "([^"]*)" fixture file$/) do |fixture_file|
  # Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @data = data_for('exposures_insured_with_another_carrier_container_modal')['modals']
  counter = on(AutoPolicySummaryPage).exposures_insured_with_another_carrier_panel.products.count
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    i = 0
    counter.times do
      modal.populate_with(@data[i])
      modal.save_and_continue unless i == (counter-1)
      page.wait_for_processing_overlay_to_close
      page.wait_for_modal
      i = i + 1
    end
    modal.save_and_close
    page.wait_for_processing_overlay_to_close
  end
end

And(/^I select "([^"]*)"$/) do |option|
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    modal.split_combined_single_limit = option
  end
end

Then(/^I should see the following limit options for "([^"]*)" in the modal$/) do |option, table|
  expected = table.rows.flatten
  field_type = table.headers.join.to_s

  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    modal.split_combined_single_limit = option
    select_list = modal.send("#{field_type}_element".snakecase).options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found in #{field_type}"
      end
    end
  end
end

And(/^I validate the exposures present on the exposures modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_modal
    if modal.no_exposures_msg?
      expect(modal.no_exposures_msg.include? 'No exposure exist.').to be_truthy
    else
      exposures = modal.exposures_grid
      expect(exposures.nil?).to be_falsey
      expect(exposures.first.category).to eq('Automobile')
    end
  end
end

Then(/^I validate exposures modal after providing fields using "([^"]*)" fixture file and save and close it$/) do |fixture_file|

  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
    RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @data = data_for('exposures_insured_with_another_carrier_container_modal')
  @data_exceptional_fields = data_for('exposures_insured_with_another_carrier_container_modal_exceptional_fields')
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    modal.populate_with(@data)
    modal.year_element.click
    modal.year_element.set(@data_exceptional_fields['year'])
    modal.make_element.set(@data_exceptional_fields['make'])
    modal.model_element.set(@data_exceptional_fields['model'])
    modal.save_and_close
  end
end

And(/^I validate number of acres for umbrella with farm land rented to others$/) do
  on_current_page do |page|
    container = page.exposures_insured_with_another_carrier_modal.containers.find { |i| i.header_text.include? "Farm Land" }
    container.click
    container.farm_land_rented = '1'
    page.exposures_insured_with_another_carrier_modal.save_and_close
    page.wait_for_processing_overlay_to_close
  end
  on(AutoPolicySummaryPage) do |page|
    prods = page.exposures_insured_with_another_carrier_panel.products.find_all { |x| x.edit? }
    prods.first.edit
    page.wait_for_modal_or_error
  end
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    modal.number_of_units = '0'
    modal.save_and_close
    expect(modal.no_of_acres_error_message).to eq("Number of acres must be greater than 0.")
    modal.dismiss_element.click
    page.wait_for_ajax
  end
end