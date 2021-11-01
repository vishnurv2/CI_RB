@auto @account_management
Feature: Customer loyalty overrides

  @fixture_auto_policy_autoplus_combined_none @delete_when_done @TestCaseKey=PAT-T185
  Scenario: Customer loyalty are available
    Given I am on the CMI employees page for a new auto policy
    Then I should see a "Customer Loyalty" in override panel 1
    When I apply the "Customer Loyalty" override in panel 1
    Then the "Customer Loyalty" override in panel 1 should show as applied

  @regression @fixture_auto_policy_autoplus_combined_none @delete_when_done @TestCaseKey=PAT-T184
  Scenario: Customer loyalty modal has correct options
    Given I am on the CMI employees page for a new auto policy
    Then I should see the following values in the customer loyalty dropdown
      | value                 |
      | Less than 2 years     |
      | 2 years               |
      | 3 years               |
      | 4 years               |
      | 5 years               |
      | 6 years               |
      | 7 years               |
      | 8 years               |
      | 9 years               |
      | 10+ years             |


