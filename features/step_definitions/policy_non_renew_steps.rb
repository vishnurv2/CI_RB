Then(/^I validate reason dropdown for non renew$/) do |table|
  expected = table.rows.flatten
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    page.product_list.products.first.three_dots
    page.product_list.products.first.cancel_renew
  end
  on(PolicyManagementPage) do |page|
    modal = page.cancel_non_renew_modal
    modal.policy_transaction_type= 'Non-Renew'
    select_list = modal.reason_dropdown.options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found"
      end
    end
  end
end

And(/^I validate blank wording on notice for the following reasons$/) do |table|
  expected = table.rows.flatten
  on(PolicyManagementPage) do |page|
    modal = page.cancel_non_renew_modal
    expected.each do |option|
      modal.reason_dropdown = option
      expect(modal.wording_on_notice_element.classes.include? 'p-filled').to be_falsey
    end
  end
end

And(/^I validate filled wording on notice for the following reasons$/) do |table|
  expected = table.rows.flatten
  on(PolicyManagementPage) do |page|
    modal = page.cancel_non_renew_modal
    expected.each do |option|
      modal.reason_dropdown = option
      page.wait_for_ajax
      expect(modal.wording_on_notice_element.classes.include? 'p-filled').to be_truthy
    end
  end
end

And(/^I validate "([^"]*)" option is not present$/) do |opt|
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    page.product_list.products.first.three_dots
    expect(page.product_list.products.first.send("#{opt.snakecase}_element").present?).to be_falsey
  end
end