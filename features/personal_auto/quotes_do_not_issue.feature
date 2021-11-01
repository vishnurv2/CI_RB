@auto
Feature: Quotes - Do Not Issue

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @PAT-12923 @TestCaseKey=PAT-T5836 @regression
  Scenario: Quotes - Do Not Issue
    Given I have created a new "Auto" policy
    And I click on "Do not issue" from Actions dropdown
    Then I validate that there are no reports and referrals