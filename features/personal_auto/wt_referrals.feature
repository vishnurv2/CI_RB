@auto @new_business @referrals
Feature: WT - Referrals - Function added to Contact Underwriter button with email launched to underwriter

  @delete_when_done @fixture_agent_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5259 @PAT-11750 @regression
  Scenario: WT - Referrals- as an agent
    Given I have created a new "Auto" policy
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_policy"
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I begin issuance
    And I verify contact underwriter button and send email modal details on referrals modal
    Then I verify contact underwriter button and send email modal details on referrals page

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5258 @PAT-11750 @regression
  Scenario: WT - Referrals- as CMI user
    Given I have created a new "Auto" policy
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_policy"
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I begin issuance
    And I validate that contact underwriter button is not present

  @delete_when_done @fixture_agent_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5392 @PAT-11788 @regression
  Scenario: WT - Referrals- as an agent Add UW info to Referrals page/modal
    Given I have created a new "Auto" policy
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_policy"
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I begin issuance
    And I verify UW info details on referrals modal
    Then I verify UW info details on referrals page