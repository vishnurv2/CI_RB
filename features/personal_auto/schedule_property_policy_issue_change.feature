@scheduled_property @policy_change
Feature: Schedule Property - policy change and policy cancellation

  @fixture_scheduled_property_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T2118
  Scenario: Schedule Property Policy - non premium change endorsement
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    And I save premium after issuing the policy completely from "IN - Scheduled Property" page
    When I navigate to policies "IN - Scheduled Property" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium

    #BUG - PAT-10305, changes are not updating on policy summary page
  @fixture_scheduled_property_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T2119 @wip @known_issue
  Scenario: Schedule Property Policy - premium change endorsement
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    And I save premium after issuing the policy completely from "IN - Scheduled Property" page
    When I navigate to policies "IN - Scheduled Property" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first property from the scheduled property policy summary page with the file "scheduled_property_policy_change_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium

  @fixture_scheduled_property_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T2117
  Scenario: Schedule Property Policy Cancellation Confirmation
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"