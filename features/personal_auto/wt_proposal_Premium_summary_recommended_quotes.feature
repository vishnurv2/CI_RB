@auto @new_business
Feature: WT - Proposal - Premium summary and recommended quotes.

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @PAT-11752 @regression @TestCaseKey=PAT-T5781
  Scenario: WT - Proposal - Recommended quote premium summary - Auto, Home, Umbrella
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance"
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I begin issuance
    And I create proposal with customized and recommended quotes and validate premium summary


