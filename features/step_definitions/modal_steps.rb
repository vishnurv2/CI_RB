# frozen_string_literal: true

Then(/^The "([^"]*)" modal should be visible$/) do |which|
  on_current_page do |page|
    Watir::Wait.until { page.send("#{which.snakecase}_modal?") }
    page.wait_for_ajax
    expect(page.send("#{which.snakecase}_modal?")).to be_truthy
  end
end

Then(/^I close the "([^"]*)" modal$/) do |which|
  on_current_page do |page|
    being_dismissed = page.send("#{which.snakecase}_modal")
    page.clear_all_toasts
    being_dismissed.dismiss if being_dismissed.dismiss_button?
    @browser.refresh
    page.wait_for_ajax
  end
end

# # # ------ Everything below has been NOT VERIFIED ------------------------------------- #

And(/^I (|save and close|save and continue|dismiss) the "([^"]*)" modal$/) do |what, modal|
  on_current_page do |page|
    page.send("#{modal.downcase.snakecase}_modal").send("#{what.downcase.snakecase}")
    page.wait_for_ajax
  end
end

Then(/^The "([^"]*)" modal should not be visible$/) do |modal_prefix|
  on_current_page do |page|
    expect(page.send("#{modal_prefix.snakecase}_modal?")).to be_falsey
  end
end

When(/^I select "([^"]*)" for the "([^"]*)" dropdown on the "([^"]*)" modal$/) do |selection, dropdown, modal|
  on_current_page.send("#{modal.snakecase}_modal").send("#{dropdown.snakecase}=", selection)
end

Then(/^I (should|should not) see the "([^"]*)" modal on the "([^"]*)" page$/) do |should_or_not, modal_name, page_name|
  expected_not_str = should_or_not.gsub('should', '')
  actual_not_str = ' not'.gsub(expected_not_str, '')
  on(Object.const_get("#{page_name.snakecase.camelcase(:upper)}Page")) do |page|
    expect(page.send("#{modal_name.snakecase}_modal?") == (should_or_not == 'should')).to be_truthy, "Expected#{expected_not_str} to see the #{modal_name} modal on the #{page_name} page, but it was#{actual_not_str} found"
  end
end

And(/^I save and continue on the (.*) modal$/) do |modal_name|
  on(PolicyManagementPage) do |page|
    if modal_name == "new_personal_account"
      page.send("#{modal_name.snakecase}_modal").create_account
    else
      page.send("#{modal_name.snakecase}_modal").save_and_continue
    end
  end
end

Then(/^I should see the following validations on the (.*) modal$/) do |modal_name, table|
  on(PolicyManagementPage) do |page|
    modal = page.send("#{modal_name.snakecase}_modal")
    validations = modal.divs(class: 'p-inline-message-error').to_a + modal.divs(class: 'invalid').to_a
    RSpec.capture_assertions do
      table.hashes.each do |h|
        found_validation = validations.find { |v| v.text.snakecase.include?(h.values.first.snakecase) }
        expect(!found_validation.nil? && found_validation.present?).to be_truthy, "Expected to see an error saying \"#{h.values.first}\" on the #{modal_name} modal, but it was not found"
      end
    end
  end
end

When(/^I populate the auto driver modal$/) do
  on(PolicyManagementPage) do |page|
    page.auto_driver_modal.populate
    page.auto_driver_modal.save_and_close
  end
end

Then(/^Populating the auto vehicle coverages modal with the specified data should cause a validation on the specified coverage$/) do |table|
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    RSpec.capture_assertions do
      table.hashes.each do |h|
        Helpers::Fixtures.load_fixture(h[:file])
        modal.populate
        modal.save_and_close
        modal.coverage_list.select_coverage(h[:coverage])
        validation = modal.li(class: 'list-group-item-danger')
        validation = modal.span(class: 'field-validation-error') if validation.nil? || !validation.present?
        expect(!validation.nil? && validation.present?).to be_truthy, "Expected to see a validation on the #{h[:coverage]} panel, but it was not found"
      end
    end
  end
end

Then(/^Populating the (.*) modal with the specified data should generate a validation$/) do |modal_name, table|
  on(PolicyManagementPage) do |page|
    modal = page.send("#{modal_name.snakecase}_modal")
    RSpec.capture_assertions do
      table.hashes.each do |h|
        Helpers::Fixtures.load_fixture(h[:file])
        modal.populate
        modal.save_and_close
        validation = modal.span(class: 'field-validation-error')
        expect(!validation.nil? && validation.present?).to be_truthy, "Expected to see a validation on the #{modal_name} modal for the following reason \"#{h[:validation]}\", but it was not found"
      end
    end
  end
end

Then(/^Populating the (.*) modal with the specified data should generate a validation with the specified text$/) do |modal_name, table|
  on(PolicyManagementPage) do |page|
    modal = page.send("#{modal_name.snakecase}_modal")
    RSpec.capture_assertions do
      table.hashes.each do |h|
        Helpers::Fixtures.load_fixture(h[:file])
        modal.populate
        modal.save_and_close
        spans = modal.spans(class: 'field-validation-error')
        alerts = (modal.divs(class: 'alert-danger').to_a - modal.divs(class: %w[alert-danger hide]).to_a)
        validations = spans.select { |s| !s.nil? && s.present? && !s.text.nil? && !s.text.empty? }
        validations += alerts.select { |a| !a.nil? && a.present? && !a.text.nil? && !a.text.empty? }
        validations = validations.map(&:text)
        validation = validations.find { |v| v.downcase.include? h[:containing_text].downcase }
        expect(validation).not_to be_nil, "Expected to see a validation on the #{modal_name} modal containing the text \"#{h[:containing_text]}\", but it was not found"
      end
    end
  end
end

When(/^I open the (auto|account) general info modal$/) do |page_name|
  #on(AccountSummaryPage).clear_all_toasts
  (page_name == 'account') ? on(AccountSummaryPage).account_info.modify : on(AutoPolicySummaryPage).general_info_panel.modify
end

Then(/^I should see the "([^"]*)" modal$/) do |modal_name|
  expect(on(PolicyManagementPage).send("#{modal_name.snakecase}_modal").present?).to be_truthy, "Expected to see the #{modal_name} modal, but it was not found"
end

And(/^I refresh the page$/) do
  @browser.refresh
end

And(/^I validate the liability limits and medical payments displayed$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    modal.home_other_structures_rented_premise = true
    expect(modal.structures_rented_to_others_liability_limit).to eq(@personal_liability)
    expect(modal.structures_rented_to_others_medical_payments).to eq(@medical_payment)
  end
end

And(/^I validate error message on removing mandatory field$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    modal.home_other_structures_rented_premise_limit_element.clear
    modal.home_other_structures_rented_premise_limit_element.send_keys(:backspace)
    modal.save_and_close
    expect(modal.home_other_structures_rented_premise_limit_element.parent.parent.div.text).to eq("Total Limit for Rented Structure is required")
  end
end

Then(/^I validate primary new address dropdown is disabled$/) do
  on(PolicyManagementPage) do |page|
    modal = page.new_personal_account_modal
    expect(modal.select_address.disabled?).to be_truthy
  end
end