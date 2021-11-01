@multiple
Feature: Umbrella - parcels of vacant land

  #bug PAT-7873
  @fixture_home_policy_none_combined_none_pdf_validation @delete_when_done @regression @PAT-4063 @TestCaseKey=PAT-T77 @known_issue
  Scenario:  Umbrella - parcels of vacant land
    Given I have created a new "home" policy
    And I add an additional Indiana "umbrella" product till "exposures_insured" using the fixture file "umbrella_policy_vacant_land"
    Then The "parcels of vacant land" modal should be visible
    And I should be able to add 2 vacant addresses
    Then the product category should be "Vacant Land"