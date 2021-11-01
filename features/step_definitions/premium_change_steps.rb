And(/^I validate premium change modal notification toast$/) do
  on(PolicyManagementPage) do |page|
    expect(page.premium_change_toast_message.include? 'The premium has changed as a result of report ordering.').to be_truthy
    page.premium_change_view_details_element.click
    page.wait_for_ajax
    modal = page.premium_change_modal
    modal.ok
    page.wait_for_ajax
  end
end

Then(/^I validate premium change modal notification toast for affiliate discount$/) do
  on(PolicyManagementPage) do |page|
    expect(page.premium_change_toast_message.include? 'The premium has changed as a result of affiliate discount.').to be_truthy
    page.premium_change_view_details_element.click
    page.wait_for_ajax
    modal = page.premium_change_modal
    modal.ok
    page.wait_for_ajax
  end
end