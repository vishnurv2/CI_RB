=begin
#Policy API

#This API manages interactions with the policy management system.

OpenAPI spec version: 1.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.9

=end

require 'uri'

module PolicyAPI
  class PoliciesApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Add basic policy activity
    # @param [Hash] opts the optional parameters
    # @option opts [BasicPolicyActivityInfo] :basic_info Policy activity with basic information
    # @return [BasicPolicyActivityInfo]
    def add_policy_activity_basic_info(opts = {})
      data, _status_code, _headers = add_policy_activity_basic_info_with_http_info(opts)
      data
    end

    # Add basic policy activity
    # @param [Hash] opts the optional parameters
    # @option opts [BasicPolicyActivityInfo] :basic_info Policy activity with basic information
    # @return [Array<(BasicPolicyActivityInfo, Fixnum, Hash)>] BasicPolicyActivityInfo data, response status code and response headers
    def add_policy_activity_basic_info_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: PoliciesApi.add_policy_activity_basic_info ...'
      end
      # resource path
      local_var_path = '/v1/policy_activities/basicInfo'

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json-patch+json', 'application/json', 'text/json', 'application/*+json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] || @api_client.object_to_http_body(opts[:'basic_info'])
      auth_names = opts[:auth_names] || ['Bearer']

      # return_type
      return_type = opts[:return_type] || 'BasicPolicyActivityInfo'

      new_options = opts.merge(
            :header_params => header_params,
            :query_params => query_params,
            :form_params => form_params,
            :body => post_body,
            :auth_names => auth_names,
            :return_type => return_type
        )

      data, status_code, headers = @api_client.call_api_special(:POST, local_var_path, new_options)

      # data, status_code, headers = @api_client.call_api(:POST, local_var_path,
      #   :header_params => header_params,
      #   :query_params => query_params,
      #   :form_params => form_params,
      #   :body => post_body,
      #   :auth_names => auth_names,
      #   :return_type => return_type)
      #
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: PoliciesApi#add_policy_activity_basic_info\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Gets basic policy information using policy activity id
    # @param policy_activity_id policy activity id
    # @param [Hash] opts the optional parameters
    # @return [BasicPolicyActivityInfo]
    def get_basic_info(policy_activity_id, opts = {})
      data, _status_code, _headers = get_basic_info_with_http_info(policy_activity_id, opts)
      data
    end

    # Gets basic policy information using policy activity id
    # @param policy_activity_id policy activity id
    # @param [Hash] opts the optional parameters
    # @return [Array<(BasicPolicyActivityInfo, Fixnum, Hash)>] BasicPolicyActivityInfo data, response status code and response headers
    def get_basic_info_with_http_info(policy_activity_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: PoliciesApi.get_basic_info ...'
      end
      # verify the required parameter 'policy_activity_id' is set
      if @api_client.config.client_side_validation && policy_activity_id.nil?
        fail ArgumentError, "Missing the required parameter 'policy_activity_id' when calling PoliciesApi.get_basic_info"
      end
      # resource path
      local_var_path = '/v1/policy_activities/{policyActivityId}/basicInfo'.sub('{' + 'policyActivityId' + '}', policy_activity_id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['Bearer']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'BasicPolicyActivityInfo')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: PoliciesApi#get_basic_info\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Gets policy general info by policy number
    # @param policy_number policy number
    # @param [Hash] opts the optional parameters
    # @return [GeneralInfo]
    def get_policy_general_info_by_policy_number(policy_number, opts = {})
      data, _status_code, _headers = get_policy_general_info_by_policy_number_with_http_info(policy_number, opts)
      data
    end

    # Gets policy general info by policy number
    # @param policy_number policy number
    # @param [Hash] opts the optional parameters
    # @return [Array<(GeneralInfo, Fixnum, Hash)>] GeneralInfo data, response status code and response headers
    def get_policy_general_info_by_policy_number_with_http_info(policy_number, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: PoliciesApi.get_policy_general_info_by_policy_number ...'
      end
      # verify the required parameter 'policy_number' is set
      if @api_client.config.client_side_validation && policy_number.nil?
        fail ArgumentError, "Missing the required parameter 'policy_number' when calling PoliciesApi.get_policy_general_info_by_policy_number"
      end
      # resource path
      local_var_path = '/v1/policies/{policynumber}'.sub('{' + 'policyNumber' + '}', policy_number.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['Bearer']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'GeneralInfo')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: PoliciesApi#get_policy_general_info_by_policy_number\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Gets policy general info by policy, term and version number
    # @param policy_number Policy number
    # @param term_number Term number
    # @param version_number Version number
    # @param [Hash] opts the optional parameters
    # @return [GeneralInfo]
    def get_policy_general_info_by_policy_term_and_version_number(policy_number, term_number, version_number, opts = {})
      data, _status_code, _headers = get_policy_general_info_by_policy_term_and_version_number_with_http_info(policy_number, term_number, version_number, opts)
      data
    end

    # Gets policy general info by policy, term and version number
    # @param policy_number Policy number
    # @param term_number Term number
    # @param version_number Version number
    # @param [Hash] opts the optional parameters
    # @return [Array<(GeneralInfo, Fixnum, Hash)>] GeneralInfo data, response status code and response headers
    def get_policy_general_info_by_policy_term_and_version_number_with_http_info(policy_number, term_number, version_number, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: PoliciesApi.get_policy_general_info_by_policy_term_and_version_number ...'
      end
      # verify the required parameter 'policy_number' is set
      if @api_client.config.client_side_validation && policy_number.nil?
        fail ArgumentError, "Missing the required parameter 'policy_number' when calling PoliciesApi.get_policy_general_info_by_policy_term_and_version_number"
      end
      # verify the required parameter 'term_number' is set
      if @api_client.config.client_side_validation && term_number.nil?
        fail ArgumentError, "Missing the required parameter 'term_number' when calling PoliciesApi.get_policy_general_info_by_policy_term_and_version_number"
      end
      # verify the required parameter 'version_number' is set
      if @api_client.config.client_side_validation && version_number.nil?
        fail ArgumentError, "Missing the required parameter 'version_number' when calling PoliciesApi.get_policy_general_info_by_policy_term_and_version_number"
      end
      # resource path
      local_var_path = '/v1/policies/{policyNumber}/{termNumber}/{versionNumber}'.sub('{' + 'policyNumber' + '}', policy_number.to_s).sub('{' + 'termNumber' + '}', term_number.to_s).sub('{' + 'versionNumber' + '}', version_number.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['Bearer']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'GeneralInfo')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: PoliciesApi#get_policy_general_info_by_policy_term_and_version_number\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
