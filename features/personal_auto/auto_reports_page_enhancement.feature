@auto @reports_validation
Feature: Order Reports opens modal instead of routing user to Reports page

  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @PAT-11819 @TestCaseKey=PAT-T5802 @regression
  Scenario: Issues to Resolve - Order Reports opens modal instead of routing user to Reports page
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I click on reports issues from Issue to resolve panel
    And I verify view and order reports modal should appear