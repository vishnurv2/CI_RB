@umbrella
Feature: Umbrella policies can be created

  @fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @TestCaseKey=PAT-T277
  Scenario:  Umbrella - Create new umbrella policy with no exposures
    Given I have created a new "umbrella" policy
    And the account summary should have an applicant

  @fixture_umbrella_policy @delete_when_done @regression @TestCaseKey=PAT-T276 @ci @known_issue @PAT-11455
  Scenario:  Umbrella - New Umbrella Policy can be started
    Given I have created a new "umbrella" policy
    And the account summary should have an applicant