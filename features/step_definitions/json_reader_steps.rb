
Given(/^I have loaded the json file and made modification$/) do
  @json_data = JsonDataHelper.modify_json_new_bussiness(@json_data)
end

Given(/^I have loaded the json file and made modification for renewal$/) do
  @json_data = JsonDataHelper.modify_json_renewal(@json_data)
end

When(/^I create policy using json data$/) do
  @response = PolicyApiHelper.create_policy_from_json(@token, @json_data)
end

When(/^I issue policy using json data$/) do
  @response = PolicyApiHelper.issue_policy_from_json(@token, @json_data)
end

Then(/^I validate the response$/) do
  expect(APIHelper.get_response_code(@response)).to eq(200), "Expected response status was not 200."
end

When(/^I saved the modified file$/) do
  filename = DataMagic.time_name('temp_input_')
  filepath = "./json/#{filename}.json"
  File.write(filepath, JSON.dump(@json_data))
  STDOUT.puts("****************Temp file created at: #{filepath}*********************")
end

Then(/^I saved the response file$/) do
  filename = DataMagic.time_name('response_input_')
  filepath = "./json/#{filename}.json"
  File.write(filepath, JSON.dump(@response.first))
  STDOUT.puts("***************API Response file created at: #{filepath}***************")
end


Given(/^I load the json file without modification$/) do
  @json_data = JsonDataHelper.load_json(@json_data)
end

And(/^I click on "([^"]*)" on issue to resolve$/) do |text|
  # on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  on(PolicyManagementPage) do |page|
    # page.left_nav.bell_icon_element.click unless page.alerts_side_bar?
    @browser.refresh
    page.issue_to_resolve
    page.wait_for_ajax
    issue = page.alerts_side_bar.issues_needing_resolved_section.find_issue_needing_resolved(text)
    issue.click
    page.wait_for_ajax
  end
end

And(/^I provide Deductible in coverage modal$/) do
  on(PolicyManagementPage) do |page|
    page.auto_policy_coverages_modal.uninsured_motorist_property_deductible = '$300'
    page.auto_policy_coverages_modal.save_and_close_btn
  end
end

And(/^I Answered Underwriter Questions and OrderReports$/) do
  # ANSWER UNDERWRITER QUESTIONS
  @browser.refresh
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  # on(PolicyManagementPage).left_nav.navigate_to("Underwriting Questions")
  on(UnderwritingQuestionsSummaryPage).resolve_issues_to_resolve
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_umbrella

  # ORDER REPORTS
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Reports"
      page.left_nav.navigate_to('Reports')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on("Reports")
  on(ReportsPage).resolve_issues_to_resolve
  puts 'naren'
end

And(/^I resolve the vehicle issue$/) do
  #on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Auto Plus')
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.vehicles.first.edit
  end
  on(PolicyManagementPage) do |page|
    modal = page.auto_vehicle_modal
    modal.annual_miles = '100'
    modal.performance = 'Standard'
    page.auto_vehicle_coverages_modal.tabs.active_tab = 'Coverage'
    model = page.auto_vehicle_coverages_modal
    model.lease_guard.lease_load_guard = 'true'
    model.lease_guard.lease_guard_button
    modal.save_and_close
  end

end

Then(/^I issue the json policy using API$/) do
  policy_activity_id = @response.first['policyActivityId'.to_sym]
  tok = APIHelper.retrieve_token
  header_params = APIHelper.header_params(tok)
  header_params[:debug_body] = "[ #{policy_activity_id} ]"
  header_params[:debug_return_type] ='Object'

  #post to basic info    http://styx.cmiprog.com/PolicyApiCore/v1/policy_activities
  api = PolicyAPI::PolicyActivitiesApi.new

  response = api.policy_activities_actions_issue_quotes_post_with_http_info(header_params)
  STDOUT.puts("*************************Response code is: #{response} **************")
end

And(/^I gather account and policy numbers for "([^"]*)" for fully issued json policy$/) do |auto_type|
  RouteHelper.login_with_creds
  url = "#{Nenv.base_url}/PolicyAdminWeb/PL/auto/#{@response.first['policyActivityId'.to_sym]}"
  @browser.goto(url)
  STDOUT.puts("*************** Navigated URL is: #{url}***************")
  on(PolicyManagementPage).left_nav.navigate_to('Account Overview')
  @account = @browser.url.split("/").last
  # on(PolicyManagementPage).left_nav.navigate_to('Policies')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
    page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to auto_type
  end
  @policy = @browser.url.split("/").last
end

Given(/^I have searched the policy "([^"]*)" using basic search$/) do |policy_number|
  RouteHelper.login_with_creds
  url = "#{Nenv.base_url}/PolicyAdminWeb/accounts"
  @browser.goto(url)
  STDOUT.puts("*************** Navigated URL is: #{url}***************")
  on(AccountSummaryPage) do |page|
    page.basic_search_section.search_text = policy_number
    page.wait_for_processing_overlay_to_close
  end
end