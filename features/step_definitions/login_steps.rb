# frozen_string_literal: true

Given(/^I have logged in$/) do
  visit(LoginPage).populate unless @browser.url.include?("/PolicyAdminWeb/PL/account") || @browser.url.include?("/PolicyAdminWeb/dashboard")
  @browser.refresh
  visit(PolicyManagementPage)
end

Given(/^I start to log in$/) do
  visit(LoginPage)
  #on(PolicyManagementPage).left_nav.navigate_to('Log Out')

  # if on(PolicyManagementPage).left_nav.present?
  #   on(PolicyManagementPage).user_avatar_element.click
  #   on(PolicyManagementPage).log_out
  # end
end

When(/^I try to log in with.*$/) do
  on(LoginPage).populate
end

Given(/^I log in with a bad password using the "([^"]*)"$/) do |fixture|
  visit(LoginPage)
  # unless @browser.url.include?("/PolicyAdminWeb/accounts") || @browser.url.include?("/PolicyAdminWeb/dashboard")
  #on(PolicyManagementPage).left_nav.navigate_to('Log Out') if on(PolicyManagementPage).left_nav.present?
  # if on(PolicyManagementPage).left_nav.present?
  #   on(PolicyManagementPage).user_avatar_element.click
  #   on(PolicyManagementPage).log_out
  # end

  on(LoginPage).populate_login(fixture)
end

Then(/^I should see "([^"]*)" in the "([^"]*)" error section of the login form$/) do |message, type|
  on(LoginPage) do |page|
    expect(page.send("#{type.snakecase}_error")).to include(message), "Could not find '#{message}' the toast alert"
  end
end

And(/^I have logged in using the credentials from the file "([^"]*)"$/) do |fixture_file_name|
  Helpers::Fixtures.load_fixture(fixture_file_name.snakecase)
  visit(LoginPage).populate
  @browser.refresh
  visit(PolicyManagementPage)
end

Then(/^I should be on the (.*) page$/) do |page_name|
  on(page_name.to_page_class) do |page|
    expect(page.displayed?).to be_truthy
  end
end

Then(/^The "([^"]*)" page should be displayed$/) do |page_name|
  # this is almost a dup of "I should be on the "" page" but for use outside of outline
  on(page_name.to_page_class) do |page|
    expect(page.displayed?).to be_truthy
  end
end

And(/^I stop$/) do
  binding.pry if Nenv.cuke_debug?
end

Then(/^I stop on the (.*) page$/) do |page_name|
  page = on(Object.const_get("#{page_name}Page".camelcase(:upper)))
  binding.pry
end

Then(/^I log out$/) do
  #on(PolicyManagementPage).left_nav.find_option('Log Out').scroll.to
  #on(PolicyManagementPage).left_nav.navigate_to('Log Out')

  # new logout way.
  if on(PolicyManagementPage).left_nav.present?
    on(PolicyManagementPage).user_avatar_element.click
    on(PolicyManagementPage).log_out
  end
end

Then(/^I should see failure message in the toast alert$/) do
  on(LoginPage) do |page|
    msg = "Login failed"
    expect(page.failed_login.include? msg).to be_truthy, "Expected to find a Authentication failure toast with message, but did not!"
    # msg = ['Failed Login', 'Authentication Error'] # acceptible auth error messages.
    # expect(msg.include? page.failed_login).to be_truthy, "Expected to find a Authentication failure toast with message, but did not!"
  end
end

Then(/^I detect toasters$/) do
  @toasters = []
  on(PolicyManagementPage) do |page|
    msg = page.toast_container.divs(class: 'toast-error').to_a.map { |x| x.text }
    STDOUT.puts msg
  end
end

Given(/^I login legacy account using "([^"]*)" fixture$/) do |fixture_file_name|
  #Helpers::Fixtures.load_fixture(fixture_file_name.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file_name)
  data_from_fixture = data_for('login_page')
  visit(LegacyLoginPage)
  on(LegacyLoginPage) do |page|
    page.populate_with(data_from_fixture)
    page.login
  end
end

And(/^I save the url of created policy and logout from the agent account and login as a CMI employee with "([^"]*)"$/) do |fixture_file|
  on(PolicyManagementPage) do
    saved_policy_url = @browser.url
    if on(PolicyManagementPage).left_nav.present?
    on(PolicyManagementPage).user_avatar_element.click
    on(PolicyManagementPage).log_out
    end
    #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
    RubyExcelHelper.safe_load_fixture_file(fixture_file)
    visit(LoginPage).populate
    visit(PolicyManagementPage)
    @browser.goto(saved_policy_url)
  end
end

Given(/^I login my central account using "([^"]*)" fixture$/) do |fixture_file_name|
  #Helpers::Fixtures.load_fixture(fixture_file_name.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file_name)
  data_from_fixture = data_for('login_page')
  visit(MyCentralLoginPage)
  on(MyCentralLoginPage) do |page|
    page.populate_with(data_from_fixture)
    page.login
    page.wait_for_ajax
    page.security_answer = 'test'
    page.element(xpath: '//input[@type = "submit"]').click
  end
end

Then(/^I should open "([^"]*)"$/) do |modal_name|
  on(PolicyManagementPage) do |page|
    modal = page.send("#{modal_name.downcase.snakecase}")
    expect(modal.present?).to be_truthy
  end
end

Given(/^I login ezlynx account using "([^"]*)" fixture$/) do |fixture_file_name|
  #Helpers::Fixtures.load_fixture(fixture_file_name.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file_name)
  data_from_fixture = data_for('login_page_ezlynx')
  visit(EzlynxLoginPage)
  on(EzlynxLoginPage) do |page|
    page.populate_with(data_from_fixture)
    page.login
    if page.div(id: 'alertMessage').present?
      page.populate_with(data_from_fixture)
      page.login
    end
  end
end


Given(/^I login to PAT system using "([^"]*)" fixture$/) do |fixture_file_name|
  #Helpers::Fixtures.load_fixture(fixture_file_name.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file_name)
  data_from_fixture = data_for('login_page')
  visit(LoginPage)
  url = @browser.url
  visit(LoginPage).populate unless url.include?("/PolicyAdminWeb/PL/account") || url.include?("/PolicyAdminWeb/PL/auto") || url.include?("/PolicyAdminWeb/dashboard")
  @browser.refresh
  visit(PolicyManagementPage)

  #hard coded validations
  expect(on(QuoteManagementPage).quote_total_premium).to eq("$3,074.00")
  visit(AccountSummaryPage)
  on(AccountSummaryPage).applicants_panel.applicants.first.edit





end