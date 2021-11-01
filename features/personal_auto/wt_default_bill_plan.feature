@multiple @new_business
Feature: WT - Default Bill Plan to Annual

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5345 @PAT-11988 @regression
  Scenario: WT - Default Bill Plan to Annual
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    And I add an additional Indiana "scheduled_property" product till "scheduled_property_classes_modal" using the fixture file "scheduled_property_policy_issuance"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    And I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I navigate till billing modal and validate default option of bill plan