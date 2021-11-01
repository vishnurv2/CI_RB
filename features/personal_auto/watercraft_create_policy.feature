@watercraft @account_management
Feature: Watercraft policies can be created

  @fixture_watercraft_policy @delete_when_done @PAT-4293 @TestCaseKey=PAT-T85
  Scenario:  Watercraft - Create new watercraft policy
    Given I have created a new "watercraft" policy
    And the account summary should have an applicant

  @fixture_watercraft_policy @delete_when_done @PAT-12271 @TestCaseKey=PAT-T5433 @regression
  Scenario: WT - Watercraft - Save and Add Another Watercraft
    Given I have started a new watercraft policy up to the "hull_and_motor_information" modal
    And I validate save and add another watercraft button on "hull and motor information" modal

  @fixture_watercraft_policy_motor_details @delete_when_done @PAT-12276 @TestCaseKey=PAT-T5526 @regression
  Scenario: WT - Watercraft - Summary - Show Motor Identification Number
    Given I have created a new "watercraft" policy
    Then I validate motor identification number

  @fixture_watercraft_policy_motor_details @delete_when_done @PAT-12275 @TestCaseKey=PAT-T5525 @regression
  Scenario: WT - Watercraft - Summary - View / Hide Motors
    Given I have created a new "watercraft" policy
    Then I verify view motors and hide motors button

  @fixture_watercraft_policy_motor_details @delete_when_done @PAT-12274 @TestCaseKey=PAT-T5408 @regression
  Scenario: WT - Watercraft - Summary - Remove Deductible Column for Motors
    Given I have created a new "watercraft" policy
    Then I validate that deductible column is not present in motor details

  @fixture_watercraft_policy @delete_when_done @PAT-12268 @regression @wip
  Scenario:  WT - Watercraft - Selected Motor Type - Disabled Field Hover-over Tooltip
    Given I have started a new watercraft policy up to the "hull_and_motor_information" modal
    Then I validate tooltip messages for motor disabled fields on "hull and motor information" modal