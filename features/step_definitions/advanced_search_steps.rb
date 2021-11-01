Then(/^I validate advanced search details$/) do
  on(PolicyManagementPage) do |page|
    modal = page.advanced_search_modal
    expect(modal.all_of_the_following?).to be_truthy
    expect(modal.any_of_the_following?).to be_truthy
  end
end

And(/^I should see the following search criteria dropdown options$/) do |table|
  expected = table.rows.flatten
  field_type = table.headers.join.to_s

  on(AutoPolicySummaryPage) do |page|
    modal = page.advanced_search_modal
    select_list = modal.search_criteria_rows.first.send("#{field_type}_element".snakecase).options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found in #{field_type}"
      end
    end
  end
end

And(/^I should see the following condition dropdown options$/) do |table|
  expected = table.rows.flatten
  field_type = table.headers.join.to_s

  on(AutoPolicySummaryPage) do |page|
    modal = page.advanced_search_modal
    modal.search_criteria_rows.first.search_criteria = 'First Name'
    select_list = modal.search_criteria_rows.first.send("#{field_type}_element".snakecase).options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found in #{field_type}"
      end
    end
  end
end

And(/^I validate condition field as disabled$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.advanced_search_modal
    modal.search_criteria_rows.first.search_criteria = 'State'
    expect(modal.search_criteria_rows.first.condition_element.disabled?).to be_truthy
  end
end

Then(/^I search by providing first name and last name$/) do
  on(PolicyManagementPage) do |page|
    modal = page.advanced_search_modal
    modal.search_criteria_rows.first.search_criteria = 'First Name'
    modal.search_criteria_rows.first.condition = 'Is'
    modal.search_criteria_rows.first.value_text = @first_name
    modal.add_more_criteria
    modal.search_criteria_rows[1].search_criteria = 'Last Name'
    modal.search_criteria_rows[1].condition = 'Begins With'
    modal.search_criteria_rows[1].value_text = @last_name[0,2]
    modal.search_button
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I search by providing only first name$/) do
  on(PolicyManagementPage) do |page|
    modal = page.advanced_search_modal
    modal.search_criteria_rows.first.search_criteria = 'First Name'
    modal.search_criteria_rows.first.condition = 'Is'
    modal.search_criteria_rows.first.value_text = @first_name
    modal.search_button
    page.wait_for_processing_overlay_to_close
  end
end