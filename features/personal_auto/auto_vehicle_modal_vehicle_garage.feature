@auto @vehicle @indiana_auto @personal_auto
Feature: Vehicle Garage Location

  # this test should be complete all except for the validation that is to appear on the vehicle panel, we are still waiting for that validation to be implemented AMN 3-12-20
  ### 6/3/2020 determined this will be counted towards the completed count
  @fixture_auto_policy_ohio_garage @wip @TestCaseKey=PAT-T3691
  Scenario: Garage Must Exist in Risk State Validation Appears
    Given I have started a new auto policy up to the "auto vehicle" modal
    When I populate the auto vehicle modal
    Then The garage risk state validation message should be present
