Feature: Form Declaration PDFs Validation

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation @document_verification @integration
  Scenario: SC_01_8040900_Eff_10/26/20 Verify contents of Policy Declarations And Forms document for Auto
    Given I have created a new "auto" policy
    When I add a vehicle from the fixture file "intigration_motorhome"
    When I add a vehicle from the fixture file "intigration_trailers"
    When I add a vehicle from the fixture file "intigration_camper"
    When I add a vehicle from the fixture file "intigration_all_terrain_vehicle"
    And I fully issue the policy
    And I gather account and policy numbers for "IN - Auto" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for IN - Auto for Policy Document
    Then I validate the Policy Declaration Forms PDF
    #Then I should see below mentioned Forms in the generated PDF for Auto


  @fixture_integration_auto_policy_summit_combined_none_pdf_validation @document_verification @integration
    Scenario: SC_02_8040900_Eff_10/24/20 Verify contents of Policy Declarations And Forms document for Auto-Summit
      Given I have created a new "auto" policy
      When I add a vehicle from the fixture file "intigration_motorhome"
      When I apply the "Customer Loyalty" override in panel 1
      And I fully issue the policy
      And I gather account and policy numbers for "IN - Signature Auto" for fully issued policy
      Then I saved the "PolicyDeclarationsAndForms" pdf
      Then I save the XML
      Then I gather additional data for IN - Signature Auto for Policy Document
      Then I validate the Policy Declaration Forms PDF for Auto Signature
      #Then I should see below mentioned Forms in the generated PDF for Auto


  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation @document_verification @integration @known_issue
    Scenario: SC_03_8040900_Eff_10/23/20 Verify contents of Policy Declarations And Forms document for Auto-Signature
      Given I have created a new "auto" policy
      When I add a vehicle from the fixture file "intigration_motorhome"
      And I have loaded the fixture file named "auto_policy_party_loss_payee"
      And I select party type as "Business Entity" and role as "Trust" and add new party details
      Then I validate "Trust" role details and "save and close" the modal
      And I select party type as "Business Entity" and role as "Additional Interest" and add new party details
      Then I validate "Additional Interest" role details and "save and close" the modal
      And I select party type as "Individual" and role as "Trustee" and add new party details
      Then I validate Trustee role details and "save and close" the modal
      And I fully issue the policy
      And I gather account and policy numbers for "IN - Summit Auto" for fully issued policy
      Then I saved the "PolicyDeclarationsAndForms" pdf
      Then I save the XML
      Then I gather additional data for IN - Summit Auto for Policy Document
      Then I validate the Policy Declaration Forms PDF for Auto Summit
     # Then I should see below mentioned Forms in the generated PDF for Auto


  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_4 @integration
  Scenario: SC_04_8040929_Eff_10/30/20 Verify contents of Policy Declarations And Forms document for Auto-Signature
    Given I have created a new "auto" policy
    When I provide details of transportation network coverage in auto vehicle coverage modal from tnc_more_than_20_hrs fixture
    When I add a vehicle from the fixture file "intigration_motorhome"
    When I add a vehicle from the fixture file "intigration_trailers"
    And I fully issue the policy
    And I gather account and policy numbers for "IN - Summit Auto" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for IN - Summit Auto for Policy Document SC_04
    Then I validate the Policy Declaration Forms PDF for Auto Summit SC_04
    # Then I should see below mentioned Forms in the generated PDF for Auto


    # PAT-10900 bug raised PP2329
  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_5 @document_verification @integration @known_issue
  Scenario: SC_05_8040937_Eff_11/4/20 Verify contents of Policy Declarations And Forms document for Auto-Summit
    Given I have created a new "auto" policy
    When I modify the auto policy optional coverages
    When I provide details of transportation network coverage in auto vehicle coverage modal from tnc_more_than_20_hrs fixture
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I validate "Trust" role details and "save and close" the modal
    And I select party type as "Individual" and role as "Trustee" and add new party details
    Then I validate Trustee role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "Additional Interest" and add new party details
    Then I validate "Additional Interest" role details and "save and close" the modal
    And I fully issue the policy
    And I gather account and policy numbers for "IN - Summit Auto" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for IN - Auto for Policy Document for Sc_05
    Then I validate the Policy Declaration Forms PDF for SC_05
    #Then I should see below mentioned Forms in the generated PDF for Auto

  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_6 @integration @known_issue
  Scenario: SC_06_8040937_Eff_11/4/20 Verify contents of Policy Declarations And Forms document for Auto-Signature
    Given I have created a new "auto" policy
    When I add a vehicle from the fixture file "intigration_camper_2"
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "Corporate Auto" and add new party details
    Then I validate "Corporate Auto" role details and "save and close" the modal
    And I fully issue the policy
    And I gather account and policy numbers for "IN - Signature Auto" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for IN - Signature Auto for Policy Document
    Then I validate the Policy Declaration Forms PDF for Auto Signature
    # Then I should see below mentioned Forms in the generated PDF for Auto

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation_7 @integration
  Scenario: SC_07_8040942_Eff_11/05/20 Verify contents of Policy Declarations And Forms document for Auto
    Given I have created a new "auto" policy
    When I provide details of Extended Transportation coverage in auto vehicle coverage modal from tnc_more_than_20_hrs fixture
    And I fully issue the policy
    And I gather account and policy numbers for "IN - Auto" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for IN - Auto for Policy Document for SC_07
    Then I validate the Policy Declaration Forms PDF for Auto for SC_07
   # Then I should see below mentioned Forms in the generated PDF for Auto SC_07
