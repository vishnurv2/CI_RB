Given(/^I login to PAT application through Api$/) do
  tok = RubyExcelHelper.safe_load_fixture_file('authorization_server_api') # creds file
  @creds = tok['api']
  @token = APIHelper.get_auth_token(@creds)
  @header_params = APIHelper.header_params(@token)
end

And(/^I create a new mocking service$/) do
  require 'pact/consumer/rspec'
  Pact.service_consumer "Account" do
    has_pact_with "Account service" do
      mock_service :account_service do
        port 1234
      end
    end
  end
end

Then(/^T verify request and response$/) do
  require 'pact/consumer/rspec'
  describe AccountAPI, pact: true do

    before do
      # Configure your client to point to the stub service on localhost using the port you have specified
      AccountAPI.base_uri 'localhost:1234'
    end

    subject { AccountAPI::AccountsApi.new }

    describe "get_account" do

      before do
        account_api_service.given("an account exists").
          upon_receiving("a request for an account").
          with(method: :get, path: '/v1/accounts', query: '').
          will_respond_with(
            status: 200,
            headers: {'Content-Type' => 'application/json'},
            body: {name: 'Betty'} )
      end

      it "returns an account" do
        expect(subject.v1_accounts_post_with_http_info).to eq('Betty')
      end
    end
  end
end