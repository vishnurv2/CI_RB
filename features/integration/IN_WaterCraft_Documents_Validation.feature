Feature: Document Validation of WaterCraft Policies

  @fixture_watercraft_policy @delete_when_done @PAT-4293 @TestCaseKey=PAT-T85 @integration
  Scenario: Check Binder PDF for WaterCraft Policy
    Given I have created a new "watercraft" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Summit Watercraft"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I save additional details for watercraft Binder
    Then I validate the Binder Document for WaterCraft

  @fixture_watercraft_policy @delete_when_done @integration
  Scenario: Check Application PDF for WaterCraft Policy
    Given I have created a new "watercraft" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Summit Watercraft"
    Then I save the "Application" pdf
    Then I save the XML
    Then I save additional details for watercraft Application
    Then I validate the Application Document for WaterCraft

  @fixture_watercraft_policy @delete_when_done @integration
  Scenario: Check Quote PDF for WaterCraft Policy
    Given I have created a new "watercraft" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Summit Watercraft"
    Then I save the "Quote" pdf
    Then I save the XML
    Then I save additional details for watercraft Quote
    Then I validate the Quote Document for WaterCraft

  @fixture_watercraft_policy @delete_when_done @integration
  Scenario: Check Declaration PDF for WaterCraft Policy
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
    And I gather account and policy numbers for "IN - Summit Watercraft" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I save additional details for watercraft Policy Declaration
    Then I validate the Policy Declaration Document for WaterCraft
    Then I should see below mentioned Forms in the generated PDF for Auto
     | BT0100  | 05/08 | BOATOWNERS SPECIAL FORM                                                  |
     | BT0813  | 08/13 | IN-AMENDATORY ENDORSEMENT                                                |
     | BT0900  | 05/08 | POLICY CONDITIONS CANCELLATION AND NONRENEWAL                            |
     | BT1301  | 05/08 | PUNITIVE DAMAGE EXCLUSION                                                |
     | BT1303  | 07/13 | POLLUTANTS - AMENDMENT DEFINITION                                        |
     | BT2500  | 05/08 | EXPANDED EMERGENCY SERVICE                                               |
     | BT3000  | 05/08 | PERSONAL EFFECTS COVERAGE                                                |
     | BT6003  | 05/08 | AGREED VALUE LOSS PAYEE PROVISION                                        |
     | 20-1746 | 03/05 | IN-NOTICE TO POLICYHOLDERS-FILING OF COMPLAINTS W/INSURANCE DEPT         |
     | 20-1768 | 08/91 | MUTUAL POLICY CONDITIONS-APPLICABLE TO CENTRAL MUTUAL                    |
     | 20-1769 | 08/91 | PROVISIONS APPLICABLE TO CENTRAL MUTUAL & ALL AMERICA INS CO             |
     | 7-1417  | 07/13 | CENTRAL MUTUAL SUMMIT BOAT ENDORSEMENT                                   |