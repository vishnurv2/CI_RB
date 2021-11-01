@homeowners @new_business
Feature: Home policy change and policy cancellation

  @fixture_home_policy_none_combined_none_pdf_validation @regression @delete_when_done @TestCaseKey=PAT-T2099
  Scenario: Home Policy - non premium change endorsement
    Given I have created a new "home" policy
    And I fully issue the home policy
    And I save premium after issuing the policy completely from "In - Homeowners" page
    When I navigate to policies "In-Homeowners" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium

    #PAT-10559 bug raised by Manual testing team ...Change Premium is matching with original premium...It should not match
  @fixture_home_policy_none_combined_none_pdf_validation @delete_when_done @TestCaseKey=PAT-T2100 @known_issue
  Scenario: Home Policy - premium change endorsement
    Given I have created a new "home" policy
    And I fully issue the home policy
    And I save premium after issuing the policy completely from "In - Homeowners" page
    When I navigate to policies "In-Homeowners" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first property from the home policy summary page with the file "policy_change_property_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium

    #PAT-8390  not showing cancelled, showing cancel pending
   @fixture_home_policy_none_combined_none_pdf_validation @regression @delete_when_done @TestCaseKey=PAT-T2101
  Scenario: Home Policy Cancellation Confirmation
    Given I have created a new "home" policy
    And I fully issue the home policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"