@multiple @new_business
Feature: Home and auto policy issuance

#  bug https://central-insurance.atlassian.net/browse/PAT-11081
  @fixture_auto_policy_exposure_vehicle @delete_when_done @regression @PAT-4326 @TestCaseKey=PAT-T279 @known_issue
  Scenario:  Policy issuance of Auto and Home
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I fully issue the multiple policies
    Then the products status should be "INFORCE" or "ISSUED"