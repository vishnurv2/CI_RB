# frozen_string_literal: true

And(/^I prerenew the policy through swagger$/) do
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Summary')
  on(AccountSummaryPage) do |page|
    product = page.product_list.products.find { |p| p.status.downcase.include?('issued') || p.status.downcase.include?('inforce') }
    @product_number = product.product_cell_element.text.split(' ').last
  end
  @browser.goto(RouteHelper.swagger_url)
  on(SwaggerAPIPage) do |page|
    renew_block = page.open('renew')
    renew_block.text_field(type: 'text').set @product_number
    renew_block.execute
  end
end

And(/^I issue the policy through swagger$/) do
  policy_activity_id = @browser.url.split('=').last
  @browser.goto(RouteHelper.swagger_url)
  on(SwaggerAPIPage) do |page|
    renew_block = page.open('issue')
    renew_block.text_field(type: 'text').set policy_activity_id
    renew_block.execute
  end
end


And(/^I renew the policy through swagger$/) do
  on(AccountSummaryPage) do |page|
    @previously_opened_account_url = @browser.url
    product = page.product_list.products.find { |p| p.status.downcase.include?('issued') || p.status.downcase.include?('inforce') }
    @product_number = product.product_cell_element.text.split(' - ').last
  end
  @browser.goto(RouteHelper.swagger_url)
  on(SwaggerAPIPage) do |page|
    renew_block = page.open('renew')
    renew_block.text_field(type: 'text').set @product_number
    renew_block.execute
  end
end