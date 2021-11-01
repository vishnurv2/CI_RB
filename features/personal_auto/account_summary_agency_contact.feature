@auto @account_management
Feature: Update General Information

  @delete_when_done @TestCaseKey=PAT-T87 @known_issue
  Scenario: Modify General Information
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I navigate to "Account Overview" using the left nav
    When I click modify "General Information"
    And I select a random Agency Contact
    And I select a underwriter
    Then the Agency Contact should be present on Account Summary

  @delete_when_done @fixture_auto_policy_none_combined_uninsured @regression @TestCaseKey=PAT-T85
  Scenario: Modify General Information Uninsured
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    When I click modify "General Information"
    And I select a random Agency Contact
    And I select a underwriter
    Then the Agency Contact should be present on Account Summary
