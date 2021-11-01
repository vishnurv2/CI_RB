@auto @policy_issuance
Feature: Policy Change and Policy View - Documents - Remove Application and Binder

  @regression @fixture_auto_policy_none_combined_non_adjusted_1 @PAT-4527 @TestCaseKey=PAT-T262
  Scenario: Policy Change Policy View - Auto Application and Binder documents should not be present after issuance
    Given I have created a new "Auto" policy
    When I navigate to "Documents" using the left nav
    Then I should not see "Auto Application" document in "Retain in Agency" section
    Then I should not see "Binder" document in "Retain in Agency" section
    Then I begin issuance
    When I navigate to "Documents" using the left nav
    Then I should see "Application" document in "Retain in Agency" section
    Then I should see "Binder" document in "Retain in Agency" section
    Then I issue the policy fully
    When I navigate to "Documents" using the left nav
    Then I should not see "Binder" document in "Retain in Agency" section
    Then I should see "Policy Declarations And Forms" document in "Policy Documents" section
    Then I should see "Auto Id Cards" document in "Policy Documents" section



