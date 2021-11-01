@umbrella @policy_issuance
Feature: Umbrella policy issuance

  @fixture_umbrella_policy @delete_when_done @PAT-4326 @TestCaseKey=PAT-T12 @ci
  Scenario:  Umbrella - policy issuance
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I fully issue the umbrella policy
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_auto_policy_exposure_vehicle @delete_when_done @regression @PAT-4326 @TestCaseKey=PAT-T279
  Scenario:  Policy issuance of Auto and Umbrella
    Given I have created a new "Auto" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    And I fully issue the multiple policies
    Then the products status should be "INFORCE" or "ISSUED"
