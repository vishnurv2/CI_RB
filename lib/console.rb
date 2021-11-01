# frozen_string_literal: true

require 'helpers/test_data_import_helper'
require 'auto_click'
require 'httparty_with_cookies'

class PolicyManagementClient
  include HTTParty_with_cookies
  include DataMagic
  # debug_output $stdout
  base_uri Nenv.base_url
  http_proxy 'localhost', '8888'

  LOGIN_URL ||= '/WebLogin/login.aspx?ReturnUrl=%2fPolicyManagement%2fAccount%2fEntry'
  ACCOUNT_ENTRY_URL ||= '/PolicyManagement/Account/Entry'
  ACCOUNT_ENTRY_ACTION_URL ||= '/PolicyManagement/Account/Entry/Action'
  AUTO_ACTION_URL ||= '/PolicyManagement/PersonalProducts/Auto/Action'
  EXISTING_ACCOUNT_URL ||= '/PolicyManagement/Account/Entry/ExistingAccountInfo'

  DEFAULT_HEADERS ||= { 'Origin' => 'http://pluto.cmiprog.com',
                        'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36',
                        'Accept-Encoding' => 'gzip, deflate',
                        'Accept-Language' => 'en-US,en;q=0.9' }.freeze
  JSON_HEADERS ||= { 'Content-Type' => 'application/json; charset=UTF-8',
                     'Accept' => 'application/json, text/javascript, */*; q=0.01',
                     'X-Requested-With' => 'XMLHttpRequest' }.freeze

  attr_accessor :verification_token, :forgery_token, :last_activity_id

  def post_login_page(user_data)
    id = user_data['user_id'] unless user_data['user_id'].nil?
    id = user_data['user_id_' + Nenv.test_env] unless user_data['user_id_' + Nenv.test_env].nil?
    pass = user_data['password'] unless user_data['password'].nil?
    pass = user_data['password_' + Nenv.test_env] unless user_data['password_' + Nenv.test_env].nil?
    form_data = get_login_page.merge('txtbxUserId' => id, 'txtbxPass' => pass, 'cmdLogin' => 'Secure Access')
    headers = default_header('Referer' => LOGIN_URL, 'Content-Type' => 'application/x-www-form-urlencoded')
    resp = post(LOGIN_URL, headers: headers, body: form_data, follow_redirects: false)
    raise 'Unexpected result from login' unless resp.code == 302

    _parse_html_response(get(resp.headers['location']))
  end

  def referer(url)
    "#{Nenv.base_url}#{url}"
  end

  def get_login_page
    _extract_inputs(get(LOGIN_URL))
  end

  def search_agency(name)
    JSON.load(get('/PolicyManagement/Account/Entry/SearchAgency', query: { 'searchKey' => name }).body)
  end

  def get_agency_info(rgn_cd_or_name)
    code_regex = /\((.*)\)/
    rgn_cd_or_name = code_regex.match(rgn_cd_or_name)[1] if code_regex.match?(rgn_cd_or_name)
    headers = forgery_header(JSON_HEADERS.merge('Referer' => referer('/PolicyManagement/Account/Entry')))
    resp = post('/PolicyManagement/Account/Entry/GetAgencyInformation',
                body: "{ \"agencyRegionCode\":\"#{rgn_cd_or_name}\" }", headers: headers, follow_redirects: false)
    raise('Failed to retrieve agency information') if resp.code != 200

    JSON.load(resp.body)
  end

  def add_product_blob(product)
    blob = { 'productName' => product, 'screenName' => 'AccountLogging' }
    headers = forgery_header(JSON_HEADERS.merge('Referer' => referer('/PolicyManagement/Account/Entry')))
    resp = post('/PolicyManagement/Account/Entry/AddProductBlob',
                body: blob.to_json, headers: headers, follow_redirects: false)

    raise('Failed to post product blob') if resp.code != 200

    resp
  end

  def get_add_applicant_modal
    _parse_html_response(get('/PolicyManagement/Account/Entry/Applicant'))
  end

  def post_add_applicant_modal(form_data)
    headers = req_ver_header('Referer' => ACCOUNT_ENTRY_URL, 'Content-Type' => 'application/x-www-form-urlencoded')
    post(ACCOUNT_ENTRY_ACTION_URL, headers: headers, body: form_data, follow_redirects: false)
  end

  def add_first_applicant
    data = data_for('account_entry_page')
    hidden = applicant_form
    applicant = data['applicants'].first
    form_data = AddApplicantModal.form_data(applicant, hidden['__RequestVerificationToken'])
    headers = req_ver_header('Referer' => ACCOUNT_ENTRY_URL, 'Content-Type' => 'application/x-www-form-urlencoded')
    post(ACCOUNT_ENTRY_ACTION_URL, headers: headers, body: form_data, follow_redirects: false)
  end

  def get_auto_general_info_modal(activity_id = nil)
    activity_id ||= last_activity_id
    _parse_html_response(get('/PolicyManagement/PersonalProducts/Auto/AutoGeneralInformation', query: { 'policyActivityId' => activity_id }))
  end

  def get_auto_general_info_modal_raw(activity_id = nil)
    activity_id ||= last_activity_id
    get('/PolicyManagement/PersonalProducts/Auto/AutoGeneralInformation', query: { 'policyActivityId' => activity_id })
  end

  def post_auto_general_info_modal(form_data = nil)
    headers = req_ver_header('Referer' => ACCOUNT_ENTRY_URL, 'Content-Type' => 'application/x-www-form-urlencoded')
    post(AUTO_ACTION_URL, headers: headers, body: form_data, follow_redirects: false)
  end

  def get_account_entry_page
    _parse_html_response(get('/PolicyManagement/Account/Entry'))
  end

  def reload_party_table
    get('/PolicyManagement/Account/Entry/ReloadPartyTable')
  end

  def post_account_entry_page(form_data)
    headers = req_ver_header('Referer' => ACCOUNT_ENTRY_URL, 'Content-Type' => 'application/x-www-form-urlencoded')
    resp = post(ACCOUNT_ENTRY_ACTION_URL, headers: headers, body: form_data, follow_redirects: false)
    raise 'Failed to post new policy action' unless resp.code == 200

    return :existing_account if /HandleDuplicateAccount/.match?(resp.body)

    @last_activity_id = /Id=(\d+)/.match(resp.body)[1]
  end

  def post_existing_account_modal(form_data)
    headers = req_ver_header('Referer' => ACCOUNT_ENTRY_URL, 'Content-Type' => 'application/x-www-form-urlencoded')
    resp = post(ACCOUNT_ENTRY_ACTION_URL, headers: headers, body: form_data, follow_redirects: false)
    raise 'Failed to post existing account modal' unless resp.code == 200

    @last_activity_id = /Id=(\d+)/.match(resp.body)[1]
  end

  def get_existing_account_modal
    _parse_html_response(get(EXISTING_ACCOUNT_URL))
  end

  def _extract_fields(resp)
    inputs = _extract_inputs(resp)
    # Remap the string to make pulling out selects easier
    selects = resp.gsub(/\r\n|\t/, '').gsub(/(\<\/.*?\>)/, '\1~~').scan(/(\<select.*?\<\/select\>)/).flatten
    inputs.merge!(selects.map { |s| [name_regex.match(s)[2], _selected_val(s)] }.to_h)
  end

  # Loop through an HTML response looking for inputs, extract their name and value
  def _extract_inputs(resp)
    inputs = resp.split('>').join(">\r\n").split("\r\n").select { |l| l =~ /\<input/ }

    inputs.map { |l| [name_regex.match(l)[2], _input_val(l)] }.to_h
  end

  def _selected_val(str)
    return nil unless selected_regex.match(str)

    selected_regex.match(str)[1]
  end

  def name_regex
    @name_regex ||= /(id|name)="(.*?)"/
  end

  def selected_regex
    @selected_regex ||= /selected.*?value="(.*?)"/
  end

  # Return a value from a hidden field in HTML.
  def _input_val(str)
    val_regex = /value="(.*?)"/
    val_regex2 = /value=(.*?) /
    return nil unless val_regex.match(str) || val_regex2.match(str)

    val_regex.match?(str) ? val_regex.match(str)[1] : val_regex2.match(str)[1]
  end

  def _parse_html_response(resp)
    hidden = _extract_fields(resp)
    @verification_token = hidden['__RequestVerificationToken'] if hidden.key?('__RequestVerificationToken')
    @forgery_token = hidden['forgeryToken'] if hidden.key?('forgeryToken')
    hidden
  end

  def default_header(extra = {})
    DEFAULT_HEADERS.merge(extra)
  end

  def req_ver_header(extra = {})
    heads = default_header(extra)
    heads['__RequestVerificationToken'] = @verification_token if @verification_token
    heads
  end

  def forgery_header(extra = {})
    heads = default_header(extra)
    heads['__RequestVerificationToken'] = @forgery_token if @forgery_token
    heads
  end
end

module CentralConsole
  module_function

  include DataMagic

  def show_dev_tools
    mouse_set 1869, 58
    mouse_Lclick 1
  end

  def pop_out_dev_tools
    # click the dot menu
    mouse_set 1848, 140
    sleep 0.5
    mouse_Lclick 1
    mouse_set 1785, 171
    sleep 1.5
    mouse_Lclick 1
  end

  def console_test
    Helpers::Fixtures.load_fixture('auto_policy_autoplus_combined_none')
    client = PolicyManagementClient.new
    LoginPage.post(client)
    act_id = AccountEntryPage.post(client)

    act_id = ExistingClientModal.post(client) if act_id == :existing_account

    binding.pry
    STDOUT.puts ''
  end
  module_function :console_test
end
