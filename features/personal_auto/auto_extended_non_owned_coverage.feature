@auto @coverage_validation
Feature: Auto Extended Non-Owned Coverage

  @fixture_auto_policy_autoplus_combined_tier @PAT-9750 @TestCaseKey=PAT-T5313 @regression
  Scenario: Extended Non-Owned Coverage - previous effective date
    Given I have created a new "Auto" policy
    And I add and provide details for auto extended non owned coverage
    Then the policy should have the coverage "Extended Non-Owned Coverage"

  @fixture_extended_non_owned_coverage @PAT-9750 @TestCaseKey=PAT-T5314 @regression
  Scenario: Extended Non-Owned Coverage - recent effective date
    Given I have created a new "Auto" policy
    When I add the policy level optional coverage "Extended Non-Owned Coverage"
    Then the policy should have the coverage "Extended Non-Owned Coverage"