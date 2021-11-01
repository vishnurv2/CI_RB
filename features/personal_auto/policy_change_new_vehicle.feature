@auto @policy_change @vehicle
Feature: Add new vehicle after policy change

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @TestCaseKey=PAT-T5590 @regression @wip
  Scenario: Add a new vehicle after policy change
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I save premium after issuing the policy completely from "In - Auto" page
    When I select Create Policy Change for the auto product
    Then I add a policy change with "Specify Date"
    When I start adding another new vehicle to the auto policy
    And I have loaded the fixture file named "auto_vehicle_modal_data"
    And I enter a vehicle year in the auto vehicle modal by ymm
    Then the vehicle make select list should contain options
    When I enter a vehicle make in the auto vehicle modal by ymm
    Then the vehicle model select list should contain options
    When I enter a vehicle model in the auto vehicle modal by ymm
    Then the vehicle style select list should contain options
    When I enter a vehicle style in the auto vehicle modal by ymm
    Then the vehicle identification number should be populated
    #And I have loaded the fixture file named "auto_vehicle_modal_data"
    And I populate data in auto vehicle modal
    Then I save and close the "auto vehicle" modal
    And I should see the following issue messages on alerts side bar
      | Complete Identification Number is required |

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @TestCaseKey=PAT-T5590 @regression @wip
  Scenario: Edit an existing vehicle after policy change
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "auto_vehicle_modal_older_25_years" by ymm
    Then I update the vin
    And I fully issue the policy
    And I save premium after issuing the policy completely from "In - Auto" page
    When I select Create Policy Change for the auto product
    Then I add a policy change with "Specify Date"
    When I edit the first vehicle from the auto policy summary page with the file "2010_honda_accord_partial_vin_non_agreed"


