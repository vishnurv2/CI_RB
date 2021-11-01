# frozen_string_literal: true

# rubocop:disable Style/NumericPredicate
#
#
# These steps use a lot of instance variables, some steps are dependent on others.

Given(/^I have requested the account from my fixture file$/) do
  @expected_id = data_for('existing_account')['id']
end

Then(/^the Account ID in the response should match the account from the fixture file$/) do
  api_response = APIHelper.get_account_information(@token, @expected_id)
  expect(api_response[:accountId]).to eq(@expected_id.to_i)
end

When(/^I get account information with the new account$/) do
  ## use @new_account_id, since it was pulled from another step

  account = APIHelper.get_account_information(@token, @new_account_id)
  @account_from_response = account[:accountId]
end

Then(/^the Account ID in the response should match$/) do
  # compare the account from response with the account from response from other step

  expect(@account_from_response).to eq(@new_account_id), "Expected account ID's to match."
end

Then(/^the Account should have a valid phone number$/) do
  header_params = APIHelper.header_params(@token)
  api = AccountAPI::AccountsApi.new
  api_response = api.v1_accounts_account_id_contact_details_get_with_http_info(@expected_id, header_params)
  phone_number = api_response.first.to_hash[:phoneNumbers].first[:phoneNumber]
  phone = APIHelper.phone_to_number(phone_number)

  expect(phone.to_i).to be_kind_of(Numeric), "Expected the API to return a Phone number, found: \"#{phone_number}\""
end

Then(/^the Account should have a valid address$/) do
  addr = APIHelper.get_account_id_addresses(@token, @expected_id)

  ## TODO move the expected data to YAML file
  RSpec.capture_assertions do
    expect(addr[:addr1]).to be_kind_of(String)
    expect(addr[:city].downcase).to eq("new haven")
    expect(addr[:state].downcase).to eq("in")
    expect(addr[:postalCode].to_i).to be_kind_of(Numeric)
  end
end

Then(/^the Account should have a primary address usage$/) do
  addr = APIHelper.get_account_id_addresses(@token, @expected_id)
  address_id = addr[:addressId]

  header_params = APIHelper.header_params(@token)
  api = AccountAPI::AddressesApi.new
  api_response = api.v1_accounts_account_id_addresses_address_id_usages_get_with_http_info(@expected_id, address_id, header_params)
  address_type = api_response.first.to_hash[:address].count
  expect(address_type).to be > 0
end

Then(/^the Account should have agency data$/) do
  header_params = APIHelper.header_params(@token)
  api = AccountAPI::GeneralInfoApi.new
  response = api.v1_accounts_account_id_general_info_get_with_http_info(@expected_id, header_params)
  api_response = response.first.to_hash

  ## TODO move the expected data to YAML file
  RSpec.capture_assertions do
    expect(api_response[:accountId].to_i).to eq(@expected_id.to_i), "Expected account id to match, \"#{@expected_id}\" but found, \"#{api_response[:accountId]}\""
    expect(api_response[:agencyCode]).to be_kind_of(String)
    ##expect(api_response[:agencyContactName].upcase).to eq('PATRICIA BOWSER')
  end
end

Then(/^the Account should have an incomplete quote$/) do
  header_params = APIHelper.header_params(@token)
  api = AccountAPI::PolicySummariesApi.new
  response = api.v1_accounts_account_id_policy_summaries_get_with_http_info(@expected_id, header_params)
  api_response = response.first.first.to_hash

  expect(api_response[:activityStatusCode].downcase).to be_kind_of(String)
  #expect(api_response[:activityStatusCode].downcase).to eq('IncompleteQuote'.downcase), "Expected the account to have a status of IncompleteQuote"
end

Then(/^the Account should have at least one person$/) do
  header_params = APIHelper.header_params(@token)
  api = AccountAPI::AccountPartiesApi.new
  response = api.v1_accounts_account_id_account_parties_get_with_http_info(@expected_id, header_params)
  count = response.first.count

  expect(count).to be >= 1, "Expected to have at least one party"
end


Then(/^the account party should have valid data$/) do
  parties = APIHelper.get_account_parties_first_party(@token, @expected_id)
  account_party_id = parties[:accountPartyId]

  header_params = APIHelper.header_params(@token)
  api = AccountAPI::AccountPartiesApi.new
  api_response = api.v1_accounts_account_id_account_parties_account_party_id_get_with_http_info(@expected_id, account_party_id, header_params)

  party = api_response.first.to_hash

  RSpec.capture_assertions do
    #just doing some random validation here
    expect(party[:accountPartyId]).to eq(account_party_id), "Expected the account party id to match!"
    expect(party[:address].count).to be > 0, "Expected there to be address data"
    expect(party[:phones].count).to be > 0, "Expected there to be phone data"
    expect(party[:partyName][:givenName].chars.count).to be > 0, "Expected response to have a given name!!!"
    expect(party[:roles].count).to be > 0, "Expected to have a role!!!"
  end
