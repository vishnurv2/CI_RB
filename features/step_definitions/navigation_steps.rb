# frozen_string_literal: true

Then(/^I should be on the (auto|account|dashboard) summary.*$/) do |which|
  on_current_page do |_page|
    expect(@browser.url).to match(/account/) if which.casecmp('account').zero?
    expect(@browser.url).to match(/auto/) if which.casecmp('auto').zero?
  end
end

Given(/^I have an existing account$/) do
  CleanupHelper.allow_registration = false # Prevent delete when done.
  RouteHelper.navigate_to_existing_account
end

Given(/^I have an existing account with an existing auto$/) do
  CleanupHelper.allow_registration = false # Prevent delete when done.
  RouteHelper.navigate_to_existing_auto
end

When(/^I visit the "([^"]*)" page$/) do |arg|
  visit(Object.const_get(arg.to_page_class))
end

When(/^I visit "([^"]*)"$/) do |arg|
  visit(Object.const_get(arg.to_page_class))
end

Given(/^I have loaded the fixture file named "([^"]*)"$/) do |fixture_file|
  # Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
end

When(/^I select "([^"]*)" option from the action menu$/) do |arg|
  on(AccountSummaryPage).actions(arg)
end

Given(/^I open the existing policy from (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  RouteHelper.navigate_to_existing_account
  on(AccountSummaryPage).ready?
end

Given(/^I open the existing auto policy from (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  RouteHelper.navigate_to_existing_auto
  on(AccountSummaryPage).ready?
end

Given(/^I have created a new "(.*)" policy$/) do |type|
  RouteHelper.login_if_needed
  begin
    navigate_all(using: type.downcase.to_sym, visit: true)
  rescue Exception => ex
    # rubocop:disable Lint/Debugger
    binding.pry if Nenv.cuke_debug?
    # rubocop:enable Lint/Debugger
    puts ex.message
    raise ex
  end
  CleanupHelper.register_activity_for_deletion @browser.url

  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

Given(/^I have started a new "(.*)" policy$/) do |_type|
  RouteHelper.login_if_needed
  begin
    navigate_all(using: :start_policy, visit: true)
  rescue Exception => ex
    # rubocop:disable Lint/Debugger
    binding.pry if Nenv.cuke_debug?
    # rubocop:enable Lint/Debugger
    puts ex.message
    raise ex
  end
  CleanupHelper.register_activity_for_deletion @browser.url
end

Given(/^I have created a new "(.*)" policy using the (.*) fixture$/) do |type, fixture_file|
  # Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)

  #visit(LoginPage).populate
  RouteHelper.login_if_needed
  begin
    navigate_all(using: type.downcase.to_sym, visit: true)
  rescue Exception => ex
    # rubocop:disable Lint/Debugger
    binding.pry if Nenv.cuke_debug?
    # rubocop:enable Lint/Debugger
    puts ex.message
    raise ex
  end
  CleanupHelper.register_activity_for_deletion @browser.url

  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

Given(/^I have created a new "(.*)" policy using the (.*) fixture and an effective date of "(.*)"$/) do |type, fixture_file, effective_date|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  DataMagic.yml['add_product_modal']['policy_effective_date'] = effective_date
  DataMagic.yml['auto_general_info_modal']['effective_date'] = effective_date
  #visit(LoginPage).populate
  RouteHelper.login_if_needed
  begin
    navigate_all(using: type.downcase.to_sym, visit: true)
  rescue Exception => ex
    # rubocop:disable Lint/Debugger
    binding.pry if Nenv.cuke_debug?
    # rubocop:enable Lint/Debugger
    puts ex.message
    raise ex
  end
  CleanupHelper.register_activity_for_deletion @browser.url

  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

Given(/^I have started a new auto policy up to the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_auto_policy("#{last_modal} modal", :up_to)
  CleanupHelper.register_activity_for_deletion @browser.url
  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

Given(/^I have started a new scheduled property policy up to the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_scheduled_property_policy("#{last_modal} modal", :up_to)
  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

When(/^I insert (\d+) new angular new account with data in the (.*) fixture$/) do |count, fixture_file|
  @added_policies ||= []
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  count.times do |time_index|
    STDOUT.puts "Starting Account #{time_index + 1}/#{count}"
    header_params = APIHelper.header_params(@token) # build auth header

    begin
      @new_account_id = APIHelper.insert_new_account(header_params, data_for('account')) # insert acount
      @insert_party_response = APIHelper.add_account_party(header_params, data_for('account_party'), @new_account_id) # Add applicant
      @new_policy_activity_id = APIHelper.create_basic_policy(APIHelper.header_params(@token), data_for('basic_auto_policy'), @new_account_id) #create basic pol
      STDOUT.puts "Pol Activity Id: #{@new_policy_activity_id}"

      @added_vehicle = APIHelper.add_vehicle_to_policy(APIHelper.header_params(@token), data_for('vehicle'), @new_policy_activity_id) #add vehicle
      @vehicle = @added_vehicle.first.to_hash
      @vehicle_id = @vehicle[:vehicleId]
      STDOUT.puts "Vehicle Id: #{@vehicle_id}"
      @risk_item_id = @vehicle[:riskItemId]
      STDOUT.puts "Risk Item Id: #{@vehicle_id}"

      @driver = APIHelper.add_driver_to_policy(APIHelper.header_params(@token), data_for('driver'), @new_policy_activity_id) #add driver
      @driver_id = @driver.first.to_hash[:policyDriverInfoId]
      STDOUT.puts "Driver Id: #{@driver_id}"
      @party_id = @driver.first.to_hash[:partyId]
      STDOUT.puts "Party Id: #{@party_id}"

      data = {
          "PartyId": @party_id,
          "DriverId": @driver_id,
          "VehicleId": @vehicle_id,
          "RiskItemId": @risk_item_id,
          "DriverAssignmentType": "Principal",
          "DriverAssignmentDescription": "Primary"
      }

      @add_driver = APIHelper.add_driver_assignment_to_policy(APIHelper.header_params(@token), data, @new_policy_activity_id)
      @driver_assignment_id = @add_driver.first.to_hash[:driverAssignmentId]

      STDOUT.puts "Driver Assignment Id: #{@driver_assignment_id}"
    rescue Exception => ex
      # rubocop:disable Lint/Debugger
      binding.pry if Nenv.cuke_debug?
      # rubocop:enable Lint/Debugger
      puts ex.message
      raise ex
    end
    @added_policies << {'existing_account' => {'id' => @new_account_id}, 'existing_auto_policy' => {'id' => @new_policy_activity_id}}
  end
end

Given(/^I have created (\d+) new "([^"]*)" policies$/) do |count, type|
  @added_policies ||= []
  count.times do |time_index|
    STDOUT.puts "Starting Account #{time_index + 1}/#{count}"
    #visit(LoginPage).populate
    url = @browser.url
    visit(LoginPage).populate unless url.include?("/PolicyAdminWeb/PL/account") || url.include?("/PolicyAdminWeb/PL/auto") || url.include?("/PolicyAdminWeb/dashboard")
    begin
      navigate_all(using: type.downcase.to_sym, visit: true)
    rescue Exception => ex
      # rubocop:disable Lint/Debugger
      binding.pry if Nenv.cuke_debug?
      # rubocop:enable Lint/Debugger
      puts ex.message
      raise ex
    end
    CleanupHelper.register_activity_for_deletion @browser.url
    act_id = @browser.url.split('/').last

    page = on(PolicyManagementPage)
    page.premium_modal.go_to_auto_summary if page.premium_modal?

    on(PolicyManagementPage) do |page|
      #page.toggle_side_navbar
      page.left_nav.navigate_to('Account Overview')
    end

    pol_id = @browser.url.split('/').last
    @added_policies << {'existing_account' => {'id' => pol_id}, 'existing_auto_policy' => {'id' => act_id}}
  end
end

Then(/^I add an additional product using the (.*) fixture$/) do |fixture_file|
  on(PolicyManagementPage) do |page|
    #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
    RubyExcelHelper.safe_load_fixture_file(fixture_file)
    @data_from_fixture = data_for('add_product_modal')
    page.add_product_modal.populate_with(@data_from_fixture)
    page.save_and_begin_quote
    page.auto_general_info_modal.save_and_close if page.auto_general_info_modal?
  end
end

Then(/^I can save the angular account and policy IDs to the (.*) file with the additional data$/) do |filename, table|
  policy = @added_policies.first
  filename = "fixtures/#{filename}.#{Nenv.test_env}.yml"
  system("tf vc checkout #{filename}")
  lines = YAML.dump(policy).split("\n")
  table.raw.flatten.each { |row| lines.insert(1, row) }
  File.open(filename, 'wb') { |f| f.write(lines.join("\n")) }
  STDOUT.puts("Wrote #{filename}")
end

When(/^I create an auto policy with applicant data under the (.*) key in the (.*) fixture$/) do |hash_key, fixture_file|

  @added_policies ||= []
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  header_params = APIHelper.header_params(@token) # build auth header

  begin
    Helpers::Fixtures.load_fixture('api_add_account_account')
    @new_account_id = APIHelper.insert_new_account(header_params, data_for('account')) # insert acount
    applicant_data = TestDataImportHelper.applicant_to_api_data(Helpers::Fixtures.load_fixture(fixture_file)[hash_key])
    @insert_party_response = APIHelper.add_account_party(header_params, applicant_data, @new_account_id) # Add applicant
    Helpers::Fixtures.load_fixture('api_add_account_basic_policy')
    @new_policy_activity_id = APIHelper.create_basic_policy(APIHelper.header_params(@token), data_for('basic_auto_policy'), @new_account_id) #create basic pol
    # will also have to add the applicant on the policy
    STDOUT.puts "Pol Activity Id: #{@new_policy_activity_id}"
  rescue Exception => ex
    # rubocop:disable Lint/Debugger
    binding.pry if Nenv.cuke_debug?
    # rubocop:enable Lint/Debugger
    puts ex.message
    raise ex
  end
  @added_policies << {'existing_account' => {'id' => @new_account_id}, 'existing_auto_policy' => {'id' => @new_policy_activity_id}}
end

Then(/^I can save the angular account IDs( with valid creds)? starting at number (\d+)$/) do |valid_creds, start|
  valid_creds = !valid_creds.nil?
  valid_creds_file_name_part = valid_creds ? '_valid_creds' : ''
  index = start.to_i
  @added_policies.each do |policy|
    filename = "fixtures/existing_angular_account#{valid_creds_file_name_part}_#{index}.#{Nenv.test_env}.yml"
    system("tf vc checkout #{filename}")
    lines = YAML.dump(policy).split("\n")
    lines.insert(1, '<%= include_yml("valid_creds.yml") %>') if valid_creds
    File.open(filename, 'wb') { |f| f.write(lines.join("\n")) }
    STDOUT.puts("Wrote #{filename}")
    index += 1
  end
end

Then(/^I can save my activity ID and account ID in the "([^"]*)" file$/) do |existing_account_file|
  data = {'existing_account' => {'id' => nil}, 'existing_auto_policy' => {'id' => nil}}
  data['existing_auto_policy']['id'] = @browser.url.split('/').last
  on(PolicyManagementPage).left_nav.navigate_to 'Account Overview'
  data['existing_account']['id'] = @browser.url.split('/').last
  full_path = "#{Nenv.fixture_root}/#{existing_account_file}.#{Nenv.test_env.downcase}.yml"
  lines = YAML.dump(data).split("\n")
  system("tf vc checkout #{full_path}")
  File.open(full_path, 'wb') { |f| f.write(lines[1..-1].join("\n")) }
end

Then(/^I can save an angular account ID starting at number (\d+)$/) do |start|
  index = start.to_i
  @added_policies.each do |policy|
    filename = "fixtures/existing_angular_account_#{index}.#{Nenv.test_env}.yml"
    #filename = "fixtures/existing_account_#{index}.#{Nenv.test_env}.yml"
    system("tf vc checkout #{filename}")
    lines = YAML.dump(policy).split("\n")
    File.open(filename, 'wb') { |f| f.write(lines[1..-1].join("\n")) }

    STDOUT.puts("Wrote #{filename}")
    index += 1
  end
end

Given(/^I have created a new "([^"]*)" policy via the API with data in the (.*) fixture$/) do |arg, fixture_file|
  # for now everything is auto policy....
  tok = RubyExcelHelper.safe_load_fixture_file('authorization_server_api') # creds file
  @creds = tok['api']
  @token = APIHelper.get_auth_token(@creds)
  header_params = APIHelper.header_params(@token) # build auth header

  begin
    #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
    RubyExcelHelper.safe_load_fixture_file(fixture_file)

    @new_account_id = APIHelper.insert_new_account(header_params, data_for('account')) # insert acount
    @account_party = data_for('account_party')
    @insert_party_response = APIHelper.add_account_party(header_params, @account_party, @new_account_id)
    #@insert_party_response = APIHelper.add_account_party(header_params, data_for('account_party'), @new_account_id) # Add applicant
    @new_policy_activity_id = APIHelper.create_basic_policy(APIHelper.header_params(@token), data_for('basic_auto_policy'), @new_account_id) #create basic pol
    STDOUT.puts "Pol Activity Id: #{@new_policy_activity_id}"

    @added_vehicle = APIHelper.add_vehicle_to_policy(APIHelper.header_params(@token), data_for('vehicle'), @new_policy_activity_id) #add vehicle
    @vehicle = @added_vehicle.first.to_hash
    @vehicle_id = @vehicle[:vehicleId]
    @risk_item_id = @vehicle[:riskItemId]

    @driver = APIHelper.add_driver_to_policy(APIHelper.header_params(@token), data_for('driver'), @new_policy_activity_id) #add driver
    @driver_id = @driver.first.to_hash[:policyDriverInfoId]
    @party_id = @driver.first.to_hash[:partyId]

    data = {
        "PartyId": @party_id,
        "DriverId": @driver_id,
        "VehicleId": @vehicle_id,
        "RiskItemId": @risk_item_id,
        "DriverAssignmentType": "Principal",
        "DriverAssignmentDescription": "Primary"
    }

    @add_driver = APIHelper.add_driver_assignment_to_policy(APIHelper.header_params(@token), data, @new_policy_activity_id)
    @driver_assignment_id = @add_driver.first.to_hash[:driverAssignmentId]
  rescue Exception => ex
    # rubocop:disable Lint/Debugger
    binding.pry if Nenv.cuke_debug?
    # rubocop:enable Lint/Debugger
    puts ex.message
    #msg = "Account: #{@new_account_id}\n #{ex}\n #{ex.message}\n"
    raise ex
  end

  url = "#{Nenv.base_url}/PolicyAdminWeb/PL/auto/#{@new_policy_activity_id}"
  RouteHelper::login_with_creds
  @browser.goto(url)
end


# ------ Everything below this line is unverified ------------------------------------- #


When(/^I view the account summary$/) do
  on_current_page do |page|
    page.sidebar.select_option('account summary')
    Watir::Wait.until { @browser.url =~ /Account\/Information\?accountNumber/ }
  end

  CleanupHelper.register_account_for_deletion @browser.url
end

Given(/^I have started a new auto policy through the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_auto_policy("#{last_modal} modal", :close_when_done)
  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

Given(/^I have started a new home policy through the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_home_policy("#{last_modal} modal", :close_when_done)
end

Given(/^I have started a new home policy up to the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_home_policy("#{last_modal} modal", :up_to)
end

Given(/^I have started a new dwelling policy through the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_dwelling_policy("#{last_modal} modal", :close_when_done)
end

Given(/^I have started a new dwelling policy up to the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_dwelling_policy("#{last_modal} modal", :up_to)
end

Given(/^I have started a new home policy going through the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_home_policy("#{last_modal} modal")
end

Given(/^I have started a new auto policy up to the "([^"]*)" modal using the (.*) fixture$/) do |last_modal, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  RouteHelper.partial_auto_policy("#{last_modal} modal", :up_to)
  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

Given(/^I have started a new auto policy through the "([^"]*)" modal using the (.*) fixture$/) do |last_modal, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  RouteHelper.partial_auto_policy("#{last_modal} modal", :close_when_done)
end

Given(/^I have started a new umbrella policy through the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_umbrella_policy("#{last_modal} modal", :close_when_done)
end

Given(/^I have started a new umbrella policy up to the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_umbrella_policy("#{last_modal} modal", :up_to)
end

Given(/^I have started a new watercraft policy through the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_watercraft_policy("#{last_modal} modal", :close_when_done)
end

Given(/^I have started a new watercraft policy up to the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_watercraft_policy("#{last_modal} modal", :up_to)
end

And(/^I add an additional (.*) "([^"]*)" product$/) do |state, product|
  on(PolicyManagementPage) do |page|
    page.toggle_side_navbar
    header = on(AccountSummaryPage)

    unless header.account_summary_h4 == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end

  on(AccountSummaryPage) do |page|
    page.product_list.add_product_element.click!
    page.add_product_modal.personal_products.send("#{product.downcase}=", true)
    page.add_product_modal.state = state
    page.add_product_modal.policy_effective_date = Chronic.parse('today')
    page.add_product_modal.save_and_begin_quote
    page.wait_for_processing_overlay_to_close
    page.populate_auto_policy_modals
  end

  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

Given(/^I add an additional (.*) "([^"]*)" product using the fixture file "([^"]*)"$/) do |state, product, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(PolicyManagementPage) do |page|
    # page.toggle_side_navbar
    header = on(AccountSummaryPage)

    unless header.account_summary_h4 == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end

  on(AccountSummaryPage) do |page|
    page.left_nav.add_product if page.left_nav.add_product?
    if page.left_nav.actions?
      page.left_nav.actions
      page.left_nav.new_quote
    end
    page.add_product_modal.personal_products.send("#{product}=", true)
    page.add_product_modal.state = state
    page.add_product_modal.policy_effective_date = Chronic.parse('today')
    page.add_product_modal.save_and_begin_quote
    page.wait_for_processing_overlay_to_close
    page.populate_auto_policy_modals
  end
  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end


Then(/^I can save the account IDs starting at number (\d+)$/) do |start|
  index = start.to_i
  @added_policies.each do |policy|
    filename = "fixtures/existing_account_#{index}.#{Nenv.test_env}.yml"
    system("tf vc checkout #{filename}")
    lines = YAML.dump(policy).split("\n")
    File.open(filename, 'wb') { |f| f.write(lines[1..-1].join("\n")) }

    STDOUT.puts("Wrote #{filename}")
    index += 1
  end
end

When(/^I have populated the (.*) modal$/) do |which|
  on(PolicyManagementPage).send("#{which.snakecase}_modal").populate
end

When(/^I view the first auto policy$/) do
  binding.pry
  on(PolicyManagementPage).left_nav.open_auto_summary
end

Given(/^I am on the CMI employees page for a new auto policy$/) do
  RouteHelper.login_if_needed
  begin
    navigate_all(using: :auto_to_cmi, visit: true)
  rescue Exception => ex
    # rubocop:disable Lint/Debugger
    binding.pry if Nenv.cuke_debug?
    # rubocop:enable Lint/Debugger
    puts ex.message
    raise ex
  end
end

When(/^I change the address to be invalid$/) do
  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :top
    page.general_info_panel.modify
    modal = page.auto_general_info_modal
    modal.correct_address
    modal.policy_mailing_address.address_line_1 = '12345 random road'
    modal.policy_mailing_address.zip_code = '12345'
    modal.save_and_close
    modal.use_entered_address
    modal.save_and_close
  end
end

When(/^I verify account change warning message for "([^"]*)"$/) do |which|
  on(AccountSummaryPage) do |page|
    page.basic_search_section.search_text = 'hupe'
    page.wait_for_processing_overlay_to_close
    page.search_result_suggested_element.click
    on(PolicyManagementPage) do |page|
      expect(page.leave_page_confirmation_modal.present?).to be_truthy
      case which.downcase
      when 'note'
        expect(page.leave_page_confirmation_modal.dialog_message).to eq("You haven't logged your note yet. If you leave now, your changes will be lost.")
      when 'email'
        expect(page.leave_page_confirmation_modal.dialog_message).to eq("You haven't logged your email yet. If you leave now, your changes will be lost.")
      when 'call'
        expect(page.leave_page_confirmation_modal.dialog_message).to eq("You haven't logged your call yet. If you leave now, your changes will be lost.")
      when 'meeting'
        expect(page.leave_page_confirmation_modal.dialog_message).to eq("You haven't logged your meeting yet. If you leave now, your changes will be lost.")
      else
        expect(page.leave_page_confirmation_modal.dialog_message).to eq("You haven't saved your activity yet. If you leave now, your changes will be lost.")
      end
      page.leave_page_confirmation_modal.reject_button
      on(AutoPolicySummaryPage).log_activity_modal.close if on(AutoPolicySummaryPage).log_activity_modal.present?
    end
  end
end


Given(/^I add an additional (.*) "([^"]*)" product till "([^"]*)" using the fixture file "([^"]*)"$/) do |state, product, modal, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)

  effective_date = ENV['effective_date']
  effective_date = Chronic.parse('today') if effective_date.nil? || effective_date.length <= 0
  DataMagic.yml['add_product_modal']['policy_effective_date'] = effective_date
  DataMagic.yml['auto_general_info_modal']['effective_date'] = effective_date

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
    page.wait_for_ajax
    if page.underlying_limit_confirmation_modal?
      page.underlying_limit_confirmation_modal.accept_button
    end
    page.add_product_modal.state_element.scroll.to
    page.add_product_modal.state = state
    page.add_product_modal.policy_effective_date = effective_date
    page.add_product_modal.save_and_begin_quote
    page.wait_for_processing_overlay_to_close
    if product == "residential"
      product = 'home'
    end
    page.populate_auto_policy_modals(:"#{modal}", :close_when_done, product)
  end
end

And(/^I save and continue till "([^"]*)" modal$/) do |last_modal|
  on(AutoPolicySummaryPage) do |page|
    page.populate_auto_policy_modals(last_modal.snakecase.to_sym, :close_when_done, type = 'watercraft')
  end
  page = on(PolicyManagementPage)
  page.premium_modal.go_to_auto_summary if page.premium_modal?
end

When(/^I save and continue "([^"]*)" product till "([^"]*)" modal using the (.*) fixture$/) do |product, last_modal, fixture_file|
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  RouteHelper.combined_umbrella_policy(last_modal, product)
end

When(/^I add an additional (.*) "([^"]*)" product up to "([^"]*)" using the fixture file "([^"]*)"$/) do |state, product, modal, fixture_file|
  # Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)

  on(PolicyManagementPage) do |page|
    page.toggle_side_navbar
    page.left_nav.navigate_to('Account Overview')
  end

  on(AccountSummaryPage) do |page|
    page.left_nav.add_product if page.left_nav.add_product?
    if page.left_nav.actions?
      page.left_nav.actions
      page.left_nav.new_quote
    end
    page.add_product_modal.personal_products.send("#{product}=", true)
    page.add_product_modal.state = state
    page.add_product_modal.policy_effective_date = Chronic.parse('today')
    page.add_product_modal.save_and_begin_quote
    page.wait_for_processing_overlay_to_close
    page.populate_auto_policy_modals(:"#{modal}", :up_to, product)
  end
end

And(/^I navigate to account summary page through premium modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.premium_modal
    modal.go_to_auto_summary
  end
end

Given(/^I have created a new "(.*)" policy through "(.*)" modal using the (.*) fixture$/) do |type, last_modal, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  if type == 'home'
    RouteHelper.partial_home_policy("#{last_modal} modal", :close_when_done)
  else
    if type == 'auto'
      RouteHelper.partial_auto_policy("#{last_modal} modal", :close_when_done)
    else
      if type == 'watercraft'
        RouteHelper.partial_watercraft_policy("#{last_modal} modal", :close_when_done)
      else
        if type == 'umbrella'
          RouteHelper.partial_umbrella_policy("#{last_modal} modal", :close_when_done)
        end
      end
    end
  end
end

Given(/^I have created a new "(.*)" policy up to "(.*)" modal using the (.*) fixture$/) do |type, last_modal, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  if type == 'home'
    RouteHelper.partial_home_policy("#{last_modal} modal", :up_to)
  else
    if type == 'auto'
      RouteHelper.partial_auto_policy("#{last_modal} modal", :up_to)
    else
      if type == 'watercraft'
        RouteHelper.partial_watercraft_policy("#{last_modal} modal", :up_to)
      else
        if type == 'umbrella'
          RouteHelper.partial_umbrella_policy("#{last_modal} modal", :up_to)
        end
      end
    end
  end
end

Then(/^I populate (.*) modal and (save and close|save and continue) using "([^"]*)" fixture$/) do |modal, which, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @data_from_fixture = data_for("#{modal.snakecase}_modal")
  on(PolicyManagementPage) do |page|
    modal = page.send("#{modal.snakecase}_modal")
    modal.populate_with(@data_from_fixture)
    modal.send("#{which.snakecase}")
  end
end

Given(/^I add an additional (.*) "([^"]*)" product after fully issue till "([^"]*)" using the fixture file "([^"]*)"$/) do |state, product, modal, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(PolicyManagementPage) do |page|
    #page.toggle_side_navbar
    header = on(AccountSummaryPage)

    unless header.account_summary_h4 == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end

  on(AccountSummaryPage) do |page|
    page.product_list.add_product
    page.add_product_modal.personal_products.send("#{product}=", true)
    page.add_product_modal.state = state
    page.add_product_modal.policy_effective_date = Chronic.parse('today')
    page.add_product_modal.save_and_begin_quote
    page.wait_for_processing_overlay_to_close
    if product == "residential"
      product = 'home'
    end
    page.populate_auto_policy_modals(:"#{modal}", :close_when_done, product)
  end
end

Given(/^I have started a new scheduled property policy through the "([^"]*)" modal$/) do |last_modal|
  RouteHelper.partial_scheduled_property_policy("#{last_modal} modal", :close_when_done)
end

And(/^I visit policy management page$/) do
  visit(PolicyManagementPage)
end

And(/^I populate data in auto vehicle modal$/) do
  data = data_for('auto_vehicle_modal')
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_modal
    modal.populate_with(data)
  end
end

And(/^I attach "([^"]*)" product to home till "([^"]*)" using the fixture file "([^"]*)"$/) do |product, modal, fixture_file|
  RubyExcelHelper.safe_load_fixture_file(fixture_file)

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
    page.wait_for_ajax
    page.add_product_modal.attach_product = true
    page.add_product_modal.save_and_begin_quote
    page.wait_for_processing_overlay_to_close
    page.populate_auto_policy_modals(:"#{modal}", :close_when_done, product)
  end
end

When(/^I populate auto policy optional coverages with Corporate Auto coverage$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    modal.corporate_auto_coverage = true
  end
end

