@auto @account_management
Feature: WT - Update Send To field of note logging to a dropdown and integrate options with WB

  @fixture_auto_policy_applicants_details_abc_email @TestCaseKey=PAT-T5823 @PAT-12684 @regression
  Scenario: WT - Update Send To field of note logging to a dropdown and integrate options with WB
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I log activity for "notes"
    Then I should see the following options for send to
      | options      |
      | Services     |
      | Underwriting |