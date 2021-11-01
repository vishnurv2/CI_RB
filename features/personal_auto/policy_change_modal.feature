@auto @policy_change
Feature: Policy Change

  @regression @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @TestCaseKey=PAT-T257
  Scenario: Policy Change Modal
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I select Create Policy Change for the auto product
    Then I should see the "Add Policy Change" modal on the "Policy Management" page