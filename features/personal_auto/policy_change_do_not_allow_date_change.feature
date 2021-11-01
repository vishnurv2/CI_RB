@auto @policy_change
Feature: Policy Change - Do not allow Effective Date Change

  @regression @fixture_auto_policy_none_combined_none_adjusted @PAT-4244 @TestCaseKey=PAT-T254
  Scenario: Policy Change - Effective date and Expected date are disabled
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then I add a policy change and specify the effective date
    When I click to open the auto general info modal
    Then I should be able to validate that the effective date and expected date is disabled
