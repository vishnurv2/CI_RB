@auto @vehicle
  Feature: Other Vehicle Grid functionality

    @fixture_auto_policy_none_combined_none_no_vehicle @delete_when_done @indiana_auto @personal_auto @TestCaseKey=PAT-T236 @post_deploy_candidate @regression
    Scenario: Create Auto Policies With Other Vehicle Types
      Given I have started a new auto policy through the "auto policy coverages" modal
      When I add a vehicle from the fixture file "motorhome"
      Then the other vehicle trailer I added should be present in the other vehicle grid
      When I add a vehicle from the fixture file "camper"
      Then the other vehicle trailer I added should be present in the other vehicle grid
      When I add a vehicle from the fixture file "golf_cart"
      Then the other vehicle trailer I added should be present in the other vehicle grid
      When I add a vehicle from the fixture file "all_terrain_vehicle"
      Then the other vehicle trailer I added should be present in the other vehicle grid
      When I add a vehicle from the fixture file "snowmobile"
      Then the other vehicle trailer I added should be present in the other vehicle grid

    @fixture_auto_policy_none_combined_none_no_vehicle @delete_when_done @indiana_auto @personal_auto @regression @TestCaseKey=PAT-T237
    Scenario: Delete Other Vehicle Types
      Given I have started a new auto policy through the "auto policy coverages" modal
      When I add a vehicle from the fixture file "motorhome"
      Then the other vehicle trailer I added should be present in the other vehicle grid
      When I try to delete the last other vehicle
      Then I should see a prompt asking me if I'm sure I want to remove the other vehicle
      When I answer no to the remove other vehicles prompt
      Then the other vehicles should remain in the list
      When I answer yes to the remove other vehicles prompt
      Then the other vehicles should be removed
