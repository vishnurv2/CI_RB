@scheduled_property @agent_validation
Feature: Create policies as Agent

  @fixture_schedule_property_policy_agent @delete_when_done @regression @TestCaseKey=PAT-T3330 @policy_issuance
  Scenario:  Policy issuance Scheduled Property policy
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @delete_when_done @fixture_schedule_property_policy_tomorrow @regression @TestCaseKey=PAT-T3331 @policy_issuance
  Scenario: Fully Issuing a Scheduled Property policy as agent
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the product status should be "Issued"

#    bug PAT-11932
  @fixture_schedule_property_policy_agent @delete_when_done @regression @TestCaseKey=PAT-T3332 @policy_change
  Scenario: Scheduled Property Policy - non premium change endorsement by agent
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I save premium after issuing the policy completely from "IN - Scheduled Property" page
    When I navigate to policies "IN - Scheduled Property" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium

  @fixture_schedule_property_policy_agent @delete_when_done @regression @wip @TestCaseKey=PAT-T3333 @policy_change
  Scenario: Scheduled Property Policy - premium change endorsement by agent
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I save premium after issuing the policy completely from "IN - Scheduled Property" page
    When I navigate to policies "IN - Scheduled Property" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first property from the scheduled property policy summary page with the file "scheduled_property_policy_change_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium