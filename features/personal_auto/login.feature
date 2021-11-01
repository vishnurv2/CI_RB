@auto @account_management
Feature: The system requires a valid user name and password to log in

  #multiple execution locks the account
  @fixture_bad_creds_no_user @auth_api @TestCaseKey=PAT-T22 @known_issue
  Scenario: Try to log in without a user name
    Given I start to log in
    When I try to log in without a username
    Then I should see "User ID is required" in the "User Name" error section of the login form

    #multiple execution locks the account
  @fixture_bad_creds_no_password @auth_api @TestCaseKey=PAT-T228 @known_issue
  Scenario: Try to log in without a password
    Given I start to log in
    When I try to log in without a password
    Then I should see "Password is required" in the "Password" error section of the login form

  @fixture_valid_creds @auth_api  @TestCaseKey=PAT-T231
  Scenario: Log in with valid credentials
    Given I start to log in
    When I try to log in with valid credentials
    And I visit policy management page
    Then I should be on the policy management page
    Then I should be on the dashboard summary

#multiple execution locks the account
  @fixture_bad_creds_wrong_password @auth_api @TestCaseKey=PAT-T230 @known_issue
  Scenario: Try to log in with the wrong password
    Given I log in with a bad password using the "bad_creds_wrong_password"
    Then I should see failure message in the toast alert
