Feature: Policy Issuance

#  PAT-10874
  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @regression @known_issue @TestCaseKey=PAT-T3551 @multiple @policy_issuance
  Scenario: Policy Issuance - 2 autos and 1 home
    Given I have created a new "Auto" policy
    And I add an additional Indiana "automobile" product
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @regression @TestCaseKey=PAT-T3552 @multiple @policy_issuance
  Scenario: Policy Issuance - 2 autos and 1 watercraft
    Given I have created a new "Auto" policy
    And I add an additional Indiana "automobile" product
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_policy_for_multiple_policies"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  #bug PAT-9885 - unable to issue dwelling
  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @wip @PAT-TXXX @TestCaseKey=PAT-T3553
  Scenario: Policy Issuance - 1 auto 1 Home and 1 dwelling
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I add an additional Indiana "dwelling" product till "auto_policy_coverages_modal" using the fixture file "dwelling_policy_issuance"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  #taking 8m1.141s
  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @regression @PAT-T2116 @TestCaseKey=PAT-T3554 @multiple @policy_issuance
  Scenario: Policy Issuance - 1 auto 1 Scheduled Property
    Given I have created a new "Auto" policy
    And I add an additional Indiana "scheduled_property" product till "scheduled_property_classes_modal" using the fixture file "scheduled_property_policy_issuance"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  #bug PAT-9715
  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @wip @PAT-TXXX @TestCaseKey=PAT-T3555
  Scenario: Policy Issuance - 1 auto 1 watercraft 1 home 1 umbrella
    Given I have created a new "Auto" policy
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_policy"
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  #taking 11m36.743s
  @fixture_umbrella_policy @delete_when_done @wip @PAT-TXXX @TestCaseKey=PAT-T3556
  Scenario: Policy Issuance - 1 umbrella and 1 home
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  #taking 17m9.406s
  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @wip @PAT-TXXX @TestCaseKey=PAT-T3557
  Scenario: Policy Issuance - 3 autos and 1 home
    Given I have created a new "Auto" policy
    And I add an additional Indiana "automobile" product using the fixture file "auto_policy_summit_combined_none_full_vin"
    And I add an additional Indiana "automobile" product using the fixture file "auto_policy_sig_combined_none_full_vin"
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"


