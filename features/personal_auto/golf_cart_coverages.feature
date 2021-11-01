@account_management @auto
Feature: Golf Cart Coverages

  @delete_when_done @fixture_auto_policy_none_combined_none_golf_cart @TestCaseKey=PAT-T3633
  Scenario: Vehicle coverages exist for golf carts
    Given I have started a new auto policy through the "auto general info" modal
    When I add a golf cart to my policy and view the coverages available
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
