@auto @vehicle
Feature: Antique vehicles

  @regression @TestCaseKey=PAT-T166
  Scenario Outline: Create an auto policy with an antique car stated value
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                                         |
      | auto_policy_none_combined_none_antique_stated_value  |

  @regression @TestCaseKey=PAT-T165
  Scenario Outline: Create an auto policy with an antique
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                                         |
      | auto_policy_none_combined_none_antique               |
