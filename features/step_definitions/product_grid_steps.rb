# frozen_string_literal: true

When(/^I try to delete the auto product$/) do
  on(AccountSummaryPage) do |page|
    @orig_product_count = page.product_list.products.count
    @found_product = page.product_list.products.first
    @found_product.policy_info_btn
    @found_product.delete_product
  end
end

Then(/^I should be prompted if I really want to delete the product$/) do
  expect(@found_product.remove_confirm_message?).to be_truthy, 'The prompt to confirm product removal to not show up.'
end

When(/^I answer (no|yes) to deleting the product$/) do |which|
  @found_product.send("delete_#{which}")
end

Then(/^the product (should|should not) be removed from the product grid$/) do |which|
  on(AccountSummaryPage) do |page|
    if which == 'should'
      expect(page.product_list.products?).to be_falsey, "Product has not been deleted"
    else
      expect(page.product_list.products.count).to eq(@orig_product_count)
    end
  end
end

# ------ Everything below this line is unverified ------------------------------------- #
#
#

Then(/^the product status should be "([^"]*)"$/) do |status|
  on(AccountSummaryPage) do |page|
    page.product_list.quotes_tab if page.product_list.quotes_tab_element.parent.attributes[:aria_selected] == 'false'
    page.product_list.policies_tab if status.downcase == 'inforce' # Another terrible hack for now
    page.product_list.policies_tab if status.downcase == 'issued' ## Terrible hack for now.  Issued status only shows on Policy tab

    Watir::Wait.until { !page.product_list.products.first&.status.to_s.empty? }
    product = page.product_list.products.first
    expect(product&.status.downcase).to eq(status.downcase), "Product status of '#{product&.status}' does not match expected status of '#{status}'"
  end
end

Then(/^the products status should be "([^"]*)"$/) do |status|
  on(AccountSummaryPage) do |page|
    page.product_list.quotes_tab if page.product_list.quotes_tab_element.parent.attributes[:aria_selected] == 'false'
    page.product_list.policies_tab if status.downcase == 'inforce' # Another terrible hack for now
    page.product_list.policies_tab if status.downcase == 'issued' ## Terrible hack for now.  Issued status only shows on Policy tab

    Watir::Wait.until { !page.product_list.products.first&.status.to_s.empty? }
    page.product_list.products.each do |product|
      expect(product&.status.downcase).to eq(status.downcase), "Product status of '#{product&.status}' does not match expected status of '#{status}'"
    end
  end
end

And(/^I should be able to complete the quote$/) do
  on(AccountSummaryPage) do |page|
    product = page.product_list.products.first
    product.open_product
  end

  on(AutoPolicySummaryPage) do |page|
    page.populate_auto_policy_modals
    page.sidebar.select_option('account summary')
  end

  on(AccountSummaryPage) do |page|
    product = page.product_list.products.first
    expect(product&.status).to eq(status), "Product status of '#{product&.status}' does not match expected status of '#{status}'"
  end
end

When(/^I select (.*) for the auto product$/) do |which|
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    @found_product = page.product_list.products.first
    @original_status ||= @found_product.status
    @found_product.policy_info_btn
    @found_product.send(which.snakecase)
    page.wait_for_processing_overlay_to_close
  end
end

And(/^the (.*) option should be available for the auto product$/) do |which|
  @found_product.policy_info_btn
  expect(@found_product.send("#{which}?")).to be_truthy
  @found_product.policy_info_btn
end

Then(/^the product status should be back to the original value$/) do
  expect(@found_product.status).to eq(@original_status)
end

And(/^the product status color (should|should not) be red$/) do |should_or_not|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  error_class_as_expected = (on(AccountSummaryPage).product_list.products.first.attribute('class').include?('row-validation-error') == (should_or_not == 'not'))
  expect(error_class_as_expected).to be_truthy, "Expected the first product in the product grid on the Account Summary page#{should_or_not.gsub('should', '')} to appear red (class containing 'row-validation-error' when red)"
end

Then(/^I (should|should not) see a policy with the status "([^"]*)"$/) do |should_or_not, status|
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Summary')
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  status_found = on(AccountSummaryPage).product_list.products.any? { |p| p.status.downcase == status.downcase }
  expect(status_found).to eq(should_or_not == 'should'), "Expected#{should_or_not.gsub('should', '')} to find a product with a status of \"#{status}\" but it was#{'should not'.gsub(should_or_not, '')} found"
end

Then(/^the products status should be "([^"]*)" or "([^"]*)"$/) do |status1, status2|
  on(AccountSummaryPage) do |page|
    page.product_list.quotes_tab if page.product_list.quotes_tab_element.parent.attributes[:aria_selected] == 'false'
    page.product_list.policies_tab if status1.downcase == 'inforce' # Another terrible hack for now
    page.product_list.policies_tab if status2.downcase == 'issued' ## Terrible hack for now.  Issued status only shows on Policy tab

    Watir::Wait.until { !page.product_list.products.first&.status.to_s.empty? }
    page.product_list.products.each do |product|
      expect((product&.status.downcase==status1.downcase) || (product&.status.downcase==status2.downcase)).to be_truthy, "Product status of '#{product&.status}' does not match expected status of '#{status1}' or '#{status2}'"
      # if product.text.include? 'Auto Plus'
      #   expect(product&.status.downcase).to eq(status2.downcase), "Product status of '#{product&.status}' does not match expected status of '#{status2}'"
      # else
      #   expect(product&.status.downcase).to eq(status1.downcase), "Product status of '#{product&.status}' does not match expected status of '#{status1}'"
      # end
    end
  end
end

And(/^I validate Create Policy Change is disabled for already active policy$/) do
  on(AccountSummaryPage) do |page|
    row_index = page.product_list.products.find{|i| i.status.downcase == "change pending"}.rowindex
    found_product = page.product_list.products[row_index-1]
    found_product.policy_info_btn
    page.wait_for_processing_overlay_to_close
    # create_policy_change_option = page.product_list.products.first.create_policy_change
    expect(found_product.create_policy_change_element.classes.include? 'p-disabled').to be_truthy
    page.wait_for_processing_overlay_to_close
  end
end

And(/^I click on Create Policy Change from Account Overview$/) do
  on(AccountSummaryPage) do |page|
    found_product = page.product_list.products.last
    found_product.policy_info_btn
    page.product_list.products.last.create_policy_change
    page.wait_for_processing_overlay_to_close
  end
end

And(/^I validate the status should be "([^"]*)" for policy change$/) do |change_pending|
  on(AccountSummaryPage) do |page|
    found_status = page.product_list.products.last.status
    expect(found_status).to eq(change_pending)
    page.wait_for_processing_overlay_to_close
  end
end