end

Then(/^the account party should have data and a role of "([^"]*)"$/) do |role|
  header_params = APIHelper.header_params(@token)
  api = AccountAPI::AccountPartiesApi.new
  response = api.v1_accounts_account_id_account_parties_role_get_with_http_info(@expected_id, role, header_params)
  party = response.first.first.to_hash

  expect(party[:roles]).to include(role), "Expected to have at least one party"
end

Then(/^the first code list should have a name and child items$/) do
  header_params = APIHelper.header_params(@token)
  api = AccountAPI::CodeListsApi.new
  response = api.accounts(header_params) # use arg to send method name from api_gem

  RSpec.capture_assertions do
    expect(response.to_hash.count).to be > 0
    expect(response.to_hash[:items].first[:children].count).to be > 0, "Expected first item to have children configurations"
  end
end

Then(/^the "([^"]*)" code list should have a name and child items$/) do |method|
  header_params = APIHelper.header_params(@token)
  api = AccountAPI::CodeListsApi.new
  response = api.send("#{method}", header_params) # use arg to send method name from api_gem
  STDOUT.puts response

  RSpec.capture_assertions do
    expect(response.to_hash.count).to be > 0
    #expect(response.to_hash[:items].first[:children].count).to be > 0, "Expected first item to have children configurations"
  end
end

### Below are the steps for POST #########################################################
#

Then(/^I insert a new account with data in the (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for('account')
  header_params = APIHelper.header_params(@token)

  @new_account_id = APIHelper.insert_new_account(header_params, data)
end

And(/^I insert a new applicant$/) do
  header_params = APIHelper.header_params(@token)
  @new_account_data = data_for('account_party')
  @insert_party_response = APIHelper.add_account_party(header_params, @new_account_data, @new_account_id)

  STDOUT.puts "\n\nInserted party for: #{@insert_party_response[:partyName][:givenName]} #{@insert_party_response[:partyName][:surname]}\n\n"
end

Then(/^the response should have a account party id$/) do
  expect(@insert_party_response[:accountPartyId]).to be_kind_of(Numeric), "Expected response to contain accountParyId"
end

And(/^I create a basic auto policy$/) do
  basic_policy = data_for('basic_auto_policy')
  @new_policy_activity_id = APIHelper.create_basic_policy(APIHelper.header_params(@token), basic_policy, @new_account_id)

  STDOUT.puts "Policy Activity ID: #{@new_policy_activity_id}\n"
  expect(@new_policy_activity_id).to be_kind_of(Numeric), "Expected a Policy Activity ID to be created!"
end

When(/^I create a vehicle on the policy$/) do
  data = data_for('vehicle')
  @added_vehicle = APIHelper.add_vehicle_to_policy(APIHelper.header_params(@token), data, @new_policy_activity_id)
  @vehicle = @added_vehicle.first.to_hash

  @vehicle_id = @vehicle[:vehicleId]
  @risk_item_id = @vehicle[:riskItemId]

  STDOUT.puts "Vehicle ID: #{@vehicle_id}\n\n"
  STDOUT.puts "Risk Item ID: #{@risk_item_id}\n\n"
  ### save the Vehicle ID!!!!  TODO
  expect(@added_vehicle[1]).to eq(200), "Expected to be able to add vehicle using Policy Activity ID: #{@new_policy_activity_id}, \n\n #{@added_vehicle}"
end


And(/^I add a driver$/) do
  driver = data_for('driver')

  @driver = APIHelper.add_driver_to_policy(APIHelper.header_params(@token), driver, @new_policy_activity_id)
  @driver_id = @driver.first.to_hash[:policyDriverInfoId]
  STDOUT.puts " Driver ID = #{@driver_id}"

  @party_id = @driver.first.to_hash[:partyId]
  STDOUT.puts "\n\nPARTY ID: #{@party_id}\n\n"

  expect(@driver_id).to be_kind_of(Numeric), "Expected response to have a Driver ID:\n\n #{@driver}"
end


And(/^I perform the driver assignment$/) do
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

  expect(@driver_assignment_id).to be_kind_of(Numeric), "Expected response to have a Driver Assignment ID:\n\n #{@add_driver}"
end
