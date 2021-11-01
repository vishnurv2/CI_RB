@scheduled_property @account_management
Feature: WT - SPP Classes

  @fixture_ui_edits_agreed_SPP_all_vehicle @delete_when_done @scheduled_property @PAT-12261 @regression @TestCaseKey=PAT-T5527
  Scenario: Verify WT - SPP Classes - Remove Popularity Sort
    Given I have started a new scheduled property policy up to the "scheduled_property_policy_level_coverages_modal" modal
    Then I verify type popularity is removed from Sort by dropdown on SPP classes modal

  @fixture_scheduled_property_policy_issuance_agreed_value @delete_when_done @scheduled_property @PAT-12262 @regression @TestCaseKey=PAT-T5782
  Scenario: Verify WT - SPP Classes - Negative Total Amount Remaining - Red Text
    Given I have started a new scheduled property policy up to the "scheduled_property_policy_level_coverages_modal" modal
    Then I update agreed value and verify Negative amount remaining

  @fixture_ui_edits_agreed_SPP_all_vehicle @delete_when_done @scheduled_property @PAT-12263 @TestCaseKey=PAT-T5783 @regression
  Scenario: WT - SPP CLasses - Verify new label for VIN - Ground Maintenance vehicles and trailers
    Given I have started a new scheduled property policy up to the "scheduled_property_policy_level_coverages_modal" modal
    Then I verify label for VIN on summary page
    And I verify VIN label on SPP classes modal for "ground_maintenance" vehicle

  @fixture_schedule_property_motorized_vehicle_for_handicapped_persons @delete_when_done @scheduled_property @PAT-12263 @wip @TestCaseKey=PAT-T5784
  Scenario: WT - SPP CLasses - Verify new label for VIN - Motorized vehicles and trailers
    Given I have started a new scheduled property policy up to the "scheduled_property_policy_level_coverages_modal" modal
    Then I verify label for VIN on summary page
    And I verify VIN label on SPP classes modal for "motorized" vehicle