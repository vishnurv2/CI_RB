# frozen_string_literal: true

When(/^I save and close the auto policy coverages modal$/) do
  on(PolicyManagementPage) do |page|
    page.auto_policy_coverages_modal.save_and_continue
    page.wait_for_ajax
  end
end

Then(/^I should see the following errors on the auto policy coverages modal:$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    expected = table.raw.flatten
    actual = page.field_validation_errors
    exclude = "Please resolve all issues before saving"

    if actual.include?(exclude)
      actual.delete(exclude)
    end
    expected.each do |message|
      found = actual.include? message.downcase
      expect(found).to be_truthy, "Expected to find \"#{message}\" validation error on the page/modal!"
    end
    # expect(actual).to eq(expected), "Expected the validations to match the validation messages in the feature file!"
  end
end

And(/^the coverages I entered display in the home coverages panel$/) do
  on(AutoPolicySummaryPage) do |page|
    data_used = EDSL::PageObject.fixture_cache['auto_policy_level_coverages_modal']
    actual_medical = data_used["coverage_f_medical"]
    actual_personal = data_used["coverage_e_personal"]
    expect(actual_medical).to eq(page.policy_coverages_panel.home_medical_payments), "Expected medical payments entered: \"#{page.policy_coverages_panel.home_medical_payments}\" to match the screen \"#{actual_medical}\""
    expect(actual_personal).to eq(page.policy_coverages_panel.home_personal_liability), "Expected liability entered: \"#{page.policy_coverages_panel.home_personal_liability}\" to match the screen \"#{actual_personal}\""
  end
end

Then(/^The optional coverages modal should contain the following coverages:$/) do |table|
  expected = table.raw.flatten
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    actual_coverages = modal.home_optional_coverages
    found_extra = (actual_coverages - expected)
    found_missing = (expected - actual_coverages)
    RSpec.capture_assertions do
      expect(found_extra.empty?).to be_truthy, "Found Extra Coverages, #{found_extra}"
      expect(found_missing.empty?).to be_truthy, "Found Missing Coverages, #{found_missing}"
    end
  end
end

And(/^the optional coverage should be saved in the coverages modal$/) do
  on(AutoPolicySummaryPage) do |page|
    data_used = EDSL::PageObject.fixture_cache['auto_policy_optional_coverages_modal']
    panel = page.policy_optional_coverages_panel
    panel.modify
    page.wait_for_ajax

    modal = page.auto_policy_optional_coverages_modal
    expect(modal.send("#{data_used.keys[0]}").value).to eq(data_used.values[0]), "Expected to find the \"#{data_used.keys[0]}\" to be checked true!"
  end
end

Then(/^I verify the following options of premise use$/) do |table|
  expected = table.rows.flatten
  field_type = table.headers.join.to_s

  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.prefill_property_info = true
    select_list = modal.premise_use.options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found in #{field_type}"
      end
    end
  end
end

When(/^I click on modify property information modal$/) do
  on(AccountSummaryPage) do |page|
    page.scroll.to :center
    page.property_info_panel.modify
  end

end

And(/^I select form type as "([^"]*)"$/) do |option|
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.form_type = option
  end
end

And(/^I provide details and (save and close|save and continue) property information modal using "([^"]*)" fixture$/) do |which, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @personal_info = data_for('property_info_modal')
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.populate_with(@personal_info)
    modal.send("#{which}".snakecase)
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I verify the details present on property information modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    expect(modal.form_type.text).to eq(@personal_info['form_type'])
    expect(modal.premise_use.text).to eq(@personal_info['premise_use'])
  end
end

When(/^I click on close button$/) do
  on(PolicyManagementPage) do |page|
    page.auto_general_info_modal.cross_button_element.click
    page.wait_for_ajax
  end
end

And(/^I click on Begin quote on Add product modal$/) do
  on(PolicyManagementPage) do |page|
    if page.existing_client_modal?
      page.existing_client_modal.save_and_continue
    end
    page.add_product_modal.save_and_begin_quote_element.click
    page.wait_for_ajax
  end
end

And(/^I add a product using (.*) fixture and remove the state$/) do |fixture_file|
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  @first_product = data_for('add_product_modal')
  on_current_page do |page|
    modal = page.add_product_modal
    modal.populate_with(@first_product)
    modal.clear_element.click
    modal.save_and_begin_quote_element.click
    #page.wait_for_processing_overlay_to_close

    #address scrubbing is called in address_details= used by fixture
    #modal.address_scrubber_alert.scroll.to
    #modal.user_entered_element.preceding_sibling.click
  end
end

And(/^I edit fungi rot liability property and limit optional coverage$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.policy_optional_coverages_panel
    panel.modify
    page.wait_for_ajax
  end
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    modal.home_limited_fungi_rot_liability_property = '$25,000'
    modal.home_limited_fungi_rot_liability_limit = '$100,000'
    modal.save_and_close
  end
end
