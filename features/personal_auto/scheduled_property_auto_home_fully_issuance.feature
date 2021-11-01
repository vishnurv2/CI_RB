@multiple @policy_issuance @new_business
Feature: Auto, Home and Scheduled Property policy issuance

  @fixture_auto_policy_exposure_vehicle @delete_when_done @regression @TestCaseKey=PAT-T2120 @wip
  Scenario:  Policy issuance of Auto Home and Scheduled Property
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I add an additional Indiana "scheduled_property" product till "scheduled_property_classes_modal" using the fixture file "scheduled_property_policy_issuance"
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I resolve any underwriter referrals using blue streak seal or approvals
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
