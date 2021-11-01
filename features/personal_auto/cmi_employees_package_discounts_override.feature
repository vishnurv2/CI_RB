@auto @account_management
Feature: Package discount overrides

  @fixture_auto_policy_autoplus_combined_none @delete_when_done @TestCaseKey=PAT-T3689
  Scenario: Package overrides are available
    Given I am on the CMI employees page for a new auto policy
    Then I should see a "Package Discount" in override panel 1
    When I apply the "Package Discount" override in panel 1
    Then the "Package Discount" override in panel 1 should show as applied

  @fixture_auto_policy_autoplus_combined_none @delete_when_done @TestCaseKey=PAT-T5868 @PAT-12617
  Scenario: WT - Remove Roger From Info Icon on Package Discount Override
    Given I am on the CMI employees page for a new auto policy
    Then I should see a "Package Discount" in override panel 1
    When I apply the "Package Discount" override in panel 1
    Then I validate info icon on overridden status in panel 1
