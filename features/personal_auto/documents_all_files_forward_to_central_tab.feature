@auto @account_management
Feature: WT - Add tabs to Documents page for - All Files and Forward to Central

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5378 @PAT-12214 @regression
  Scenario: Validate documents page tabs
    Given I have created a new "Auto" policy
    And I navigate to "Documents" using the left nav
    Then I should see 2 tabs on documents page
      | All Files          |
      | Forward To Central |
