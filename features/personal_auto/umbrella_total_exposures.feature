@multiple
Feature: Umbrella - Total Exposures - Insured with Central

  @fixture_auto_policy_exposure_vehicle @delete_when_done @regression @PAT-4057 @TestCaseKey=PAT-T3 @known_issue @PAT-11479
  Scenario:  Umbrella - Total Exposures - Insured with Central
    Given I have created a new "Auto" policy
    And I begin issuance
    And I add an additional Indiana "umbrella" product up to "exposures_insured_modal" using the fixture file "umbrella_policy_exposures"
    Then I validate the exposures present on the exposures modal