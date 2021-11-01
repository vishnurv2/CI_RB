@no_browser @wip
Feature: Create a new policies

  Scenario: Generate policies and save in an excel sheet
    Given I have requested a token using the credentials from the authorization_server_api file
    When I insert 3 new angular new account using api_add_account fixture
    Then I can save an angular account ID in excel starting at number 3