Feature: Policy Documents PDFs Validation

  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_4 @integration
  Scenario: Verify Policy Declaration Pdf for Auto
    Given I have created a new "auto" policy
    And I fully issue the policy
    And I gather account and policy numbers for "IN - Summit Auto" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for auto declaration pdf
    Then I validate auto declaration pdf

  @fixture_home_policy_none_combined_none_pdf_validation @integration
  Scenario: Verify Policy Declaration Pdf for Home
    Given I have created a new "home" policy
    And I fully issue the home policy
    And I gather account and policy numbers for "IN - Homeowners" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for home declaration pdf
    Then I validate home declaration pdf

  @fixture_scheduled_property_policy_issuance @integration
  Scenario:  Verify Policy Declaration Pdf for scheduled
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    And I gather account and policy numbers for "IN - Scheduled Property" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for scheduled declaration pdf
    Then I validate scheduled declaration pdf

  @fixture_watercraft_policy @integration
  Scenario: Verify Policy Declaration Pdf for watercraft
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
    And I gather account and policy numbers for "IN - Summit Watercraft" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for Watercraft declaration pdf
    Then I validate Watercraft declaration pdf

  @fixture_dwelling_policy_issuance @delete_when_done @integration @wip
  Scenario:  Policy Declaration  Document Validation for Dwelling Policy
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the home policy
    And I gather account and policy numbers for "IN - Special Dwelling" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML
    Then I gather additional data for Dwelling declaration pdf
    Then I validate Dwelling declaration pdf