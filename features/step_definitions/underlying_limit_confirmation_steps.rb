
And(/^I add "([^"]*)" policy and validate underlying limit confirmation$/) do |product|
  on(PolicyManagementPage) do |page|
    page.toggle_side_navbar
    header = on(AccountSummaryPage)
    unless header.account_summary_h4 == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    page.product_list.add_product_element.scroll.to
    page.product_list.add_product
    page.add_product_modal.personal_products.send("#{product}=", true)
    page.wait_for_overlay_no_ajax_wait
    sleep(1)
    expect(page.underlying_limit_confirmation_modal?).to be_truthy
    expect(page.underlying_limit_confirmation_modal.dialog_message).to eq("Underlying limits are not at the minimum required by Central, do you want to continue with limits increased on the underlying policy(s)?")
  end
end