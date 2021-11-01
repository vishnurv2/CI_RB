@auto @new_business @transfer_policy @indiana_auto @personal_auto @delete_when_done
Feature: Agent of Record Change and Policy Transfers

#  needs to be updated once story card https://central-insurance.atlassian.net/browse/PAT-13107 is done
  @regression @fixture_auto_policy_none_combined_none_full_vin @known_issue @TestCaseKey=PAT-T3303 @delete_when_done
  Scenario: Policy Cancellation Remove Cancellation
  Given I have created a new "Auto" policy
  And I fully issue the policy
  When I change the agent of record on Account Summary
  Then I transfer the policies
  And the policy should have transfered to the new account

  @regression @fixture_auto_policy_none_combined_none_full_vin @PAT-198 @TestCaseKey=PAT-T5853 @delete_when_done
  Scenario: Policy transfer to another account
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I save account and name of the policy created
    Then I log out
    And I have created a new "Auto" policy
    Then I transfer the policy to another account
    And the policy should have transfered to the new account

