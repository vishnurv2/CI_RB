Feature: Automation can verify PDFs

  @fixture_home_policy_none_combined_none_pdf_validation @document_verification @integration
  Scenario: Verify contents of Home Binder document
    Given I have created a new "home" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Homeowners"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I gather additional data for home policy "IN - Homeowners"
    Then I validate the PDF for Binder

  @fixture_home_policy_none_combined_none_pdf_validation @document_verification @integration
  Scenario: Verify contents of Home Quote document
    Given I have created a new "home" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Homeowners"
    Then I save the "Quote" pdf
    Then I save the XML
    Then I gather additional data for home policy "IN - Homeowners"
    Then I validate the PDF for Home Quote

    # remove the 0 from the protection class code from validation
  @fixture_home_policy_none_combined_none_pdf_validation @document_verification
  Scenario: Verify contents of Home Application document
    Given I have created a new "home" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Homeowners"
    Then I save the "Application" pdf
    Then I save the XML
    Then I gather additional data for home policy "IN - Homeowners"
    Then I validate the PDF for Home Application