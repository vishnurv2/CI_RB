# frozen_string_literal: true

Then(/^I transfer the policies$/) do
  fixture_file = "authorization_server_api"
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @creds = data_for('api')
  @token = APIHelper.get_auth_token(@creds)

  @new_account = @browser.url.split('/').last
  response = PolicyTransferHelper.transfer_policies(APIHelper.header_params(@token), @original_account.to_i, @new_account.to_i)

  # Refresh the page
  @browser.refresh if response
  expect(response).to be_truthy, "Expected the Response from AccountAPI to be good, but received a bad response."
end

And(/^the policy should have transfered to the new account$/) do
  on(AccountSummaryPage) do |page|
    original_policy = @policy_activity_num
    actual_policy_num = page.product_list.products.first.product
    expect(actual_policy_num).to eq(original_policy), "Expected the original policy: \"#{original_policy}\" to match the product on the new account! Actual: \"#{actual_policy_num}\""
  end
end

Then(/^I transfer the policy to another account$/) do
  on(AutoPolicySummaryPage) do |page|
    page.actions_menu
    page.move_product_to_another_account
  end
  on(PolicyManagementPage) do |page|
    modal = page.move_products_modal
    modal.select_products_section.products.first.product_checkbox = true
    modal.next
    page.wait_for_ajax
    modal.new_account_details_section.same_account_for_all_products = true
    modal.new_account_details_section.new_products.first.account = @name
    page.wait_for_ajax
    sleep(1)
    modal.new_account_details_section.new_products.first.account_element.click
    sleep(1)
    modal.new_account_details_section.accounts_search_results.first.click
    modal.new_account_details_section.new_products.first.producer = 0
    modal.submit
  end
  @browser.goto(@original_account)
end
