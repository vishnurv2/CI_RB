@indiana_auto @personal_auto @classic_limited_auto @auto @vehicle
Feature: Classic limited vehicles can have optional coverages

  @regression @delete_when_done @pat_1904 @fixture_auto_policy_none_combined_none_classic_limited @TestCaseKey=PAT-T154
  Scenario: Classic limited vehicle Coverages Exist
    Given I have started a new auto policy up to the "auto vehicle coverages" modal
    And the vehicle I added should be present in the vehicle grid
    And I open the vehicle I just added
    Then I should see the following auto vehicle coverages available
      | coverage                                        |
      | Collision                                       |
      | Liability                                       |
      | Manual Coverage                                 |
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



