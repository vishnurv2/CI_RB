# frozen_string_literal: true

Then(/^I can save my activity ID and account ID in a new fixture based on (.*)$/) do |fixture_file|
  data = { 'existing_account' => { 'id' => nil }, 'existing_auto_policy' => { 'id' => nil } }
  data['existing_auto_policy']['id'] = @browser.url.split('=').last
  on(PolicyManagementPage).left_nav.navigate_to 'Account Overview'
  data['existing_account']['id'] = @browser.url.split('=').last
  full_path = "#{Nenv.fixture_root}/#{fixture_file.gsub('auto_policy', 'existing_auto')}.#{Nenv.test_env.downcase}.yml"
  lines = YAML.dump(data).split("\n")
  system("tf vc checkout #{full_path}")
  File.open(full_path, 'wb') { |f| f.write(lines[1..-1].join("\n")) }
end

When(/^I remove extra data from existing auto policies$/) do
  pattern = "#{Nenv.fixture_root}/existing_account*.#{Nenv.test_env}.yml"
  Dir.glob(pattern) do |file|
    STDOUT.puts "Cleaning up #{file}"
    policy_id = YAML.safe_load(File.read(file))['existing_auto_policy']['id']
    RouteHelper.navigate_to_existing_auto(policy_id)
    on(AutoPolicySummaryPage) do |page|
      page.driver_info_panel.remove_extra_drivers
      page.vehicle_info_panel.remove_extra_vehicles
    end
  end
end

When(/^I update the insurance score to be "([^"]*)"$/) do |new_score|
  activity_id = @browser.url.split('=').last
  @acc_id = APIHelper.acc_id_from_activity(activity_id)
  APIHelper.update_insurance_score(@acc_id, new_score)
end

Then(/^the policy should be updated with the correct insurance score$/) do
  STDOUT.puts "Account ID: #{@acc_id}"
end

Then(/^I print my policy ID and account ID$/) do
  id = ''
  index = @browser.url.index('personal') + 9
  while index < @browser.url.length && '0123456789'.include?(@browser.url[index])
    id += @browser.url[index]
    index += 1
  end
  STDOUT.puts "Policy Activity ID: #{id}"
  on(PolicyManagementPage).left_nav.navigate_to 'Account Summary'
  id = ''
  index = @browser.url.index('accounts') + 9
  while index < @browser.url.length && '0123456789'.include?(@browser.url[index])
    id += @browser.url[index]
    index += 1
  end
  STDOUT.puts "Account ID: #{id}"
end

Then(/^I print my account ID$/) do
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on 'Account Summary'
  id = ''
  index = @browser.url.index('accounts') + 9
  while index < @browser.url.length && '0123456789'.include?(@browser.url[index])
    id += @browser.url[index]
    index += 1
  end
  STDOUT.puts "Account ID: #{id}"
end
