# frozen_string_literal: true

class PolicyApiHelper < APIHelper

  def self.create_policy_from_json(token, json_data)
    #post to basic info    http://styx.cmiprog.com/PolicyApiCore/v2/policy_activities

    header_params = APIHelper.header_params(token)
    json = json_data.to_json
    params = {}
    params[:header_params] = header_params[:header_params]
    params[:debug_body] = json
    params[:debug_return_type] = 'Object'

    api = PolicyAPIv2::PolicyActivitiesV2Api.new
    response = api.v2_policy_activities_post_with_http_info(params)
    response
  end

  def self.create_policy_from_json_old(token, json_data)
    #post to basic info    http://styx.cmiprog.com/PolicyApiCore/v1/policy_activities

    header_params = APIHelper.header_params(token)
    json = json_data.to_json
    body = APIHelper.create_body(json)
    header_params.merge!(body)
    api = PolicyAPI::PolicyActivitiesApi.new
    response = api.v1_policy_activities_post_with_http_info(header_params)
    response
  end

  def self.issue_policy_from_json(token, json_data)
    #post to basic info    http://styx.cmiprog.com/PolicyApiCore/v2/policy_activities

    header_params = APIHelper.header_params(token)
    json = json_data.to_json
    params = {}
    params[:header_params] = header_params[:header_params]
    params[:debug_body] = json
    params[:debug_return_type] = 'Object'

    api = PolicyAPI::PolicyActivitiesApi.new
    response = api.v1_policy_activities_post_with_http_info(header_params)
    response
  end

end
