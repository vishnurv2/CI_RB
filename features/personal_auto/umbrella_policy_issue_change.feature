@umbrella @policy_change
Feature: Umbrella - policy change and policy cancellation feature

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T2122
  Scenario: Umbrella Policy - non premium change endorsement
    Given I have created a new "umbrella" policy
    And I fully issue the umbrella policy
    And I save premium after issuing the policy completely from "In - Umbrella" page
    When I navigate to policies "In - Umbrella" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T2123
  Scenario: Umbrella Policy - premium change endorsement
    Given I have created a new "umbrella" policy
    And I fully issue the umbrella policy
    And I save premium after issuing the policy completely from "In - Umbrella" page
    When I navigate to policies "In - Umbrella" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first coverage information from the umbrella policy summary page with the file "policy_change_umbrella_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T2124
  Scenario: Umbrella Policy Cancellation Confirmation
    Given I have created a new "umbrella" policy
    And I fully issue the umbrella policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"