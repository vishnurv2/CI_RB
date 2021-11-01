@auto @policy_change
Feature: Out of Sequence

#  bug  PAT-10341
    @regression @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T238 @known_issue
    Scenario: Fully Issuing a Policy Refactored
      Given I have created a new "Auto" policy
      And I fully issue the policy
      Then the product status should be "Issued"
      And I add out of sequence policy changes
      Then I should see out of sequence policy changes