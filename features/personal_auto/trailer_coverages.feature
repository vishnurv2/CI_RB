@auto @vehicle
Feature: Trailers on auto policies

  @fixture_auto_policy_none_split_none @regression @TestCaseKey=PAT-T275 @delete_when_done
  Scenario: Trailers can be added to auto policies with coverages
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add a vehicle from the fixture file "camper"
    Then the other vehicle trailer I added should be present in the other vehicle grid
    When I open the other vehicle I just added's optional coverages
    Then I should see the following auto vehicle coverages available
      | coverage                                        |
      | Collision                                       |
      | Lease / Loan Guard                              |
      | Liability                                       |
      | Manual Coverage                                 |
      | Other Than Collision                            |
      | Sound Receiving Transmitting Equipment          |
      | Trip Interruption                               |
    And I should see the following deductible options for the auto vehicle coverages
      | coverage             | deductible |
      | Collision            | $200       |
      | Collision            | $500       |
      | Collision            | $1,000     |
      | Collision            | $2,500     |
      | Other Than Collision | $200       |
      | Other Than Collision | $500       |
      | Other Than Collision | $1,000     |
