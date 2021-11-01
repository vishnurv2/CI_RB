# frozen_string_literal: true

When(/^I click the cancel renew button$/) do
  on(AccountSummaryPage) do |page|
    page.product_list.products.first.three_dots
    page.product_list.products.first.cancel_renew
    #page.product_list.products_grid.items.first.cancel_renew_element.scroll.to
    #page.product_list.products_grid.items.first.cancel_renew_element.click!
  end
end

When(/^I reinstate the cancellation$/) do
  on(AccountSummaryPage) do |page|
    if !(page.product_list.products.first.status == "INFORCE")
      page.product_list.products.first.three_dots
      page.product_list.products.first.cancel_renew
      # page.product_list.products.first.reinstate
      modal = page.cancel_non_renew_modal
      page.wait_for_processing_overlay_to_close
      Watir::Wait.until { modal.present? }
      modal.remove_cancellation
      page.wait_for_processing_overlay_to_close
    end
    #page.product_list.products_grid.items.first.cancel_renew_element.scroll.to
    #page.product_list.products_grid.items.first.cancel_renew_element.click!
  end
end

Then(/^The policy mailing address should be correct$/) do
  on(AccountSummaryPage) do |page|
    modal = page.cancel_non_renew_modal
    expected_addr = modal.expected_mailing_address
    expect(modal.policy_mailing_address.upcase).to eq(expected_addr.upcase)
  end
end

Then(/^the policy should show "([^"]*)"$/) do |expected_status|
  on(AccountSummaryPage) do |page|
    actual_status = page.product_list.products.first.status
    expect(actual_status.downcase).to eq(expected_status.downcase), "Expected the status of the product to be \"#{expected_status}\" but found \"#{actual_status}\"!"
  end
end

When(/^I cancel a policy with reasons in the "([^"]*)" file$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @cancellation_data = data_for('cancel_non_renew_modal')
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    page.product_list.products.first.three_dots
    page.product_list.products.first.cancel_renew

    modal = page.cancel_non_renew_modal
    page.wait_for_ajax
    modal.populate_cancel_modal(@cancellation_data)
  end
end

When(/^I close the cancellation modal$/) do
  on(AccountSummaryPage) do |page|
    modal = page.cancel_non_renew_modal
    modal.save_and_close if modal.save_and_close?  # Temporary
    modal.close if modal.close?
    Watir::Wait.while(timeout: 30, message: 'Timed Out Waiting for the Cancellation Modal to Disappear') { modal.present? }
    page.wait_for_ajax
  end
end

Then(/^Cancel effective date should be "([^"]*)" days from date generated$/) do |days|
  on(AccountSummaryPage) do |page|
    modal = page.cancel_non_renew_modal
    actual_days = modal.calculate_notice_effective_day_difference
    expect(actual_days.to_i).to eq(days.to_i), "Expected Cancel Effective Date to be \"#{days}\" days in the future!"
  end
end

Then(/^I save and close the cancel_non_renew modal$/) do
  on(AccountSummaryPage) do |page|
    modal = page.cancel_non_renew_modal
    modal.save_and_close if page.cancel_non_renew_modal?
  end
end

And(/^I remove the cancellation$/) do
  on(AccountSummaryPage) do |page|
    modal = page.cancel_non_renew_modal

    modal.remove_cancellation
    modal.save_and_close if page.cancel_non_renew_modal?
  end
end


Then(/^I should not be able to edit any details$/) do
  on(AccountSummaryPage) do |page|
    page.product_list.products.first.policy_info_btn
    page.product_list.products.first.cancel_renew

    modal = page.cancel_non_renew_modal
    expect(modal.reason_dropdown_element.disabled?).to be_truthy, "Expected the reason dropdown on cancel non-renew modal to be disabled but it was enabled"
    expect(modal.cancel_effective_date_element.disabled?).to be_truthy, "Expected the cancel effective date on cancel non-renew modal to be disabled but it was enabled"
    end
end

And(/^the policy should show "([^"]*)" or "([^"]*)" with tooltip message "([^"]*)"$/) do |status1, status2, tooltip_msg|
  on(AccountSummaryPage) do |page|
    actual_status = page.product_list.products.first.status
    expect((actual_status.downcase==status1.downcase) || (actual_status.downcase==status2.downcase)).to be_truthy, "Product status of '#{actual_status.downcase}' does not match expected status of '#{status1}' or '#{status2}'"
    # expect(actual_status.downcase).to eq(status1.downcase), "Expected the status of the product to be \"#{status1}\" but found \"#{actual_status}\"!"
    page.product_list.products.first.info_circle_element.hover
    expect(page.div(class: /p-tooltip-text/).text.strip).to eq(tooltip_msg)
  end
end

And(/^the policy should show "([^"]*)" with tooltip message includes "([^"]*)"$/) do |expected_status, tooltip_msg|
  on(AccountSummaryPage) do |page|
    actual_status = page.product_list.products.first.status
    expect(actual_status.downcase).to eq(expected_status.downcase), "Expected the status of the product to be \"#{expected_status}\" but found \"#{actual_status}\"!"
    page.product_list.products.first.info_circle_element.hover
    expect(page.div(class: /p-tooltip-text/).text.strip.include? (tooltip_msg)).to be_truthy
  end
end

When(/^I click on three dots again option "([^"]*)" should be available in list$/) do |option|
  on(AccountSummaryPage) do |page|
    page.product_list.products.first.three_dots
    opt = page.product_list.products.first.reinstate_element.text
    expect(opt).to eq(option)
  end
end

Then(/^I reinstate the policy$/) do
  on(AccountSummaryPage) do |page|
    page.product_list.products.first.reinstate
    modal = page.cancel_non_renew_modal
    modal.remove_cancellation
  end
end

Then(/^I validate reason dropdown for cancel$/) do |table|
  expected = table.rows.flatten
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    page.product_list.products.first.three_dots
    page.product_list.products.first.cancel_renew
  end
  on(PolicyManagementPage) do |page|
    modal = page.cancel_non_renew_modal
    modal.policy_transaction_type= 'Cancel' if modal.cancel_non_renew_option_element.present?
    select_list = modal.reason_dropdown.options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found"
      end
    end
  end
end

When(/^I cancel a policy with reason as "([^"]*)"$/) do |opt|
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    page.product_list.products.first.three_dots
    page.product_list.products.first.cancel_renew

    modal = page.cancel_non_renew_modal
    page.wait_for_ajax
    modal.policy_transaction_type = "Cancel"
    modal.reason_dropdown = opt
    modal.cancel_effective_date_input = "Today"
  end
end