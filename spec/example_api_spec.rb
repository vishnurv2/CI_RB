require 'pry'

RSpec.describe AccountAPI do

  it 'retrieves account details given an id' do
    Helpers::Fixtures.load_fixture 'existing_account_1'
    api = AccountAPI::GETApi.new
    expected_id = data_for('existing_account')['id']
    result = api.accounts_get_account(expected_id)
    expect(result[:AccountId]).to eq(expected_id.to_i)
  end

  it 'raises a not found error if the account does not exist' do
    api = AccountAPI::GETApi.new
    expect { api.accounts_get_account(11) }.to raise_error(AccountAPI::ApiError, 'Not Found')
  end

  it 'raises a bad request error if you use zero for the account ID' do
    api = AccountAPI::GETApi.new
    expect { api.accounts_get_account(0) }.to raise_error(AccountAPI::ApiError, 'Bad Request')
  end

end
