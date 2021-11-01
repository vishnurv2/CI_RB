@auto @coverage_validation
Feature: Auto Policy Level coverages modal

  @delete_when_done @TestCaseKey=PAT-T114
  Scenario: Auto policy level coverages toggle lists have the correct options
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I modify the policy level coverages
    Then The "auto policy coverages" modal should be visible
    And I should see the following toggle options available in the auto policy coverages modal
      | value                               |
      | Signature                           |
      | Summit                              |
      | Auto Plus                           |
      | Decline Enhanced Auto Coverage      |

  @delete_when_done @TestCaseKey=PAT-T116
  Scenario: Property Damage Controls Appear and Disappear
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I modify the policy level coverages
    Then The "auto policy coverages" modal should be visible
    When I select "Split Limits" for the liability type in the auto policy coverages modal
    Then the property damage coverage checkbox should be checked
    When I select "Combined Single Limit" for the liability type in the auto policy coverages modal
    Then the property damage coverage checkbox should be checked

  @delete_when_done @TestCaseKey=PAT-T117
  Scenario: Liability lists have the correct values for split limits
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I modify the policy level coverages
    Then I select "Split Limits" for the liability type in the auto policy coverages modal
    Then I should see the following auto liability options in the auto policy coverages modal
      | bodily_injury_liability             |
      | $50,000 / $100,000                    |
      | $100,000 / $200,000                   |
      | $25,000 / $50,000                     |
      | $100,000 / $300,000                   |
      | $300,000 / $300,000                   |
      | $250,000 / $500,000                   |
      | $500,000 / $500,000                   |
    Then I should see the following auto liability options in the auto policy coverages modal
      | property_damage_liability   |
      | $25,000                     |
      | $50,000                     |
      | $100,000                    |
      | $150,000                    |
      | $200,000                    |
      | $250,000                    |
      | $500,000                    |
    Then I should see the following auto liability options in the auto policy coverages modal
      | medical_payments  |
      | $500              |
      | $1,000            |
      | $2,000            |
      | $5,000            |
      | $10,000           |
      | $25,000           |
      | $50,000           |
      | $75,000           |
      | $100,000          |

  @delete_when_done @TestCaseKey=PAT-T115
  Scenario: Liability lists have the correct values for combined single limit
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I modify the policy level coverages
    When I select "Combined Single Limit" for the liability type in the auto policy coverages modal
    Then I should see the following auto liability options in the auto policy coverages modal
      | combined_single_limit             |
      | $75,000                           |
      | $100,000                          |
      | $200,000                          |
      | $300,000                          |
      | $500,000                          |
    And I should see the following auto liability options in the auto policy coverages modal
      | medical_payments  |
      | $500              |
      | $1,000            |
      | $2,000            |
      | $5,000            |
      | $10,000           |
      | $25,000           |
      | $50,000           |
      | $75,000           |
      | $100,000          |

  @delete_when_done @TestCaseKey=PAT-T118
  Scenario: Underinsured motorists options are correct for combined single limits
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I modify the policy level coverages
    Then The "auto policy coverages" modal should be visible
    When I select Summit for the enhanced auto coverage on the auto policy coverages modal
    When I select "Combined Single Limit" for the liability type in the auto policy coverages modal
    And I select "Uninsured / Underinsured Motorist" for the "uninsured underinsured type" option in the auto policy coverages modal
    Then I should see the following auto liability options in the auto policy coverages modal
      | uninsured_underinsured_property_damage_deductible  |
      | $300            |
      | $0              |


  ############ Everything below this line is unverified #############

  ### 6/3/2020 determined this will be counted towards the completed count
  @wip @delete_when_done @TestCaseKey=PAT-T3692
  Scenario: Underinsured motorists options are correct for split limits
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I modify the policy level coverages
    Then The "auto policy coverages" modal should be visible
    When I select "Split Limits" for the liability type in the auto policy coverages modal
    And I select "Uninsured / Underinsured Motorist" for the "uninsured motorist" option in the auto policy coverages modal
    Then I should see the following auto liability options in the auto policy coverages modal
      | field                                   | value           |
      | uninsured_motorist_property_liability   | No UMPD         |
      | uninsured_motorist_property_liability   | $25,000         |
      | uninsured_motorist_property_liability   | $50,000         |
      | uninsured_motorist_property_liability   | $100,000        |
      | uninsured_motorist_property_deductible  | $300            |
      | uninsured_motorist_property_deductible  | $0              |
    And the "uninsured_underinsured_limit" should match the "bodily_injury_liability" value in the auto policy coverages modal
