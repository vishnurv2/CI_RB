Feature: To verify the Auto ID Card PDF Validation

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation_7 @integration
  Scenario: To validate Auto ID card pdf for Auto LOB
    Given I have created a new "auto" policy
    And I fully issue the policy
    And I gather account and policy numbers for "IN - Auto" for fully issued policy
    Then I saved the "AutoIDCard" pdf
    Then I validate the AutoIDCard pdf