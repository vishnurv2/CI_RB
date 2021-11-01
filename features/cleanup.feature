Feature: Cleanup data

  @fixture_valid_creds @framework @wip
  Scenario: Remove extra data from existing auto policies
    Given I have logged in
    When I remove extra data from existing auto policies