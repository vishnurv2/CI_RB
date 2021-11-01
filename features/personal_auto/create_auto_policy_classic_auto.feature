@auto @vehicle
Feature: Classic vehicles

  @regression @delete_when_done @TestCaseKey=PAT-T174
  Scenario: Create an auto policy with an classic or classic limited  car
    Given I have created a new "Auto" policy using the auto_policy_none_combined_none_classic fixture
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And the coverages I entered display in the auto coverages panel

  @regression @delete_when_done @TestCaseKey=PAT-T171
  Scenario: Create an auto policy with a classic limited  car
    Given I have created a new "Auto" policy using the auto_policy_none_combined_none_classic_limited fixture
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And the coverages I entered display in the auto coverages panel

  @regression @TestCaseKey=PAT-T173
  Scenario: Classic cars do not show cost new
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I start adding another new vehicle to the auto policy
    And I have loaded the fixture file named "auto_policy_none_combined_none_classic_existing"
    When I have populated the auto vehicle modal
    Then I should not see the "msrp_value" field in the auto vehicle modal

  @TestCaseKey=PAT-T172
  Scenario: Classic limited cars do not show cost new
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I start adding another new vehicle to the auto policy
    And I have loaded the fixture file named "auto_policy_none_combined_none_classic_limited_existing"
    When I have populated the auto vehicle modal
    Then I should not see the "msrp_value" field in the auto vehicle modal
    And I should not see the "miles_driven_one_way" field in the auto vehicle modal
