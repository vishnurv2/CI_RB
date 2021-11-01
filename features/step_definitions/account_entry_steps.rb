# frozen_string_literal: true

When(/^I save and close new personal account modal$/) do
  on_current_page do |page|
    page.wait_for_processing_overlay_to_close
    # Watir::Wait.until { page.new_personal_account_modal.save? || page.new_personal_account_modal.create_account_element.present?}
    page.new_personal_account_modal.save if page.new_personal_account_modal.save_element.present?
    page.new_personal_account_modal.create_account if page.new_personal_account_modal.create_account_element.present?
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I print my new account ID$/) do

  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on 'Account Overview'
  id = @browser.url.split('/').last

  CleanupHelper.register_account_for_deletion @browser.url
  STDOUT.puts "Account ID: #{id}"
end

# ------ Everything below this line is unverified ------------------------------------- #

When(/^I start typing an agency name$/) do
  on_current_page do |page|
    data = data_for('account_entry_page')
    @entered_agency = data['select_agency']
    parts = @entered_agency.split ' '
    @entered_text = (parts.first.casecmp('the').zero? ? parts[1] : parts[0])[0..4]
    page.new_personal_account_modal.agency_typeahead_name = @entered_text
  end
end

Then(/^I should see my desired agency in the list$/) do
  on_current_page do |page|
    page.new_personal_account_modal.wait_for_agency_suggestions
    expect(page.new_personal_account_modal.find_agency_suggestion(@entered_agency).nil?).to eq(false)
  end
end

And(/^The portion of the agency name I typed should be highlighted$/) do
  on_current_page do |page|
    suggestion = page.new_personal_account_modal.find_agency_suggestion(@entered_agency)
    expect(suggestion.highlighted).to eq(@entered_text)
  end
end

When(/^I enter (an|an unrestricted|a restricted) agency name$/) do |_agency_type|
  on_current_page do |page|
    data = data_for('account_entry_page')
    @entered_agency = data['select_agency']
    parts = @entered_agency.split ' '
    @entered_text = (parts.first.casecmp('the').zero? ? parts[1] : parts[0])[0..4]
    page.new_personal_account_modal.agency_typeahead_name = @entered_text
    page.new_personal_account_modal.find_agency_suggestion(@entered_agency).click
    page.wait_for_processing_overlay_to_close
    @data_used_agency = data
  end

end

When(/^I enter agency name from cache$/) do
  on_current_page do |page|
    @entered_agency = @data_used_agency['select_agency']
    parts = @entered_agency.split ' '
    @entered_text = (parts.first.casecmp('the').zero? ? parts[1] : parts[0])[0..4]
    page.new_personal_account_modal.agency_typeahead_name = @entered_text
    page.new_personal_account_modal.find_agency_suggestion(@entered_agency).click
    page.wait_for_processing_overlay_to_close
  end
end

When(/^I enter an agency name without answering the override$/) do
  on_current_page do |page|
    data = data_for('account_entry_page')
    @entered_agency = data['agency_name']
    page.agency_name_text = @entered_agency
  end
end

Then(/^The agency contact list is populated with names$/) do
  on_current_page do |page|
    expect(page.new_personal_account_modal.agency_contact_select.option_elements.count).to be_positive, "Expected the agency contact dropdown to have contacts listed, but none were found"
  end
end

Then(/^all personal products are enabled$/) do
  on_current_page do |page|
    actual = page.personal_products.product_buttons.all?(&:enabled?)
    expect(actual).to eq(true), 'Not all of the personal product buttons were enabled.'
  end
end

Then(/^only some personal products are enabled$/) do
  on_current_page do |page|
    data = data_for('account_entry_page')
    Watir::Wait.until { page.personal_products.product_buttons.any?(&:disabled?) }
    actual = page.personal_products.product_buttons.map(&:enabled?)

    expect(actual).to eq(data['enabled_products']), 'Enabled products does not match expected.'
  end
end

When(/^I (select|deselect) a the personal product "([^"]*)"$/) do |what, product|
  on_current_page do |page|
    page.add_product_modal.personal_products.send("#{product}=", what == 'select')
  end
