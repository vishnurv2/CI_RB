@watercraft @account_management
Feature: Watercraft quote options bumping

  @fixture_watercraft_policy @delete_when_done @TestCaseKey=PAT-T1688
  Scenario: Quote options shows correct bumping values for watercraft vehicle coverages
    Given I have created a new "watercraft" policy
    When I navigate to "Quote Management" using the left nav
    Then Panel 2 should display upgrades for the premium

  @fixture_watercraft_policy @delete_when_done @regression @TestCaseKey=PAT-T1689
  Scenario: Watercraft - After editing the enhanced coverage the values get bumped
    Given I have created a new "watercraft" policy
    When I navigate to "Quote Management" using the left nav
    When I upgrade enhanced auto coverage from the quote options page to "No Enhanced Coverage"
    And I navigate to "IN - WaterCraft" using the left nav
    Then the watercraft policy will not have enhanced coverage on policy level coverages panel

  @fixture_watercraft_policy @delete_when_done @regression @TestCaseKey=PAT-T1690
  Scenario: Watercraft - Validating the quote after updating package discount
    Given I have created a new "watercraft" policy
    When I navigate to "Quote Management" using the left nav
    When I upgrade package discount from the quote options page to "Yes with Auto and Homeowners"
    Then premium should be same on both the Quote panels

