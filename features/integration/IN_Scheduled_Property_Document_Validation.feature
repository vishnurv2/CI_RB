Feature: Automation can verify PDFs for Scheduled Property

  @fixture_scheduled_property_policy_issuance @delete_when_done @integration
  Scenario:  Policy issuance Scheduled Property and validate the PolicyDeclarationsAndForms
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    And I gather account and policy numbers for "IN - Scheduled Property" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for schedule property policy
    Then I validate the PDF for Schedule Property Declaration
    Then I should see below mentioned Forms in the generated PDF for Auto
      | PM0001  | 12/02 | COMMON POLICY PROVISIONS                                           |
      | PM0009  | 12/02 | PERSONAL ARTICLES STANDARD LOSS SETTLEMENT FORM                    |
      | PM0010  | 12/02 | PERSONAL ARTICLES AGREED LOSS SETTLEMENT FORM                      |
      | 20-1746 | 03/05 | IN-NOTICE TO POLICYHOLDERS-FILING OF COMPLAINTS W/INSURANCE DEPT   |
      | 20-1768 | 08/91 | MUTUAL POLICY CONDITIONS-APPLICABLE TO CENTRAL MUTUAL              |
      | 7-1443  | 02/15 | PERSONAL INLAND MARINE AMENDATORY ENDORSEMENT                      |

  @fixture_scheduled_property_policy_issuance @delete_when_done @integration
  Scenario:  Policy issuance Scheduled Property verifying Quote PDF
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Scheduled Property"
    Then I saved the "Quote" pdf
    Then I save the XML
    Then I gather additional data for schedule property policy Quote PDF
    Then I validate the quote PDF

  @fixture_scheduled_property_policy_issuance @delete_when_done @integration
  Scenario:  Policy issuance Scheduled Property verifying Binder PDF
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Scheduled Property"
    Then I saved the "Binder" pdf
    Then I save the XML
    Then I gather additional data for schedule property policy Binder PDF
    Then I validate the Binder PDF

  @fixture_scheduled_property_policy_issuance @delete_when_done @integration
  Scenario:  Policy issuance Scheduled Property verifying Application PDF
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Scheduled Property"
    Then I saved the "Application" pdf
    Then I save the XML
    Then I gather additional data for schedule property policy Application PDF
    Then I validate the Application PDF for Schedule Property