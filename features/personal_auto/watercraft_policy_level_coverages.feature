@watercraft @account_management
Feature: WT - Watercraft - Default Personal Liability and Medical Payment Coverages

  @fixture_watercraft_policy @delete_when_done @PAT-12267 @TestCaseKey=PAT-T5416 @regression
  Scenario: WT - Watercraft - Default Personal Liability and Medical Payment Coverages
    Given I have started a new watercraft policy up to the "auto_policy_coverages" modal
    And I validate coverages on auto policy coverages modal

