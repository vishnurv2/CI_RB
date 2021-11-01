Feature: Create dwelling policies as Agent

  @fixture_dwelling_policy_issuance @delete_when_done @regression @TestCaseKey=PAT-T1680 @dwelling @policy_issuance
  Scenario: Validate of the dwelling Quote Created by Agent
    Given I have created a new "dwelling" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @delete_when_done @fixture_dwelling_policy_issuance_tomorrow @regression @TestCaseKey=PAT-T1681 @dwelling @policy_issuance
  Scenario: Fully Issuing dwelling Policy as agent
    Given I have created a new "dwelling" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_dwelling_policy_agent @delete_when_done @TestCaseKey=PAT-T1682 @post_deploy_candidate @regression @dwelling @policy_issuance @policy_change
  Scenario: Dwelling Policy - non premium change endorsement by agent
    Given I have created a new "dwelling" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I save premium after issuing the policy completely from "IN - Special Dwelling" page
    When I navigate to policies "IN - Special Dwelling" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium

  @fixture_dwelling_policy_agent @regression @delete_when_done @TestCaseKey=PAT-T1683 @known_issue @dwelling @policy_issuance @policy_change
  Scenario: Dwelling Policy - premium change endorsement by agent
    Given I have created a new "dwelling" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I save premium after issuing the policy completely from "IN - Special Dwelling" page
    When I navigate to policies "IN - Special Dwelling" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first property from the dwelling policy summary page with the file "dwelling_policy_change_property_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium