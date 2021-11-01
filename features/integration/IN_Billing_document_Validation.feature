Feature: Billing documents validation test cases

  @integration
  Scenario: Binder Document Validation using legacy account login
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto Plus"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto Plus"
    Then I validate the PDF

  @integration
  Scenario: Application Document Validation using legacy account login
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto Plus"
    Then I saved the "Application" pdf
    Then I save the XML
    Then I gather additional data for "IN - Auto Plus" application
    Then I validate the Application PDF

  @integration
  Scenario: Quote Document Validation using legacy account login
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I begin issuance
    And I gather account and policy numbers for "IN - Auto Plus"
    Then I saved the "Quote" pdf
    Then I save the XML
    Then I gather additional data for IN - Signature quote
    #Then I gather additional data for "IN - Summit" quote
    Then I validate the Quote PDF