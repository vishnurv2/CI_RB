@auto @vehicle
Feature: WT - Vehicle Screen-Confirm dialog needed when your vehicle has changed message applies

  @fixture_auto_policy_autoplus_combined_none_clue_prefill @delete_when_done @TestCaseKey=PAT-T5382 @regression @PAT-11664
  Scenario: WT - Vehicle Screen-Confirm dialog needed when your vehicle has changed message applies
    Given I have started a new auto policy up to the "auto prefill" modal
    Then I save and continue on the auto prefill modal
    And I validate message on changing vehicle on auto vehicle modal
