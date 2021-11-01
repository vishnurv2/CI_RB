@account_management
Feature: WT - Homeowner & Dwelling - Property Prefill

  @fixture_home_policy_none_combined_none_loss_settlement @delete_when_done @TestCaseKey=PAT-T5297 @PAT-11656 @regression @homeowners
  Scenario: WT - Homeowner - Property Prefill
    Given I have created a new "home" policy
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel

  @fixture_dwelling_policy_issuance @delete_when_done @TestCaseKey=PAT-T5298 @PAT-11656 @regression @dwelling
  Scenario:  WT - Dwelling - Property Prefill
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel