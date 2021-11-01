@scheduled_property
Feature: Scheduled Property options bumping

  @fixture_scheduled_property_policy_issuance @delete_when_done @regression @TestCaseKey=PAT-T3301
  Scenario: Scheduled Property - non premium change endorsement
    Given I have created a new "scheduled_property" policy
    When I navigate to "Quote Management" using the left nav
    Then Panel 2 should display upgrades for the premium and others for scheduled property

  @fixture_scheduled_property_policy_issuance @delete_when_done @regression @TestCaseKey=PAT-T3302
  Scenario: Validating the quote after updating package discount
    Given I have created a new "scheduled_property" policy
    When I navigate to "Quote Management" using the left nav
    When I upgrade package discount from the quote options page to "Yes with Auto and Homeowners"
    Then premium should be same on both the Quote panels in dwelling