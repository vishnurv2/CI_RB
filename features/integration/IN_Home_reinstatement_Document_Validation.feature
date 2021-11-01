Feature: To validate Reinstatement pdf for Home LOB

  @fixture_home_policy_none_combined_none_pdf_validation @integration
  Scenario: To validate Reinstatement pdf for Home LOB
    Given I have created a new "home" policy
    And I fully issue the home policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"
    And I gather account and policy numbers for "IN - Homeowners" for fully issued policy
    Then I saved the "ReinstatementDeclaration" pdf
    Then I validate the ReinstatementDeclaration pdf