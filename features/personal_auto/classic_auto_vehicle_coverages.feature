@indiana_auto @personal_auto @classic_auto @auto @vehicle
Feature: Classic vehicles can have optional coverages

  @delete_when_done @pat_1904 @fixture_auto_policy_none_combined_none_classic @TestCaseKey=PAT-T152 @post_deploy_candidate @regression
  Scenario: Classic vehicle Coverages Exist
    Given I have started a new auto policy up to the "auto vehicle coverages" modal
    And the vehicle I added should be present in the vehicle grid
    And I open the vehicle I just added
    Then I should see the following auto vehicle coverages available
      | coverage                                        |
      | Collision                                       |
      | Custom Equipment                                |
      | Electronic Equipment                            |
      | Lease / Loan Guard                              |
      | Liability                                       |
      | Manual Coverage                                 |
      | Other Than Collision                            |
      | Sound Receiving Transmitting Equipment          |
      | Towing & Labor                                  |
      | Extended Transportation                         |
      | Transportation Network Coverage                 |
      | Trip Interruption                               |
    And I should see the following deductible options for the auto vehicle coverages
      | coverage              | deductible           |
      | Collision             | $100                 |
      | Collision             | $200                 |
      | Collision             | $250                 |
      | Collision             | $500                 |
      | Collision             | $1,000               |
      | Collision             | $1,500               |
      | Collision             | $2,000               |
      | Collision             | $2,500               |
      | Collision             | $5,000               |
      | Collision             | $10,000              |
      | Other Than Collision  | $0                   |
      | Other Than Collision  | $50                  |
      | Other Than Collision  | $100                 |
      | Other Than Collision  | $200                 |
      | Other Than Collision  | $250                 |
      | Other Than Collision  | $500                 |
      | Other Than Collision  | $1,000               |
      | Other Than Collision  | $1,500               |
      | Other Than Collision  | $2,000               |
      | Other Than Collision  | $2,500               |
      | Other Than Collision  | $5,000               |
      | Other Than Collision  | $10,000              |
