When(/^I insert (\d+) new angular new account using (.*) fixture$/) do |count, fixture_file|
  @added_policies ||= []
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  count.times do |time_index|
    STDOUT.puts "Starting Account #{time_index + 1}/#{count}"
    header_params = APIHelper.header_params(@token) # build auth header
    begin
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
    @added_policies << { 'existing_account' => @new_account_id, 'existing_auto_policy' => @new_policy_activity_id }
  end
end

Then(/^I can save an angular account ID in excel starting at number (\d+)$/) do |start|
  workbook = RubyXL::Parser.parse './excel_data/existing_accounts.xlsx'
  worksheet = workbook.first
  worksheet.sheet_name = 'existing accounts'
  worksheet.add_cell(0, 1, "account_number")
  worksheet.add_cell(0, 2, "policy_number")
  i = 0
  @added_policies.each do |policy|
    lines = YAML.dump(policy).split("\n")
    a = lines[1..-1].join("\n").split("\n").first.split(":")
    account_number = a[1]
    p = lines[1..-1].join("\n").split("\n")[1].split(":")
    policy_number = p[1]
    worksheet.add_cell(i + 1, 0, "existing_account_#{i+1}")
    worksheet.add_cell(i + 1, 1, account_number)
    worksheet.add_cell(i + 1, 2, policy_number)
    i = i + 1 unless i == (start.to_i) -1
  end
  workbook.write("./excel_data/existing_accounts.xlsx")
end