end

Then(/^the policy dates section becomes (visible|hidden)$/) do |what|
  on_current_page do |page|
    expect(page.policy_dates_section?).to eq(what == 'visible')
  end
end

When(/^I close an applicant$/) do
  on_current_page do |page|
    @panel = page.applicants.first
    @panel.close
  end
end

Then(/^The applicant panel is hidden$/) do
  expect(@panel.present?).to be_falsey
end

When(/^I start adding an applicant$/) do
  on_current_page do |page|
    @original_panel_count = page.applicants.count
    page.add_applicant
  end
end

Then(/^there should be one more applicant panel visible$/) do
  on_current_page do |page|
    Watir::Wait.until { page.applicants.count == @original_panel_count + 1 }
  end
end

And(/^I set the policy effective date to "(.*)"$/) do |date|
  on_current_page do |page|
    page.add_product_modal.policy_effective_date = date
  end
end

And(/^I set the all products state to "(.*)"$/) do |state|
  on_current_page do |page|
    page.add_product_modal.all_products_state_element.click
    page.div(class: /p-dropdown-panel/).span(text: state.capitalize).click
  end
end

And(/^I set the policy effective date to greater than a year$/) do
  on_current_page do |page|
    page.add_product_modal.policy_effective_date = Date.today + 400
  end
end

Then(/^the policy expiration date is set to one year from the effective date$/) do
  on_current_page do |page|
    effective_date = page.add_product_modal.policy_effective_date_element.text
    date_parts = effective_date.split('/')
    date_parts[date_parts.length - 1] = (date_parts.last.to_i + 1).to_s
    expected_date = date_parts.join('/')
    actual_date = page.add_product_modal.policy_expiration_date_element.text
    expect(actual_date).to eq(expected_date), "Expected expiration date to be one year after effective date, #{effective_date} + 1 year = #{expected_date}, but #{actual_date} was found"
  end
end

Given(/^I have an account with an incomplete (.*) quote/) do |type|
  visit(LoginPage).populate
  navigate_all(using: "incomplete_#{type}".downcase.to_sym, visit: true)
  CleanupHelper.register_activity_for_deletion @browser.url
end

When(/^I save and continue on the account entry page$/) do
  on(AccountEntryPage, &:save_and_continue)
end

And(/^I enter the account$/) do
  on(AccountEntryPage).populate
end

Then(/^The effective date validation should be triggered$/) do
  on_current_page do |page|
    actual = page.add_product_modal.effective_date_validation
    expect(actual).to include('Effective Date cannot be more than 12')
  end
end


And(/^the policy expiration date is not editable$/) do
  on_current_page do |page|
    expect(page.add_product_modal.policy_expiration_date_element.disabled?).to be_truthy, 'Policy expiration date is not disabled'
  end
end


And(/^I log new (personal|commercial) account$/) do |what|
  on(PolicyManagementPage) do |page|
    page.wait_for_ajax
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
    page.existing_client_modal.add_as_new if page.existing_client_modal?
    # page.left_navigate_to_if_not_on 'Account Overview'
    page.clear_all_toasts
    if !page.new_personal_account_modal.present?
      page.add_account_button
      page.select_new_account(what)
    end
  end
end

When(/^I click on add another applicant$/) do
  on_current_page do |page|
    page.new_personal_account_modal.add_another_applicant_button_element.scroll.to
    page.new_personal_account_modal.add_another_applicant_button_element.click
  end
end

Then(/^I should see error message "([^"]*)" in the toast alert$/) do |msg|
  on(PolicyManagementPage) do |page|
    Watir::Wait.until(timeout: 10, message: "Expected to see a toast alert saying \"#{msg}\" but no alert could be found") { page.toast_container? }
    actual_error_text = page.applicant_error_message
    expect(actual_error_text.downcase).to include(msg.downcase), "Could not find '#{msg}' in error toast alert, the text found in the alert was \"#{actual_error_text}\" "
  end
end