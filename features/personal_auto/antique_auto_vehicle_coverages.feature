@auto @vehicle @indiana_auto @personal_auto
Feature: Antique vehicles can have optional coverages

  @regression @delete_when_done @PAT-1904 @fixture_auto_policy_none_combined_none_antique_stated_value @TestCaseKey=PAT-T101
  Scenario: Antique vehicle Coverages Exist For Stated Value Vehicle
    Given I have created a new "Auto" policy
    And the vehicle I added should be present in the vehicle grid
    And I open the vehicle I just added
    Then I should see the following auto vehicle coverages available
      | coverage                               |
      | Collision                              |
      | Liability                              |
      | Manual Coverage                        |
      | Other Than Collision                   |
      | Sound Receiving Transmitting Equipment |
    And I should see the following deductible options for the auto vehicle coverages
      | coverage             | deductible |
      | Collision            | $200       |
      | Collision            | $500       |
      | Collision            | $1,000     |
      | Collision            | $2,500     |
      | Other Than Collision | $200       |
      | Other Than Collision | $500       |
      | Other Than Collision | $1,000     |

  @regression @delete_when_done @pat_1904 @fixture_auto_policy_none_combined_none_antique_stated_value @TestCaseKey=PAT-T102
  Scenario: Antique vehicle Coverages Exist For Prefilled Vehicle
    Given I have created a new "Auto" policy
    And the vehicle I added should be present in the vehicle grid
    And I open the vehicle I just added
    Then I should see the following auto vehicle coverages available
      | coverage                               |
      | Collision                              |
      | Liability                              |
      | Manual Coverage                        |
      | Other Than Collision                   |
      | Sound Receiving Transmitting Equipment |
    And I should see the following deductible options for the auto vehicle coverages
      | coverage             | deductible |
      | Collision            | $200       |
      | Collision            | $500       |
      | Collision            | $1,000     |
      | Collision            | $2,500     |
      | Other Than Collision | $200       |
      | Other Than Collision | $500       |
      | Other Than Collision | $1,000     |
  #fixture_auto_policy_autoplus_combined_none_clue_prefill_antique