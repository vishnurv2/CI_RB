Feature: Automation can verify PDFs

  @fixture_auto_policy_none_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Application document for Auto
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto"
    Then I saved the "Application" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto Plus" application
    Then I validate the Application PDF

  @fixture_auto_policy_autoplus_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Application document for Auto Plus
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto Plus"
    Then I saved the "Application" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto Plus" quote
    Then I validate the Application PDF

  @fixture_auto_policy_sig_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Applicant document on Signature
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Signature"
    Then I save the "Application" pdf
    Then I save the XML
    Then I gather additional data for "IN - Signature" quote
    Then I validate the Application PDF

  @fixture_auto_policy_summit_combined_none_pdf_validation_2 @document_verification @integration
    Scenario: Verify contents of Applicant document on Summit
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Summit"
    Then I save the "Application" pdf
    Then I save the XML
    Then I gather additional data for "IN - Summit" quote
    Then I validate the Application PDF