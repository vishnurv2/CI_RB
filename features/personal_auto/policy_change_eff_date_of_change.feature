@auto @policy_change
Feature: WT - Open Policy Changes - Effective Date of Change

  @regression @fixture_auto_policy_none_combined_none_adjusted @PAT-11986 @TestCaseKey=PAT-T5833
  Scenario: WT - Open Policy Changes - Effective Date of Change
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then I add a policy change and specify the effective date
    And I navigate to "Open Policy Changes" using the left nav
    Then I validate effective date of change
