@auto @coverage_validation @indiana_auto @personal_auto
Feature: Snowmobiles can have optional coverages

  @fixture_auto_policy_snowmobile @delete_when_done @indiana_auto @personal_auto @TestCaseKey=PAT-T274 @regression
  Scenario: Snowmobiles Coverages Exist
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I add the specified other vehicle
    Then the other vehicle trailer I added should be present in the other vehicle grid
    When I open the other vehicle I just added's optional coverages
    Then I should see the following auto vehicle coverages available
      | coverage                                        |
      | Collision                                       |
      | Liability                                       |
      | Manual Coverage                                 |
      | Medical Payments                                |
      | Other Than Collision                            |
      | Sound Receiving Transmitting Equipment          |
    And I should see the following deductible options for the auto vehicle coverages
      | coverage             | deductible |
      | Collision            | $200       |
      | Collision            | $500       |
      | Collision            | $1,000     |
      | Collision            | $2,500     |
      | Other Than Collision | $200       |
      | Other Than Collision | $500       |
      | Other Than Collision | $1,000     |

  @fixture_auto_policy_all_terrain_vehicle_manual_coverage @delete_when_done @TestCaseKey=PAT-T273
  Scenario: Manual Snowmobile Coverages Can Be Added and Deleted
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I add the specified other vehicle
    When I add a manual other vehicle coverage
    Then I should see the manual other vehicle coverage I added
    When I delete the manual other vehicle coverage I added
    Then I should not see the manual other vehicle coverage I added
