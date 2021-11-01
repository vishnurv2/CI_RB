Feature: Automation can verify PDFs

  @fixture_auto_policy_none_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Binder document for Auto
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto"
    Then I validate the PDF

  @fixture_auto_policy_autoplus_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Binder document on Auto Plus
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto Plus"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto Plus"
    Then I validate the PDF

  @fixture_auto_policy_sig_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Binder document on Auto Signature
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Signature"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I gather additional data for "IN - Signature"
    Then I validate the PDF

  @fixture_auto_policy_summit_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Binder document on Auto Summit
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Summit"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I gather additional data for "IN - Summit"
    Then I validate the PDF

  @fixture_auto_policy_none_combined_none_pdf_validation_uim_select @document_verification @integration
  Scenario: Verify contents of Binder document for Auto with UIM Coverage
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto" quote for uim
    Then I validate the PDF for UIM