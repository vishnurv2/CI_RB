Feature: Automation can verify PDFs

  @fixture_auto_policy_none_combined_none_pdf_validation_2 @integration
  Scenario: Verify contents of Auto Quote document for Auto
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto"
    Then I saved the "Quote" pdf
    Then I save the XML
    Then I gather additional data for IN - Signature quote
    #Then I gather additional data for "IN - Auto" quote
    Then I validate the Quote PDF

  @fixture_auto_policy_autoplus_combined_none_pdf_validation_2 @integration
  Scenario: Verify contents of Auto Quote Application document for Auto Plus
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto Plus"
    Then I saved the "Quote" pdf
    Then I save the XML
    Then I gather additional data for IN - Signature quote
   # Then I gather additional data for "IN - Auto Plus" quote
    Then I validate the Quote PDF

  @fixture_auto_policy_sig_combined_none_pdf_validation_2 @integration
  Scenario: Verify contents of Auto Quote document on Auto Signature
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Signature"
    Then I saved the "Quote" pdf
    Then I save the XML
    Then I gather additional data for IN - Signature quote
    Then I validate the Quote PDF

  @fixture_auto_policy_summit_combined_none_pdf_validation_2 @integration
  Scenario: Verify contents of Auto Quote document on Auto Summit
    Given I have created a new "auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Summit"
    Then I saved the "Quote" pdf
    Then I save the XML
    Then I gather additional data for IN - Signature quote
    # Then I gather additional data for "IN - Summit" quote
    Then I validate the Quote PDF