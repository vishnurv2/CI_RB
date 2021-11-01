@auto @vehicle @indiana_auto @personal_auto
Feature: Auto-Vehicle modal Validations and additions

  @fixture_auto_policy_none_combined_none @TestCaseKey=PAT-T144
  Scenario: Required fields generate errors VIN mode
    Given I have created a new "auto" policy
    When I start adding another new vehicle to the auto policy
    And I choose Vehicle Identification Number for the identification type
    When I try to submit the auto vehicle modal without filling it out
    Then I should see the following errors on the auto vehicle modal:
      | Identification Number is required. |
      | Purchase Date is required.           |
      | Vehicle Use is required.          |
      | Annual Miles is required.         |
      | Performance is required.          |

  @fixture_auto_policy_none_combined_none @TestCaseKey=PAT-T141
  Scenario: Required fields generate errors YMM mode
    Given I have created a new "auto" policy
    When I start adding another new vehicle to the auto policy
    And I choose Year/Make/Model for the identification type
    When I try to submit the auto vehicle modal without filling it out
    Then I should see the following errors on the auto vehicle modal:
      | Year is required.                |
      | Make is required.                |
      | Model is required.               |
      | Style is required.               |
      | Purchase Date is required.           |
      | Vehicle Use is required.         |
      | Annual Miles is required.         |
      | Performance is required.         |

  @TestCaseKey=PAT-T143
  Scenario: Added vehicle shows up in the vehicle grid
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I start adding another new vehicle to the auto policy
    When I populate the auto vehicle modal with the data in the a_3_1_c_3 fixture
    Then the vehicle I added should be present in the vehicle grid
    And I delete the vehicles in the grid

  @TestCaseKey=PAT-T142
  Scenario: Edited vehicle shows up in the vehicle grid
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I start adding another new vehicle to the auto policy
    When I populate the auto vehicle modal with the data in the a_4_4 fixture
    And I edit the vehicle I just added
    Then the edited vehicle should be present in the vehicle grid
    And I delete the vehicles in the grid