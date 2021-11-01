@auto @account_management
Feature: WT - Proposal - closing

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5275 @PAT-11713 @regression
  Scenario: WT - Proposal - closing
    Given I have created a new "Auto" policy
    And I navigate to my quote "Quote Management" using the left nav
    Then I add and upload "sample_pdf_1" and validate proposal
