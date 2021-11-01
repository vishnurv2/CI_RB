Feature: To validate Evidence Of Cancellation pdf and Cancel Notice pdf for Auto LOB

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation_7 @integration
  Scenario: To validate Evidence Of Cancellation pdf for Auto LOB
    Given I have created a new "auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I gather account and policy numbers for "IN - Auto" for fully issued policy
    Then I saved the "EvidenceOfCancellation" pdf
    Then I validate the EvidenceOfCancellation pdf

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation_7 @integration
  Scenario: To validate Cancel Notice pdf for Auto LOB
    Given I have created a new "auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I gather account and policy numbers for "IN - Auto" for fully issued policy
    Then I saved the "CancelNotice" pdf
    Then I validate the CancelNotice pdf