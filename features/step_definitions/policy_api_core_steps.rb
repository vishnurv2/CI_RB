# frozen_string_literal: true

# rubocop:disable Style/NumericPredicate
#
#
# These steps use a lot of instance variables, some steps are dependent on others.

When(/^I retrieve the Policy Activity ID based on the account from the fixture$/) do
  get_activity_id = APIHelper.get_policy_activity_id(@token, @expected_id)
  @policy_activity_id = get_activity_id[:policyActivityId]
end

Then(/^the accounts should have a driver assignment$/) do
  first_driver = APIHelper.get_driver_assignment_first_driver_by_policy_activity_id(@token, @policy_activity_id)

  RSpec.capture_assertions do
    expect(first_driver['driverAssignmentId']).to be_kind_of(Numeric)
    expect(first_driver['driverId']).to be_kind_of(Numeric)
    expect(first_driver['partyId']).to be_kind_of(Numeric)
    expect(first_driver['vehicleId']).to be_kind_of(Numeric)
  end
end

Then(/^the account should have a driver assignment$/) do
  first_driver = APIHelper.get_driver_assignment_first_driver_by_policy_activity_id(@token, @policy_activity_id)
  @driver_assignment_id = first_driver['driverAssignmentId']

  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::DriverAssignmentsApi.new
  api_response = api.get(@policy_activity_id, @driver_assignment_id, header_params)
  assingment = api_response.to_hash

  RSpec.capture_assertions do
    expect(assingment[:driverAssignmentId]).to eq(@driver_assignment_id)
    expect(assingment[:driverId]).to be_kind_of(Numeric)
    expect(assingment[:partyId]).to be_kind_of(Numeric)
    expect(assingment[:vehicleId]).to be_kind_of(Numeric)
    expect(assingment[:riskItemId]).to be_kind_of(Numeric)
    expect(assingment[:driverAge]).to be_kind_of(Numeric)
  end
end

Then(/^the account should have a driver$/) do
  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::DriversApi.new
  api_response = api.get_all(@policy_activity_id, header_params)

  msg = "Policy Act ID: #{@policy_activity_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n"
  raise APIHelper._empty_response(msg) if api_response.empty?

  drivers = api_response.first.to_hash
  RSpec.capture_assertions do
    expect(api_response.count).to be > 0, "Expected this account to have at least ONE driver"
    expect(drivers[:name]).to be_kind_of(String)
    expect(drivers[:gender]).to be_kind_of(String)
    expect(drivers[:licenseState]).to be_kind_of(String)
    #expect(drivers[:licenseStateDescription]).to be_kind_of(String)
    expect(drivers[:licenseNumber]).to be_kind_of(String)
  end
end

Then(/^the account should have basic policy information$/) do
  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::GeneralInfoApi.new
  api_response = api.get(@policy_activity_id, header_params)
  gen_info = api_response.to_hash

  RSpec.capture_assertions do
    expect(gen_info[:basicPolicyInfo][:policyActivityId]).to eq(@policy_activity_id), "Expected Policy Activity IDs to match"
    expect(gen_info[:basicPolicyInfo][:activityStatus]).to be_kind_of(String)
    expect(gen_info[:basicPolicyInfo][:policyId]).to be_kind_of(Numeric)
    expect(gen_info[:basicPolicyInfo][:accountId]).to be_kind_of(Numeric)
    #expect(gen_info[:policyMailingAddress][:addr1]).to be_kind_of(String)
  end
end

Then(/^the policy should have basic information$/) do
  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::PoliciesApi.new
  api_response = api.get_basic_info(@policy_activity_id, header_params)
  policies = api_response.to_hash

  RSpec.capture_assertions do
    expect(policies[:policyActivityId]).to eq(@policy_activity_id), "Expected Policy Activity IDs to match"
    expect(policies[:policyTermId]).to be_kind_of(Numeric)
    expect(policies[:policyTransactionId]).to be_kind_of(Numeric)
    expect(policies[:policyId]).to be_kind_of(Numeric)
    expect(policies[:riskStateCode]).to be_kind_of(String)
  end
end

Then(/^the "([^"]*)" list should heeeeave a data$/) do |method|
  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::CodeListsApi.new
  response = api.send("#{method}", @policy_activity_id, header_params) # use arg to send method name from api_gem

  RSpec.capture_assertions do
    expect(response.to_hash.count).to be > 0, "Expected items to have data!"
    expect(response.to_hash[:items].first[:children].count).to be > 0, "Expected first item to have children configurations"
  end
end

Then(/^the account should have coverages$/) do
  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::CoveragesApi.new
  api_response = api.get_all(@policy_activity_id, header_params)
  coverages = api_response.count

  expect(coverages).to be > 0, "Expected this policy to have coverages, but found none."
end

Then(/^the (.*) list should have a data$/) do |method|
  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::CodeListsApi.new
  response = api.send("#{method}", @policy_activity_id, header_params) # use arg to send method name from api_gem

  STDOUT.puts "#{response} \n\n"
  RSpec.capture_assertions do
    expect(response.to_hash.count).to be > 0, "Expected items to have data!"
    #expect(response.to_hash[:items].first[:children].count).to be > 0, "Expected first item to have children configurations"
  end
end

Then(/^the account should have a vehicle$/) do
  api_response = APIHelper.get_vehicles_by_policy_activity_id(@token, @policy_activity_id)
  vehicles = api_response.first.to_hash

  RSpec.capture_assertions do
    expect(vehicles[:vehicleId]).to be_kind_of(Numeric)
    expect(vehicles[:riskItemId]).to be_kind_of(Numeric)
    expect(vehicles[:year]).to be_kind_of(Numeric)
    expect(vehicles[:make]).to be_kind_of(String)
    expect(vehicles[:model]).to be_kind_of(String)
    expect(vehicles[:vin]).to be_kind_of(String)
  end
end

Then(/^the activity should have a vehicle$/) do
  vehicle = APIHelper.get_vehicles_by_policy_activity_id(@token, @policy_activity_id)
  @first_vehicle_id = vehicle.first.to_hash[:vehicleId]

  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::VehiclesApi.new
  api_response = api.get(@policy_activity_id, @first_vehicle_id, header_params)
  vehicle = api_response.to_hash

  RSpec.capture_assertions do
    expect(vehicle[:vehicleId]).to be_kind_of(Numeric)
    expect(vehicle[:year]).to be_kind_of(Numeric)
    expect(vehicle[:policyAddressId]).to be_kind_of(Numeric)
    expect(vehicle[:make]).to be_kind_of(String)
    expect(vehicle[:model]).to be_kind_of(String)
    expect(vehicle[:vin]).to be_kind_of(String)
    expect(vehicle[:garagingAddress][:addr1]).to be_kind_of(String), "Expected to find a garaging address!"
  end

end

Then(/^the response for "([^"]*)" should return a credit score of NOHIT$/) do |type|
  header_params = APIHelper.header_params(@token)
  api = PolicyAPI::ReportsApi.new
  response = api.send("#{type}", @policy_activity_id, header_params)

  expect(response.first.to_hash[:cmiCreditScore]).to eq("NOHIT"), "Expected our bogus applicant to have a NOTHIT credit score!"
end

Then(/^the policy activity id should have forms available$/) do
  # todo
end
