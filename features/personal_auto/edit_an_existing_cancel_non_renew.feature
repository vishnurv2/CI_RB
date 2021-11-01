@policy_change @auto
Feature: Edit an existing cancel or non-renew

  @regression @fixture_auto_policy_none_combined_none_full_vin_cancellation_1 @PAT-4854 @TestCaseKey=PAT-T211
  Scenario: Edit an existing cancel or non-renew
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_02" file
    Then I save and close the cancel_non_renew modal
    And the policy should show "Cancel Pending"
    When I cancel a policy with reasons in the "edit_policy_cancellation_01" file
    And I save and close the cancel_non_renew modal
    Then the policy should show "Cancel Pending" with tooltip message includes "Policy is set to cancel"
#    And I should not be able to edit any details
#    And I save and close the cancel_non_renew modal




