Feature: To validate Non Renewal Notice pdf for Auto LOB

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation_7 @integration @known_issue
  Scenario: To validate Non Renewal Notice pdf for Auto LOB
    Given I have created a new "auto" policy
    And I fully issue the policy
    Then I provide a reason in the "policy_non_renew_01" file
    When I close the cancellation modal
    And I gather account and policy numbers for "IN - Auto" for fully issued policy
    Then I saved the "NonRenewalNotice" pdf
    Then I validate the NonRenewalNotice pdf