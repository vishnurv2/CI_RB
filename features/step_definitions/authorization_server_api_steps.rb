# frozen_string_literal: true

Given(/^I request a token using the credentials from the fixture file$/) do
  @creds = data_for('api')
  @api = APIHelper.get_auth_token(@creds)
end

Given(/^I have requested a token using the credentials from the (.*) file$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @creds = data_for('api')
  @token = APIHelper.get_auth_token(@creds)
end

Then(/^the response should be (.*)$/) do |resp_code|
  expect(@api[:response_code]).to eq(resp_code.to_i), "Expected a 200 OK response code, but got: \"#{@api[:response_code]}\""
end

And(/^I should have a valid token$/) do
  expect(@api[:token]).to be_kind_of(String), "Expected to get a valid token, but did not, \n #{@api[:token]}"
end

Then(/^I get an Unauthorized response$/) do
  expect(@api[:response_code]).not_to eq(200), "Did not expect the response code to be 200, got: \"#{@api[:response_code]}\""
end

Then(/^I print my token to the screen$/) do
  STDOUT.puts "Token: \n\n #{@api[:token]}\n\n"
end
