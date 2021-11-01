Feature: To validate Evidence Of Cancellation pdf and Cancel Notice pdf for non pay cancel Umbrella LOB

#  bug PAT-13323
  @fixture_umbrella_policy @integration @known_issue @wip
  Scenario: To validate Evidence Of Cancellation pdf for non pay cancel Umbrella LOB
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I fully issue the umbrella policy
    When I cancel a policy with reasons in the "policy_cancellation_04" file
    When I close the cancellation modal
    Then the policy should show "NON-PAY CANCEL"
    And I gather account and policy numbers for "IN - Umbrella" for fully issued policy
    Then I saved the "EvidenceOfCancellation" pdf
    Then I validate the EvidenceOfCancellation pdf

  @fixture_umbrella_policy @integration
  Scenario: To validate Cancel Notice pdf for non pay cancel Umbrella LOB
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I fully issue the umbrella policy
    When I cancel a policy with reasons in the "policy_cancellation_04" file
    When I close the cancellation modal
    Then the policy should show "NON-PAY CANCEL"
    And I gather account and policy numbers for "IN - Umbrella" for fully issued policy
    Then I saved the "CancelNotice" pdf
    Then I validate the CancelNotice pdf