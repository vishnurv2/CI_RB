Feature: To validate Reinstatement pdf for Dwelling LOB

  @fixture_dwelling_policy_issuance @integration
  Scenario: To validate Reinstatement pdf for Dwelling LOB
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the dwelling policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"
    And I gather account and policy numbers for "IN - Special Dwelling" for fully issued policy
    Then I saved the "ReinstatementDeclaration" pdf
    Then I validate the ReinstatementDeclaration pdf