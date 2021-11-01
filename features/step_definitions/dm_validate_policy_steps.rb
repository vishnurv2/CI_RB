# frozen_string_literal: true

Then(/^I have a file to validate called "([^"]*)"$/) do |file|
  path = File.expand_path('.')
  file = "#{path}/json/#{file}"
  STDOUT.puts file
  file_found = true

  if (File.exist?(file))
    puts "FILE FOUND: #{file}"

    @account_info = File.open(file).read
    @account_hash = JSON.parse(@account_info)
  else
    file_found = false
    puts 'COULD NOT FIND FILE'
    expect(file_found).to be_truthy, "Expected to find a file named \"#{file}\", but did NOT!"
  end

end

Then(/^import the data via the API$/) do
  tok = APIHelper.retrieve_token
  header_params = APIHelper.header_params(tok)
  body = APIHelper.create_body(@account_hash)
  header_params.merge!(body)
  #post to basic info    http://styx.cmiprog.com/PolicyApiCore/v1/policy_activities
  api = PolicyAPI::PolicyActivitiesApi.new

  response = api.v1_policy_activities_post_with_http_info(header_params)


end
