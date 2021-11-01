@auto @account_management
Feature: Named Non-Owner Coverage options label and Enhanced Coverage options

  @delete_when_done @regression @PAT-11592 @TestCaseKey=PAT-T5353
  Scenario: Named Non-Owner Coverage options label
    Given I have created a new "auto" policy up to "auto policy coverages" modal using the auto_policy_autoplus_combined_none_full_vin fixture
    And I validate and provide named non owner details
