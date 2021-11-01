@wip @no_browser
Feature: Data Migration

  @data_migration @known_issue
  Scenario: Validate Migrated Policy
    Given I have a file to validate called "latest.json"
    When import the data via the API
    Then I compare the response


