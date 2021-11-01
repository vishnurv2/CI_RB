@auto @document
Feature: Customer loyalty overrides

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation @document_verification @regression @PAT-T427 @TestCaseKey=PAT-T3271 @delete_when_done
  Scenario: SC_01_8040900_Eff_10-26-20 Verify contents of Policy Declarations And Forms document for Auto
    Given I have created a new "auto" policy
    When I add a vehicle from the fixture file "intigration_motorhome"
    When I add a vehicle from the fixture file "intigration_trailers"
    When I add a vehicle from the fixture file "intigration_camper"
    When I add a vehicle from the fixture file "intigration_all_terrain_vehicle"
    Then I should see a "2016 Cadillac ESCALADE" in override panel for tier 1
    Then I should see a "2016 Adventurer Adventurer" in override panel for tier 1
    Then I should see a "2003 Honda TRX400EX Sportrax 400EX" in override panel for tier 1
    Then I should see a "2016 Adventurer Adventurer" in override panel for tier 1
    Then I should see a "2016 Adventurer Adventurer" in override panel for tier 1
