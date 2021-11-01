Feature: Verify third party reports

  @fixture_auto_policy_none_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Auto Clue Report
    Given I have created a new "auto" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I gather account and policy numbers for "IN - Auto"
    Then I saved the "AutoClueReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto" reports
    Then I validate the Auto Clue Report

  @fixture_auto_policy_none_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of MVReport
    Given I have created a new "auto" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I gather account and policy numbers for "IN - Auto"
    Then I saved the "MVReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto" reports
    Then I validate the MVReport

  @fixture_auto_policy_none_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Auto Data Prefil Report
    Given I have created a new "auto" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I gather account and policy numbers for "IN - Auto"
    Then I saved the "AutoDataPrefillReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto" reports
    Then I validate the AutoDataPrefillReport

  @fixture_auto_policy_none_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Vehicle Data Report
    Given I have created a new "auto" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I gather account and policy numbers for "IN - Auto"
    Then I saved the "VehicleDataReport" pdf
    Then I save the XML
    Then I gather additional data for vehicle data reports
    Then I validate the VehicleDataReport

  @fixture_auto_policy_none_combined_none_pdf_validation_2 @document_verification @integration
  Scenario: Verify contents of Credit Score Report
    Given I have created a new "auto" policy
    And I begin issuance
    Then I order CLUE and MVR reports
    And I gather account and policy numbers for "IN - Auto"
    Then I saved the "CreditScoreReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto" reports
    Then I validate the CreditScoreReport

  @fixture_home_policy_none_combined_none_pdf_validation @document_verification @integration
  Scenario: Verify contents of Property Clue Report
    Given I have created a new "home" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I gather account and policy numbers for "IN - Homeowners"
    Then I save the "PropertyClueReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Homeowners" reports
    Then I validate the Property Clue Report

  @fixture_home_policy_none_combined_none_pdf_validation @document_verification @integration
  Scenario: Verify contents of Credit Score Report
    Given I have created a new "home" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I gather account and policy numbers for "IN - Homeowners"
    Then I save the "CreditScoreReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Homeowners" reports
    Then I validate the Insurance Score Report

  @fixture_dwelling_policy_issuance @delete_when_done @integration
  Scenario:  Binder Document Validation for Dwelling Policy
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    Then I order CLUE and MVR reports
    And I gather account and policy numbers for "IN - Special Dwelling"
    Then I save the "PropertyClueReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Special Dwelling" reports
    Then I validate the Property Clue Report

  @fixture_umbrella_policy @document_verification @wip
  Scenario: Verify contents of Umbrella Binder document
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    And I gather account and policy numbers for "IN - Umbrella"
    Then I save the "CreditScoreReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Umbrella" reports
    Then I validate the Insurance Score Report

  @fixture_scheduled_property_policy_issuance @delete_when_done @integration
  Scenario:  Policy issuance Scheduled Property verifying Quote PDF
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Scheduled Property"
    Then I save the "CreditScoreReport" pdf
    Then I save the XML
    Then I gather additional data for "IN - Scheduled Property" reports
    Then I validate the Insurance Score Report