Feature: To validate Evidence Of Cancellation pdf and Cancel Notice pdf for Non pay cancel Home LOB

  @fixture_home_policy_none_combined_none_pdf_validation @integration
  Scenario: To validate Evidence Of Cancellation pdf for Non pay cancel Home LOB
    Given I have created a new "home" policy
    And I fully issue the home policy
    When I cancel a policy with reasons in the "policy_cancellation_04" file
    When I close the cancellation modal
    Then the policy should show "NON-PAY CANCEL"
    And I gather account and policy numbers for "IN - Homeowners" for fully issued policy
    Then I saved the "EvidenceOfCancellation" pdf
    Then I validate the EvidenceOfCancellation pdf

  @fixture_home_policy_none_combined_none_pdf_validation @integration
  Scenario: To validate Cancel Notice pdf for Non pay cancel Home LOB
    Given I have created a new "home" policy
    And I fully issue the home policy
    When I cancel a policy with reasons in the "policy_cancellation_04" file
    When I close the cancellation modal
    Then the policy should show "NON-PAY CANCEL"
    And I gather account and policy numbers for "IN - Homeowners" for fully issued policy
    Then I saved the "CancelNotice" pdf
    Then I validate the CancelNotice pdf