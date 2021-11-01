
And(/^I complete carrier setup using "([^"]*)" fixture$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  data_from_fixture = data_for('ezlynx_carrier_setup')
  on(EzlynxManagementPage) do |page|
    page.left_nav_bar.settings_element.hover
    page.left_nav_bar.carrier_quoting_setup
    page.button(class: 'mat-focus-indicator mat-button mat-button-base mat-primary').click
    #page.carrier_setup_page.view_details_button
    page.div(text: 'Logins').click
    #page.carrier_setup_page.logins
    page.carrier_setup_page.populate_with(data_from_fixture)
    page.carrier_setup_page.save_button
  end
end

And(/^I click on "([^"]*)" button on "([^"]*)" modal$/) do |button, modal|
  on(EzlynxManagementPage) do |page|
    page.send("#{modal.snakecase}_modal").send("#{button.snakecase}_button")
    sleep(15)
  end
end

And(/^I click on Answer Questions and Submit$/) do
  on(EzlynxManagementPage) do |page|
    page.button(xpath: '//span[contains(text()," Answer Questions ")]/..').click
    page.button(xpath: '//span[contains(text()," Submit ")]/..').click
    Watir::Wait.until(timeout: 100) {page.ez_quote_results_modal.progress_bar.present?}
    if page.ez_quote_results_modal.access_quote_button_element.present?
      # page.ez_quote_results_modal.access_quote_button
      page.span(title: 'Jordann  Gooding').click
      page.a(id: 'LogoutLink', role: 'menuitem').click
    end
  end
end

Then(/^I navigate to carrier questions and populate data using "([^"]*)" fixture$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  data_from_fixture = data_for('ez_carrier_questions')
  on(EzlynxManagementPage) do |page|
    page.ez_auto_coverage.carrier_questions_button
    page.wait_for_ajax
    page.ez_carrier_questions.populate_with(data_from_fixture)
  end
end

Then(/^ I answer questions on "([^"]*)" modal$/) do |modal|

  on(EzlynxManagementPage) do |page|
    page.send("#{modal.snakecase}_modal").send("answer_questions_button")
    page.send("#{modal.snakecase}_modal").send("submit_answers_button")
  end
end

Then(/^I populate dwelling information using "([^"]*)" fixture$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  data_from_fixture = data_for('dwelling_informaion')
  on(EzlynxManagementPage) do |page|
    page.ez_dwelling_information_modal.populate_with(data_from_fixture)
  end
end

Then(/^I populate general coverages using "([^"]*)" modal$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  data_from_fixture = data_for('general_coverges')
  on(EzlynxManagementPage) do |page|
    page.ez_home_coverage_info_modal.populate_with(data_from_fixture)
  end
end

When(/^I create a new Quote using "([^"]*)" fixture$/) do |fixture_file|
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(EzlynxManagementPage) do |page|
    page.left_nav_bar.add_applicants_element.hover
    page.left_nav_bar.create_new_applicant
    Watir::Wait.until(timeout: 10) { page.personal_lines_applicant.present? }

    data_from_fixture = data_for('ssn_id')
    params = data_from_fixture.sort.collect{|k,v| v}
    page.personal_lines_applicant.ssn_element.click
    page.personal_lines_applicant.ssn_element.send_keys(:arrow_left)
    page.personal_lines_applicant.ssn_element.send_keys(params)
    page.personal_lines_applicant.ssn_element.send_keys(:arrow_left)
    page.personal_lines_applicant.ssn_element.send_keys(params)

    data_from_fixture = data_for('applicant_info')
    page.personal_lines_applicant.populate_with(data_from_fixture)

    modal = page.personal_lines_applicant
    modal.send("save")
    Watir::Wait.until(timeout: 15) { page.side_bar.present? }
    modal.send("go_to_auto")

    data_from_fixture = data_for('general_information_modal')
    sleep(15)
    page.ez_general_information_modal.populate_with(data_from_fixture)

    page.send("ez_general_information_modal").send("policy_info_button")
    sleep(15)

    data_from_fixture = data_for('policy_information')
    page.ez_policy_information_modal.populate_with(data_from_fixture)
    data_from_fixture = data_for('policy_eff_date')
    page.ez_policy_information_modal.policy_effective_date_element.send_keys(:control, 'a')
    page.ez_policy_information_modal.policy_effective_date_element.send_keys(:backspace)
    page.ez_policy_information_modal.populate_with(data_from_fixture)

    data_from_fixture = data_for('ez_driver_information')
    page.ez_policy_information_modal.driver_info_button
    page.wait_for_ajax
    page.ez_driver_information.populate_with(data_from_fixture)

    data_from_fixture = data_for('ez_vehicle_information')
    page.ez_driver_information.vehicle_info_button
    page.wait_for_ajax
    page.ez_vehicle_information.populate_with(data_from_fixture)
    page.ez_vehicle_information.vin_lookup_button
    sleep(3)

    data_from_fixture = data_for('ez_incidents_information')
    page.ez_vehicle_information.goto_incidents_button
    page.wait_for_ajax
    page.ez_incidents_information.populate_with(data_from_fixture)

    data_from_fixture = data_for('ez_coverage_information')
    page.ez_incidents_information.goto_coverage_button
    Watir::Wait.until(timeout: 10) {page.ez_auto_coverage.state_amount_element.present?}
    page.ez_auto_coverage.populate_with(data_from_fixture)
    page.ez_auto_coverage.carrier_questions_button
    Watir::Wait.until(timeout: 10) {page.ez_carrier_questions_modal.pay_in_full_discount.present?}
    page.ez_carrier_questions_modal.populate_with("pay_in_full_discount"=>"No")

  end
end


Then(/^I switch to Pat system bridge link and verify the premium against Ezlynx$/) do
  premium_ezlynx = on(EzlynxManagementPage).div(class: 'premium-details dark-theme-card-background ng-star-inserted').span.text
  handles = @browser.driver.window_handles
  @browser.driver.switch_to.window handles[1]
  on(PolicyManagementPage).span(text: 'IN - Auto').click
  premium_pat = on(PolicyManagementPage).span(id: 'quotePremium').text[0...-3]
  #on(PolicyManagementPage).span(text: 'IN - Homeowners')
  expect(premium_ezlynx).to eq(premium_pat)
end

Then(/^I verify mailing address against Ezlynx$/) do
  RubyExcelHelper.safe_load_fixture_file('ezlynx_pat_t3847')
  data_from_fixture = data_for('applicant_info')
  on(AutoPolicySummaryPage).general_info_panel.address_element.text
  add_string = data_from_fixture["address_line_one"] + ", " + data_from_fixture["address_city"] + ", " + data_from_fixture["address_state"] + " " + data_from_fixture["postal_code"]
  expect(add_string).to eq(on(AutoPolicySummaryPage).general_info_panel.address_element.text)
end

