@auto @policy_change
Feature: Non pay cancellation

  @regression @fixture_auto_policy_none_combined_none_full_vin @TestCaseKey=PAT-T5352 @PAT-4082
  Scenario: Non pay cancellation
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reason as "Non-Payment of Premium"
    When I close the cancellation modal
    Then the policy should show "NON-PAY CANCEL"