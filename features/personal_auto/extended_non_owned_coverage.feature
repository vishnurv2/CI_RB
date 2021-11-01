@extended_non_owned_coverage @auto
Feature: Extended Non-Owned Coverage

  @fixture_extended_non_owned_coverage_named_non_owner @regression @PAT-6845 @TestCaseKey=PAT-T216
  Scenario: Validate Extended Non-Owned Coverage is not there for Named non-owner
    Given I have created a new "Auto" policy
    Then the policy should not have the coverage "Extended Non-Owned Coverage"

  @fixture_extended_non_owned_coverage_resident_relatives @regression @PAT-6845 @TestCaseKey=PAT-T212
  Scenario: Adding Extended Non-Owned Coverage
    Given I have created a new "Auto" policy
    When I add the policy level optional coverage "Extended Non-Owned Coverage"
#    And I provide details for auto policy optional coverages modal "Extended Non-Owned Coverage"
    Then the policy should have the coverage "Extended Non-Owned Coverage"