Feature: Billing Summary should show on Account Summary, even when no policies are inforce

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T5774 @PAT-12378 @umbrella @billing
  Scenario: Billing section - present when status is Inforce
    Given I have created a new "umbrella" policy
    And I fully issue the umbrella policy
    Then I refresh the page
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate billing section is present on Account Overview page

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T5775 @PAT-12378 @umbrella @billing
  Scenario: Billing section - present when status is Cancelled
    Given I have created a new "umbrella" policy
    And I fully issue the umbrella policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    And I validate billing section is present on Account Overview page

  @fixture_auto_policy_none_combined_none_full_vin_cancellation_1 @regression @delete_when_done @TestCaseKey=PAT-T5776 @PAT-12378 @auto @policy_change
  Scenario: Billing section - present when status is Cancel Pending
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_02" file
    Then I save and close the cancel_non_renew modal
    And the policy should show "Cancel Pending"
    And I validate billing section is present on Account Overview page