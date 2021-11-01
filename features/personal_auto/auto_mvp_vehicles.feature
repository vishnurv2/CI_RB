@auto @vehicle
Feature: Auto - MVP-Add Annual Miles and Purchase Date information to Vehicle screen

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T850 @PAT-9762 @regression
  Scenario: Auto - MVP-Add Annual Miles and Purchase Date information to Vehicle screen
    Given I have started a new auto policy up to the "auto vehicle" modal
    Then I select vehicle type as "Private Passenger"
    And I validate fields displayed for private passenger
    Then I select vehicle type as "Limited Use Auto"
    And I validate fields displayed for limited use auto
