@auto @driver
Feature: Create Auto Policy as an Agent

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_agent @TestCaseKey=PAT-T3684
  Scenario: Create an auto policy Auto Plus as an agent
    Given I have created a new "Auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel

  @delete_when_done @fixture_auto_policy_summit_combined_none_agent @regression @TestCaseKey=PAT-T3685
  Scenario: Create an auto policy Summit Coverage as an agent
    Given I have created a new "Auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel

  @delete_when_done @fixture_auto_policy_signature_combined_none_agent @regression @TestCaseKey=PAT-T3686
  Scenario: Create an auto policy Signature Coverage as an agent
    Given I have created a new "Auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel