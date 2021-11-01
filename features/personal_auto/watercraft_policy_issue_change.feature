@watercraft @new_business @policy_change
Feature: Watercraft - policy change and policy cancellation

  @fixture_watercraft_policy @regression @delete_when_done @TestCaseKey=PAT-T1687
  Scenario: Watercraft Policy - non premium change endorsement by CMI
    Given I have created a new "watercraft" policy
    And I fully issue the watercraft policy
    And I save premium after issuing the policy completely from "IN - Summit Watercraft" page
    When I navigate to policies "IN - Summit Watercraft" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium

#    bug PAT-11931
  @fixture_watercraft_policy @delete_when_done @TestCaseKey=PAT-T3265
  Scenario: Watercraft Policy - premium change endorsement by CMI
    Given I have created a new "watercraft" policy
    And I fully issue the watercraft policy
    And I save premium after issuing the policy completely from "IN - Summit Watercraft" page
    When I navigate to policies "IN - Summit Watercraft" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first property from the watercraft policy summary page with the file "watercraft_policy_change_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium

  @fixture_watercraft_policy @delete_when_done @TestCaseKey=PAT-T2130 @post_deploy_candidate @regression
  Scenario: Watercraft Policy Cancellation Confirmation
    Given I have created a new "watercraft" policy
    And I fully issue the watercraft policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"