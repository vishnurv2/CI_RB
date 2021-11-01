Feature: To validate Reinstatement pdf for Watercraft LOB

  @fixture_watercraft_policy @integration
  Scenario: To validate Reinstatement pdf for Watercraft LOB
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"
    And I gather account and policy numbers for "IN - Summit Watercraft" for fully issued policy
    Then I saved the "ReinstatementDeclaration" pdf
    Then I validate the ReinstatementDeclaration pdf