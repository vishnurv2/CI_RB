@no_browser @wip
Feature: Clean up un-used accounts

  Background:
    Given I have requested the account from my fixture file
    And I have requested a token using the credentials from the authorization_server_api file

  Scenario: Delete accounts stored in text files
    When I have files to clean
    Then I remove the accounts from the system