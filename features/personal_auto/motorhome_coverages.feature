@auto @vehicle
Feature: Motorhomes can have optional coverages

  @fixture_auto_policy_motorhome @delete_when_done @indiana_auto @personal_auto @regression @TestCaseKey=PAT-T235
  Scenario: Motorhome Coverages Exist
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I add the specified other vehicle
    Then the other vehicle trailer I added should be present in the other vehicle grid
    When I open the other vehicle I just added's optional coverages
    Then I should see the following auto vehicle coverages available
      | coverage                                        |
      | Collision                                       |
      | Electronic Equipment                            |
      | Lease / Loan Guard                              |
      | Liability                                       |
      | Manual Coverage                                 |
      | Other Than Collision                            |
      | Sound Receiving Transmitting Equipment          |
      | Towing & Labor                                  |
      | Trip Interruption                               |
    And I should see the following deductible options for the auto vehicle coverages
      | coverage             | deductible |
      | Collision            | $100       |
      | Collision            | $200       |
      | Collision            | $250       |
      | Collision            | $500       |
      | Collision            | $1,000     |
      | Collision            | $1,500     |
      | Collision            | $2,000     |
      | Collision            | $2,500     |
      | Collision            | $5,000     |
      | Collision            | $10,000    |
      | Other Than Collision | $0         |
      | Other Than Collision | $50        |
      | Other Than Collision | $100       |
      | Other Than Collision | $200       |
      | Other Than Collision | $250       |
      | Other Than Collision | $500       |
      | Other Than Collision | $1,000     |
      | Other Than Collision | $1,500     |
      | Other Than Collision | $2,000     |
      | Other Than Collision | $2,500     |
      | Other Than Collision | $5,000     |
      | Other Than Collision | $10,000    |

  @regression @fixture_auto_policy_motorhome_manual_coverage @delete_when_done @TestCaseKey=PAT-T234
  Scenario: Manual Motorhome Coverages Can Be Added and Deleted
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I add the specified other vehicle
    When I add a manual other vehicle coverage
    Then I should see the manual other vehicle coverage I added
    When I delete the manual other vehicle coverage I added
    Then I should not see the manual other vehicle coverage I added
