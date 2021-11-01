@homeowners @account_management
Feature: Homeowners - Overrides - Protection Class

  @fixture_home_policy_none_combined_none @delete_when_done @PAT-10838 @TestCaseKey=PAT-T5832 @regression
  Scenario: Homeowners - Overrides - Protection Class
    Given I have started a new home policy through the "auto policy coverages" modal
    When I navigate to "Overrides" using the left nav
    Then I validate "Protection Class" override in panel 1

  @fixture_home_policy_none_combined_none @delete_when_done @PAT-12624 @TestCaseKey=PAT-T5834 @regression
  Scenario: WT - Home/Dwelling - Overrides - Territory Premise Address
    Given I have started a new home policy through the "auto policy coverages" modal
    When I navigate to "Overrides" using the left nav
    Then I validate that info icon on territory premise address in panel 1