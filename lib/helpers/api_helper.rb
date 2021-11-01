# frozen_string_literal: true

## This loop is critical as it sets OUR environment host to the Gem configuration @host variable!!!
[AuthorizationServer, AccountAPI, PolicyAPI, PolicyAPIv2, DocumentApi, DocumakerApi].each do |api|
  api.configure do |config|
    config.host = Nenv.api_host
  end
end

class APIHelper
  def self.get_auth_token(creds_from_fixture)
    arr = {}
    env_creds = {}
    env_creds['username'] = creds_from_fixture['username_' + Nenv.test_env]
    env_creds['password'] = creds_from_fixture['password_' + Nenv.test_env]
    creds_from_fixture = env_creds
    login = AuthorizationServer::LoginModel.new(creds_from_fixture)
    api = AuthorizationServer::TokenApi.new

    response = api.api_v1_token_post_with_http_info(login_model: login.to_hash)

    if response[1] != 200
      arr[:token] = false
      arr[:message] = response[0]
    else
      token = JSON.parse(response.first)
      arr[:token] = token['token']
    end

    arr[:response_code] = response[1]
    arr
  end

  def self.retrieve_token
    #tok = Helpers::Fixtures.load_fixture('authorization_server_api') # creds file
    tok = RubyExcelHelper.safe_load_fixture_file('authorization_server_api')
    creds = tok['api']
    token = APIHelper.get_auth_token(creds)
    token
  end

  def self.header_params(token)
    opts = { header_params: {} }
    tok = "Bearer #{token[:token]}"
    auth = { "Authorization": tok }
    opts[:header_params] = auth
    opts
  end

  def self.create_body(data)
    body = { body: {} }
    body[:body] = data
    body
  end

  def self.create_query_params(data)
    body = { query_params: {} }
    body[:query_params] = data
    body
  end

  def self.create_account_id(data)
    new_acct = []
    new_acct << ["accountId"] # Add in Account ID
    new_acct << data
    acct_h = Hash[*new_acct.flatten]
    acct_h
  end

  def self.phone_to_number(phone)
    phone.gsub!(/[^0-9A-Za-z]/, '')
  end

  ### DOCUMENTS ###
  #
  # Get all documents relating to account by account id & poly id
  #
  def self.get_documents_from_api(token, account_id, policy_act_id)
    header_params = header_params(token)
    api = DocumentApi::DocumentsApi.new

    begin
      api_response = api.v1_documents_account_id_policy_activities_policy_activity_id_get_with_http_info(account_id, policy_act_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message
      raise _empty_response(ex.message)
    end

    docs = api_response.first.to_a
    docs
  end

  #
  # Download document by account id and doc id
  #
  def self.download_document_by_id(token, account, document_id)
    header_params = header_params(token)
    api = DocumentApi::DocumentsApi.new

    begin
      api_response = api.v1_documents_account_id_document_id_actions_download_get_with_http_info(account, document_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message
      raise _empty_response(ex.message)
    end

    api_response
  end

  # Write the document to a file in Downloads folder
  def self.save_document(doc, document)
    File.open("#{document}", "wb") { |f| f.write doc.first }
  end

  # Get Documaker XML
  def self.get_document_xml(token, document_id)
    header_params = header_params(token)
    api = DocumakerApi::DocumentsApi.new

    begin
      api_response = api.get_xml_by_api_key_with_http_info(document_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message
      raise _empty_response(ex.message)
    end

    api_response
  end

  ### END DOCUMENTS ###


  def self.get_account_id_addresses(token, account_id)
    header_params = header_params(token)
    api = AccountAPI::AddressesApi.new
    begin
      api_response = api.v1_accounts_account_id_addresses_get_with_http_info(account_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message

      err_msg = "Account_ID: #{account_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n #{ex.message}"
      raise _empty_response(err_msg)
    end

    msg = "Account_ID: #{account_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n"
    raise _empty_response(msg) if api_response.empty?

    addr = api_response.first.first.to_hash
    addr
  end

  def self.get_account_parties_first_party(token, account_id)
    header_params = header_params(token)
    api = AccountAPI::AccountPartiesApi.new

    begin
      api_response = api.v1_accounts_account_id_account_parties_get_with_http_info(account_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message

      err_msg = "Account_ID: #{account_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n #{ex.message}"
      raise _empty_response(err_msg)
    end

    msg = "Account_ID: #{account_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n"
    raise _empty_response(msg) if api_response.first.empty? || api_response[1] != 200

    party = api_response.first.first.to_hash
    party
  end

  def self.get_account_information(token, account_id)
    header_params = APIHelper.header_params(token)
    api = AccountAPI::AccountsApi.new
    begin
      api_response = api.v1_accounts_account_id_get_with_http_info(account_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message

      err_msg = "Account_ID: #{account_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n #{ex.message}"
      raise _empty_response(err_msg)
    end

    msg = "Account_ID: #{account_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n"
    raise _empty_response(msg) if api_response.empty?

    info = api_response.first.to_hash
    info
  end

  def self.get_policy_activity_id(token, account_id)
    header_params = APIHelper.header_params(token)
    api = AccountAPI::PolicySummariesApi.new
    begin
      api_response = api.v1_accounts_account_id_policy_summaries_get(account_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message

      err_msg = "Account_ID: #{account_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n #{ex.message}"
      raise _empty_response(err_msg)
    end

    msg = "Account_ID: #{account_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n"
    raise _empty_response(msg) if api_response.empty?

    policy_activity = api_response.first.to_hash
    policy_activity
  end

  def self.get_vehicles_by_policy_activity_id(token, policy_activity_id)
    header_params = APIHelper.header_params(token)
    api = PolicyAPI::VehiclesApi.new
    api_response = api.get_all(policy_activity_id, header_params)
    api_response
  end

  def self.get_driver_assignment_first_driver_by_policy_activity_id(token, policy_activity_id)
    header_params = APIHelper.header_params(token)
    api = PolicyAPI::DriverAssignmentsApi.new
    begin
      api_response = api.get_all_with_http_info(policy_activity_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message

      err_msg = "Policy Activity ID: #{policy_activity_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n #{ex.message}"
      raise _empty_response(err_msg)
    end

    msg = "Policy Activity ID: #{policy_activity_id} \n #{api.api_client.config.base_path} -- #{api.class.name}\n\n"
    raise _empty_response(msg) if api_response.empty?

    first_driver = JSON.parse(api_response.first)
    #first_driver = api_response.first.first.to_hash
    first_driver['driverAssignments'].first
  end

  def self.delete_account(token, account_id)
    header_params = APIHelper.header_params(token)
    api = AccountAPI::AccountsApi.new

    api_response = api.v1_accounts_account_id_delete_with_http_info(account_id, header_params)
    api_response
  end

  def self._empty_response(msg)
    raise "\n\nReceived a bad response from API call: \n #{msg}"
  end

  ## Below is Helpers for creating accounts ###############################
  #
  # Insert New Account
  # @param - header_params e.g.  APIHelper.header_params(@token)
  # @param - data -- fixture data
  def self.insert_new_account(header_params, data)
    # Merge the header params with the body of the payload!!
    body = { body: {} }
    body[:body] = data
    header_params.merge!(body)

    api = AccountAPI::AccountsApi.new
    response = api.v1_accounts_post(header_params)
    new_account_id = response.to_hash[:accountId] # save account id for other steps

    STDOUT.puts "\n\nCreated new account: #{new_account_id}\n"
    # todo, move this out later, but I want to keep track of the accounts I create
    CleanupHelper.allow_registration = true
    CleanupHelper.register_account_for_deletion(new_account_id)

    new_account_id
  end

  #
  # Add Account Party
  # @param - header_params e.g.  APIHelper.header_params(@token)
  # @param - data -- fixture data
  # @param - account id to create new account party
  def self.add_account_party(header_params, data, new_account_id)
    body = APIHelper.create_body(data)
    header_params.merge!(body)
    api = AccountAPI::AccountPartiesApi.new
    response = api.v1_accounts_account_id_account_parties_post(new_account_id, header_params)
    insert_party_response = response.to_hash
    insert_party_response
  end

  #
  # Create Basic Policy - policy_activities/basicInfo
  # @param - header_params e.g.  APIHelper.header_params(@token)
  # @param - data -- fixture data
  # @param - account id to create new account party
  def self.create_basic_policy(header_params, data, new_account_id)
    acct_h = APIHelper.create_account_id(new_account_id)
    post_body = data.merge!(acct_h) # Add in Account ID here

    body = APIHelper.create_body(post_body)
    header_params.merge!(body)

    api = PolicyAPI::PoliciesApi.new
    response = api.add_policy_activity_basic_info_with_http_info(header_params)

    data = JSON.parse(response.first)
    new_policy_activity_id = data['basicPolicyInfo']['policyActivityId']
    new_policy_activity_id
  end

  #
  # Add vehicle to a Policy
  # @param - header_params e.g.  APIHelper.header_params(@token)
  # @param - data -- fixture data
  # @param - Policy Activity id to create new account vehicle
  def self.add_vehicle_to_policy(header_params, data, new_policy_activity_id)
    body = APIHelper.create_body(data)
    header_params.merge!(body)
    api = PolicyAPI::VehiclesApi.new
    response = api.create_with_http_info(new_policy_activity_id, header_params)
    response
  end

  #
  # Add driver to a Policy
  # @param - header_params e.g.  APIHelper.header_params(@token)
  # @param - data -- fixture data
  # @param - Policy Activity id to create new account vehicle
  def self.add_driver_to_policy(header_params, data, new_policy_activity_id)
    body = APIHelper.create_body(data)
    header_params.merge!(body)
    api = PolicyAPI::DriversApi.new
    response = api.create_with_http_info(new_policy_activity_id, header_params)
    response
  end

  #
  # Add driver assignment
  # @param - header_params e.g.  APIHelper.header_params(@token)
  # @param - data -- fixture data
  # @param - Policy Activity id to create new account vehicle
  def self.add_driver_assignment_to_policy(header_params, data, new_policy_activity_id)
    body = APIHelper.create_body(data)
    header_params.merge!(body)
    api = PolicyAPI::DriverAssignmentsApi.new
    response = api.create_with_http_info(new_policy_activity_id, header_params)
    response
  end

  def self.get_response_code(response)
    response[1]
  end

  def self.get_all_documents_from_api(token, account_id)
    header_params = header_params(token)
    api = DocumentApi::DocumentsApi.new

    begin
      api_response = api.v1_documents_accounts_account_id_get_with_http_info(account_id, header_params)
    rescue Exception => ex
      STDOUT.puts ex.message
      raise _empty_response(ex.message)
    end

    docs = api_response.first.to_a
    docs
  end

end

