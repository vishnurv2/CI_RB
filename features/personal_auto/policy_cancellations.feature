@auto @policy_change
Feature: Policy Cancellations

  @regression @fixture_auto_policy_none_combined_none_full_vin @TestCaseKey=PAT-T252 @known_issue
  Scenario: Policy Cancellation Confirmation
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"

  ## Not completed yet!!! The dates are not calculating 25 days ... might need a bug
  @regression @fixture_auto_policy_none_combined_none_full_vin @known_issue @TestCaseKey=PAT-T3565
  Scenario: Future Policy Cancellation Confirmation
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_02" file
    Then I stop
    Then Cancel effective date should be "25" days from date generated
    Then I close the cancellation modal
    And the policy should show "Cancel Pending"

  @fixture_auto_policy_none_combined_none_full_vin @4851 @TestCaseKey=PAT-T253 @regression
  Scenario: Policy Cancellation Remove Cancellation
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_03" file
    When I close the cancellation modal
    And the policy should show "Cancel Pending"
    When I click the cancel renew button
    And I remove the cancellation
    When I reinstate the cancellation
    Then the products status should be "INFORCE" or "ISSUED"
