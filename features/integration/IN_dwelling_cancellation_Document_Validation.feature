Feature: To validate Evidence Of Cancellation pdf and Cancel Notice pdf for dwelling LOB

  @fixture_dwelling_policy_issuance @integration
  Scenario: To validate Evidence Of Cancellation pdf for Dwelling LOB
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the dwelling policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I gather account and policy numbers for "IN - Special Dwelling" for fully issued policy
    Then I saved the "EvidenceOfCancellation" pdf
    Then I validate the EvidenceOfCancellation pdf

  @fixture_dwelling_policy_issuance @integration
  Scenario: To validate Cancel Notice pdf for Dwelling LOB
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the dwelling policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I gather account and policy numbers for "IN - Special Dwelling" for fully issued policy
    Then I saved the "CancelNotice" pdf
    Then I validate the CancelNotice pdf