Feature: To validate Evidence Of Cancellation pdf and Cancel Notice pdf for Scheduled Property LOB

  @fixture_scheduled_property_policy_issuance @integration
  Scenario: To validate Evidence Of Cancellation pdf for Scheduled Property LOB
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I gather account and policy numbers for "IN - Scheduled Property" for fully issued policy
    Then I saved the "EvidenceOfCancellation" pdf
    Then I validate the EvidenceOfCancellation pdf

  @fixture_scheduled_property_policy_issuance @integration
  Scenario: To validate Cancel Notice pdf for Scheduled Property LOB
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I gather account and policy numbers for "IN - Scheduled Property" for fully issued policy
    Then I saved the "CancelNotice" pdf
    Then I validate the CancelNotice pdf