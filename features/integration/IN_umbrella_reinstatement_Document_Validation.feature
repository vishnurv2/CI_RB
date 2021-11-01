Feature: To validate Reinstatement pdf for Umbrella LOB

  @fixture_umbrella_policy @integration
  Scenario: To validate Reinstatement pdf for Umbrella LOB
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I fully issue the umbrella policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"
    And I gather account and policy numbers for "IN - Umbrella" for fully issued policy
    Then I saved the "ReinstatementDeclaration" pdf
    Then I validate the ReinstatementDeclaration pdf