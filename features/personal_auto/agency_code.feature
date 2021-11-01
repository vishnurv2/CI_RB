@account_management
Feature: Agents Access - CMI User clicks PL Quote - needs to be asked for agency code before proceeding

  @fixture_valid_creds @TestCaseKey=PAT-T5902 @PAT-11811 @regression
  Scenario: Agents Access - CMI User clicks PL Quote - needs to be asked for agency code before proceeding
    Given I start to log in
    When I try to log in with valid credentials
    And I provide agent code and continue
    Then I validate that it navigates to new interface application