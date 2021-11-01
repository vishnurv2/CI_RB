@no_browser @wip
Feature: Account API Core Tests - POST

  Background:
    Given I have requested the account from my fixture file
    And I have requested a token using the credentials from the authorization_server_api file

  @account_api
  Scenario: Accounts - Insert New Account and Insert Party
    When I insert a new account with data in the api_add_account fixture
    And I insert a new applicant
    Then the response should have a account party id
    When I get account information with the new account
    Then the Account ID in the response should match

    @account_api @wip
    Scenario: Create account and add driver & policy
      When I insert a new account with data in the api_add_account fixture
      And I insert a new applicant
      And I create a basic auto policy
      When I create a vehicle on the policy
      And I add a driver
      And I perform the driver assignment
