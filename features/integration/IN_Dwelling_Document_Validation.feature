Feature: Dwelling policy Document Validation


  @fixture_dwelling_policy_issuance @delete_when_done @integration @wip
  Scenario:  Policy Declaration  Document Validation for Dwelling Policy
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the home policy
    And I gather account and policy numbers for "IN - Special Dwelling" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I save additional details for dwelling Policy Declaration
    Then I validate the Policy Declaration Document for dwelling
    Then I should see below mentioned Forms in the generated PDF for Auto
     | DL2401  | 07/14 | PERSONAL LIABILITY                                                 |
     | DL2471  | 12/02 | LIMITED FUNGI, WET OR DRY ROT, OR BACTERIA COVERAGE                |
     | DP0003  | 07/14 | DWELLING PROPERTY 3 SPECIAL FORM                                   |
     | DP0113  | 11/17 | IN-SPECIAL PROVISIONS                                              |
     | DP0312  | 07/14 | WINDSTORM OR HAIL PERCENTAGE DEDUCTIBLE                            |
     | DP0419  | 12/02 | WINDSTORM OR HAIL - RADIO AND TELEVISION ANTENNAS, AWNINGS...      |
     | DP0422  | 07/14 | LIMITED FUNGI, WET OR DRY ROT, OR BACTERIA COVERAGE                |
     | DP1143  | 12/02 | DWELLING UNDER CONSTRUCTION                                        |
     | 14-2499 | 04/94 | EXCLUSION-LEAD                                                     |
     | 14-2891 | 01/02 | IN-FLOOD INS NOTICE TO POLICYHOLDERS                               |
     | 14-3112 | 03/05 | CENTRAL MUTUAL SUMMIT DWELLING POLICY ENDORSEMENT - IN             |
     | 14-2895 | 03/02 | DWG INFLATION GUARD END                                            |
     | 14-2847 | 10/00 | CONTINGENT WC                                                      |
     | 20-1768 | 08/91 | MUTUAL POLICY CONDITIONS-APPLICABLE TO CENTRAL MUTUAL              |
     | 20-1769 | 08/91 | PROVISIONS APPLICABLE TO CENTRAL MUTUAL & ALL AMERICA INS CO       |
     | 20-1746 | 03/05 | IN-NOTICE TO POLICYHOLDERS-FILING OF COMPLAINTS W/INSURANCE DEPT   |
     | 20-2088 | 06/19 | CENTRAL INSURANCE COMPANIES PRIVACY NOTICE                         |
     | 20-2143 | 06/14 | AVAILABLE PAY PLANS                                                |
     | 20-2146 | 01/10 | FAIR CREDIT REPORTING POLICYHOLDER NOTICE (CLUE)                   |

  @fixture_dwelling_policy_issuance @delete_when_done @integration @wip
  Scenario:  ISO Location PPC Inquiry Form Document Validation for Dwelling Policy
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the dwelling policy
    And I gather account and policy numbers for "IN - Special Dwelling" for fully issued policy
    Then I saved the "DwellingISOLocationPPCInquiryForm" pdf
    Then I save the XML
    Then I save additional details for dwelling ISO Location PPC Inquiry Form
    Then I validate the ISO Location PPC Inquiry Form for dwelling

  @fixture_dwelling_policy_issuance @delete_when_done @integration
  Scenario:  Binder Document Validation for Dwelling Policy
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    And I gather account and policy numbers for "IN - Special Dwelling"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I save additional details for Dwelling Binder
    Then I validate the Binder Document for Dwelling

  @fixture_dwelling_policy_issuance @delete_when_done @integration
  Scenario:  Application Document Validation for Dwelling Policy
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    And I gather account and policy numbers for "IN - Special Dwelling"
    Then I save the "Application" pdf
    Then I save the XML
    Then I save additional details for Application Binder
    Then I validate the Binder Document for Application

  @fixture_dwelling_policy_issuance @delete_when_done @integration
  Scenario:  Quote Document Validation for Dwelling Policy
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    And I gather account and policy numbers for "IN - Special Dwelling"
    Then I save the "Quote" pdf
    Then I save the XML
    Then I save additional details for Dwelling Quote
    Then I validate the Binder Document for Quote