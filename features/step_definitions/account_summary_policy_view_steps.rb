# frozen_string_literal: true

When(/^I issue the policy$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Issue')
  on(PolicyIssuancePage).issue_policy
end

And(/^I should see "([^"]*)" quote in the products tab row$/) do |quote|
  on(PolicyManagementPage).left_nav.navigate_to("Account Overview")
  on(AccountSummaryPage) do |page|
    tab = page.product_list.quotes_tab_element.text
    quote_count = tab.split(' ').last #split out the number in Quotes(1)
    expect(quote.to_i).to eq(quote_count.to_i), "Expected \"#{quote}\" quote, but actually found \"#{quote_count}\""
  end
end

Then(/^I should see a billing account in the Billing Summary$/) do
  on(AccountSummaryPage) do |page|
    actual_billing_acct = page.payment_options.billing_acct.first.actions # << probably wondering why im using actions instead of billing_account

    # @billing_account instance var captured in billing_steps.rb!
    expected_billing_acct = @billing_account
    expect(expected_billing_acct.to_i).to eq(actual_billing_acct.to_i), "Expected \"#{expected_billing_acct}\" billing account, but actually found \"#{actual_billing_acct}\""
  end
end

And(/^I navigate to the first product$/) do
  on(AccountSummaryPage) do |page|
    page.product_list.products.first.product_link.click!
    page.wait_for_ajax
  end
end

Then(/^The "([^"]*)" icon (should|should not) be visible$/) do |what, which|
  expected_not_str = which.gsub('should', '')
  actual_not_str = ' not'.gsub(expected_not_str, '')
  on(AccountSummaryPage) do |page|
    icon = page.applicants_panel.applicants.first.send("#{what}?")
    expect(icon).not_to be_nil, "Expected#{expected_not_str} to see '#{what}' icon, but it was#{actual_not_str} found"
  end
end

And(/^The "([^"]*)" button (should|should not) be visible$/) do |what, which|
  expected_not_str = which.gsub('should', '')
  actual_not_str = ' not'.gsub(expected_not_str, '')
  on(AccountSummaryPage) do |page|
    button = page.applicants_panel.send("#{what}?")
    expect(button).to eq(which.casecmp('should not').zero?), "Expected#{expected_not_str} to see '#{what}' button, but it was#{actual_not_str} found"
  end
end

Then(/^The action icons and roles should not be visible$/) do
  on(PartyInformationSummaryPage) do |page|
    RSpec.capture_assertions do
      expect(page.included_parties_panel.add_party?).to be_falsey
      expect(page.included_parties_panel.disabled_trashcan?).to be_falsey
    end
  end
end

Then(/^The products section has "([^"]*)" icon$/) do |icon|
  on(AccountSummaryPage) do |page|
    page.product_list.products.effective_date
  end
end

When(/^I click the "([^"]*)" tab in the products list$/) do |arg|
  on(AccountSummaryPage) do |page|
    opt = arg.downcase
    page.product_list.send("#{opt}_tab")
  end
end

