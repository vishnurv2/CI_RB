@watercraft @new_business
Feature: Create policies as Agent

  @fixture_watercraft_policy_agent @delete_when_done @regression @TestCaseKey=PAT-T1693
  Scenario: Validate of the Watercraft Quote Created by Agent
    Given I have created a new "watercraft" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @delete_when_done @fixture_watercraft_policy_agent_tomorrow @regression @TestCaseKey=PAT-T1694 @delete_when_done
  Scenario: Fully Issuing a Watercraft Policy as agent
    Given I have created a new "watercraft" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_watercraft_policy_agent @regression @delete_when_done @TestCaseKey=PAT-T1695
  Scenario: Watercraft Policy - non premium change endorsement by agent
    Given I have created a new "watercraft" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I save premium after issuing the policy completely from "IN - Summit Watercraft" page
    When I navigate to policies "IN - Summit Watercraft" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium

  @fixture_watercraft_policy_agent @regression @delete_when_done @TestCaseKey=PAT-T3792
  Scenario: Watercraft Policy - premium change endorsement by agent
    Given I have created a new "watercraft" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I save premium after issuing the policy completely from "IN - Summit Watercraft" page
    When I navigate to policies "IN - Summit Watercraft" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first property from the watercraft policy summary page with the file "watercraft_policy_change_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium