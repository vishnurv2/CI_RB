@dwelling @policy_change
Feature: Dwelling - policy change and policy cancellation

  @fixture_dwelling_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T1686
  Scenario: Dwelling Policy - non premium change endorsement by CMI
    Given I have created a new "dwelling" policy
    And I fully issue the dwelling policy
    And I save premium after issuing the policy completely from "In - Special Dwelling" page
    When I navigate to policies "In - Special Dwelling" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium

  @fixture_dwelling_policy_issuance @regression @delete_when_done @known_issue @TestCaseKey=PAT-T3668
  Scenario: Dwelling Policy - premium change endorsement by CMI
    Given I have created a new "dwelling" policy
    And I fully issue the dwelling policy
    And I save premium after issuing the policy completely from "In - Special Dwelling" page
    When I navigate to policies "In - Special Dwelling" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first property from the dwelling policy summary page with the file "dwelling_policy_change_property_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium

    #PAT-8390  not showing cancelled, showing cancel pending
  @fixture_dwelling_policy_issuance @known_issue @regression @delete_when_done @TestCaseKey=PAT-T3669
  Scenario: Dwelling Policy Cancellation Confirmation
    Given I have created a new "dwelling" policy
    And I fully issue the dwelling policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"