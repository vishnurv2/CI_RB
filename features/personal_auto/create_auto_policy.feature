Feature: Auto policies can be created

  @fixture_auto_policy_none_combined_none @delete_when_done @TestCaseKey=PAT-T164 @auto @driver
  Scenario:  New Auto Policy
    Given I have created a new "auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel

  @fixture_auto_policy_autoplus_combined_none_old_driver @delete_when_done @regression @TestCaseKey=PAT-T159 @auto @driver
  Scenario:  New Auto Policy Old Driver
    Given I have created a new "auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel

  @fixture_auto_policy_none_combined_none_young_driver @delete_when_done @regression @TestCaseKey=PAT-T162 @auto @driver
  Scenario:  New Auto Policy Young Driver
    Given I have created a new "auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel

  @fixture_auto_policy_none_split_none @delete_when_done @regression @TestCaseKey=PAT-T161 @auto @driver
  Scenario:  New Auto Policy Split Limits
    Given I have created a new "auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel

  @fixture_auto_policy_none_split_uninsured @delete_when_done @regression @TestCaseKey=PAT-T163 @auto @driver
  Scenario:  New Auto Policy Split Limits Uninsured
    Given I have created a new "auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel

  @fixture_auto_policy_none_combined_uninsured @delete_when_done @regression @TestCaseKey=PAT-T160 @auto @driver
  Scenario:  New Auto Policy Uninsured
    Given I have created a new "auto" policy
    Then I should be on the auto summary
    And the vehicle I added should be present in the vehicle grid
    And The driver should display in the driver grid on the auto summary page
    And the coverages I entered display in the auto coverages panel

  @delete_when_done @TestCaseKey=PAT-T3687 @auto
  Scenario:  New Auto Policy via API
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
