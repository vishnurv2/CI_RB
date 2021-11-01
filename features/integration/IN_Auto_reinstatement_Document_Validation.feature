Feature: To validate Reinstatement pdf for Auto LOB

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation_7 @integration
  Scenario: To validate Reinstatement pdf for Auto LOB
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"
    And I gather account and policy numbers for "IN - Auto" for fully issued policy
    Then I saved the "ReinstatementDeclaration" pdf
    Then I validate the ReinstatementDeclaration pdf