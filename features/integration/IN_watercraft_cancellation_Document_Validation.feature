Feature: To validate Evidence Of Cancellation pdf and Cancel Notice pdf for Watercraft LOB

  @fixture_watercraft_policy @integration
  Scenario: To validate Evidence Of Cancellation pdf for Watercraft LOB
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I gather account and policy numbers for "IN - Summit Watercraft" for fully issued policy
    Then I saved the "EvidenceOfCancellation" pdf
    Then I validate the EvidenceOfCancellation pdf

  @fixture_watercraft_policy @integration
  Scenario: To validate Cancel Notice pdf for Watercraft LOB
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I gather account and policy numbers for "IN - Summit Watercraft" for fully issued policy
    Then I saved the "CancelNotice" pdf
    Then I validate the CancelNotice pdf