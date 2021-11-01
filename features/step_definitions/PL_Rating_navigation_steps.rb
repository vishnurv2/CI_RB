
Given(/^I login PL Rating account using "([^"]*)" fixture$/) do |fixture_file_name|
  Helpers::Fixtures.load_fixture(fixture_file_name.snakecase)
  data_from_fixture = data_for('login_page_pl_rating')
  visit(PLRatingLoginPage)
  on(PLRatingLoginPage) do |page|
    page.populate_with(data_from_fixture)
    page.login
    # visit(PLRatingClientInformationPage)
    Watir::Wait.until { page.accept_button_element.present? }
    page.accept_button
    #  visit(PLRatingClientInformationPage)
    #page.window.handle.
  end
end

And(/^I click "([^"]*)" button on "([^"]*)" modal$/) do |button, modal|
  on(PLRatingManagementPage) do |page|
    page.send("#{modal.snakecase}_modal").send("#{button.snakecase}_button")
  end
end

And(/^I select company and click next button$/) do
  on(PLRatingCompanySelection).company_select_checkbox_element.click
  on(PLRatingCompanySelection).next_button_element.click
end

When(/^I click New Home Quote$/) do
  on(PLRatingClientInformationPage).new_home_quote
end

When(/^I click ok for protection class popup$/) do
  on(PLRatingProtectionClassPage).ok_button_element.click
  if on(PLRatingProtectionClassPage).ok_button_element.present?
    on(PLRatingProtectionClassPage).ok_button_element.click
  end
end

Then(/^I click new applicant and populate client information using "([^"]*)" fixture$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  data_from_fixture = data_for('client_information_modal')
  on(PLRatingManagementPage) do |page|
    #page.driver.switch_to.alert
   page.client_selection_modal.new_applicant_button_element.click
  end
  on(PLRatingClientInformationPage).populate_with(data_from_fixture)

  data_from_fixture = data_for('ssn_number')
  params = data_from_fixture.sort.collect{|k,v| v}
  on(PLRatingClientInformationPage).ssn_element.click
  on(PLRatingClientInformationPage).ssn_element.send_keys(params)

  data_from_fixture = data_for('zip')
  params = data_from_fixture.sort.collect{|k,v| v}
  on(PLRatingClientInformationPage).zip_code_element.click
  on(PLRatingClientInformationPage).zip_code_element.send_keys(params)

  data_from_fixture = data_for('cell')
  params = data_from_fixture.sort.collect{|k,v| v}
  on(PLRatingClientInformationPage).cell_phone_element.click
  on(PLRatingClientInformationPage).cell_phone_element.send_keys(params)


end

Then(/^I populate home gen information using "([^"]*)" fixture$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  data_from_fixture = data_for('home_gen_info')
  on(PLRatingHomeGenInfo).today_eff_date
  on(PLRatingHomeGenInfo).populate_with(data_from_fixture)
  data_from_fixture = data_for('gender_info')
   params = data_from_fixture.sort.collect{|k,v| v}
  if params[0] == "Male"
    on(PLRatingHomeGenInfo).gender.send_keys(:arrow_down)
  else
    on(PLRatingHomeGenInfo).gender.send_keys(:arrow_down)
    on(PLRatingHomeGenInfo).gender.send_keys(:arrow_down)
  end

  data_from_fixture = data_for('industry_info')
  params = data_from_fixture.sort.collect{|k,v| v}
  $i = 0
  $num =params[0].to_i

  while $i < $num  do
    on(PLRatingHomeGenInfo).industry.send_keys(:arrow_down)
    $i +=1
  end

  on(PLRatingHomeGenInfo).input(id: 'cmdOKSmall').click
  #on(PLRatingHomeGenInfo).industry.send_keys(:arrow_down)
end

Then(/^I populate home property information using "([^"]*)" fixture$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  data_from_fixture = data_for('home_property_info')
  on(PLRatingHomePropertyInfo).populate_with(data_from_fixture)
  on(PLRatingHomePropertyInfo).input(id: 'cmdOKSmall').click
end


Then(/^I populate home coverage information using "([^"]*)" fixture$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  data_from_fixture = data_for('home_coverage_info')
  on(PLRatingHomeCoverageInfo).populate_with(data_from_fixture)
  on(PLRatingHomeCoverageInfo).input(id: 'cmdOKSmall').click
end

When(/^I navigate to Rating page via additional info page and click on carrier link$/) do
  on(PLRatingHomeCoverageInfo).input(id: 'rptrOptionSections_ctl00_uclOptionList_rptrOptions_ctl02_chkOption').click
  on(PLRatingHomeCoverageInfo).input(id: 'cmdOKSmall').click
  sleep(10)
  on(PLRatingHomeCoverageInfo).input(id: 'cmdOKSmall').click
  sleep(10)
  on(PLRatingHomeCoverageInfo).input(id: 'cmdRate').click
  sleep(10)
  Watir::Wait.while(timeout: 120) { on(PLRatingHomeCoverageInfo).spinner.present? }

  on(PLRatingHomeCoverageInfo).td(class: 'submit').img.click
end


Then(/^I switch to Pat system bridge link and verify the premium$/) do
  handles = @browser.driver.window_handles
  @browser.driver.switch_to.window handles[1]
  #on(PolicyManagementPage).span(text: 'IN - Homeowners')
end

