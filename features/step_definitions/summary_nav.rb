# frozen_string_literal: true


# ------ Everything below this line is unverified ------------------------------------- #

When(/^I have opened the (.*) summary for (\d+)$/) do |which, id|
  url = "#{Nenv.base_url}/PolicyManagement/PersonalProducts/Auto?policyActivityId=#{id}" if which.casecmp('auto').zero?
  url = "#{Nenv.base_url}/PolicyManagement/Account/Information?accountNumber=#{id}" if which.casecmp('account').zero?
  @browser.goto(url)
end

When(/^I have opened the (.*) summary from my fixture$/) do |which|
  RouteHelper.send("navigate_to_existing_#{which}")
end

When(/^I have opened the account summary opened previously$/) do
  @browser.goto(BasePage.account_number)
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Summary')
end
