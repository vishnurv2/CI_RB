@no_browser
Feature: Authorization Server API Test

  @fixture_authorization_server_api @auth_api
  Scenario: AuthorizationServer - Test Authorization Server API
    Given I request a token using the credentials from the fixture file
    Then the response should be 200
    And I should have a valid token

  @fixture_authorization_server_api_bad_creds @auth_api
  Scenario: AuthorizationServer - Test Authorization Server API with bad credentials
    Given I request a token using the credentials from the fixture file
    Then I get an Unauthorized response
