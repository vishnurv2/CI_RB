@multiple
Feature: Umbrella - add to existing account - Underlying Limit Confirmation

  @fixture_home_policy_prefill_issuance @delete_when_done @regression @PAT-6448 @TestCaseKey=PAT-T2125
  Scenario: Umbrella - add to home account - Underlying Limit Confirmation
    Given I have started a new home policy through the "auto policy coverages" modal
    And I add "umbrella" policy and validate underlying limit confirmation

  @fixture_auto_policy_summit_combined_none_full_vin @delete_when_done @regression @PAT-6448 @TestCaseKey=PAT-T2125
  Scenario: Umbrella - add to Auto account - Underlying Limit Confirmation - no enhanced coverage
    Given I have created a new "Auto" policy
    And I add "umbrella" policy and validate underlying limit confirmation

  @fixture_watercraft_policy_no_enhanced @delete_when_done @regression @PAT-6448 @TestCaseKey=PAT-T2127
  Scenario: Umbrella - add to watercraft account - Underlying Limit Confirmation
    Given I have created a new "watercraft" policy
    And I add "umbrella" policy and validate underlying limit confirmation

  @fixture_auto_policy_summit_combined_none_full_vin @delete_when_done @regression @PAT-6448 @TestCaseKey=PAT-T2128
  Scenario: Policy Issuance - 1 Summit-auto and umbrella - Underlying Limit Confirmation
    Given I have created a new "Auto" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    And I fully issue the multiple policies
    Then the products status should be "INFORCE" or "ISSUED"