@new_business @homeowners @dwelling
Feature: Home & Dwelling - Override - Inspection

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T3363 @PAT-10814 @regression @homeowners
  Scenario:  Home override - Inspection
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    And I should not see a "Inspection" in override panel 1

  @fixture_dwelling_policy_issuance @delete_when_done @TestCaseKey=PAT-T5276 @PAT-10814 @regression @dwelling
  Scenario:  Dwelling override - Inspection
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    And I should not see a "Inspection" in override panel 1