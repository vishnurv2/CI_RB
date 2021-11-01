@account_management @auto
Feature: Policy Issuance As Agent

  @delete_when_done @fixture_agent_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T3634 @post_deploy_candidate @regression
  Scenario: Fully Issuing a Policy as agent
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the product status should be "Issued"

  @delete_when_done @fixture_agent_auto_policy_autoplus_combined_none_full_vin @regression @TestCaseKey=PAT-T3635
  Scenario: Validate the bell icon before and after resolving all issues as agent
    Given I have created a new "Auto" policy
    And I begin issuance
    Then The red dot should be present on issues to resolve link
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    And I refresh the page
    Then The red dot should not be present on issues to resolve link

  @delete_when_done @fixture_agent_auto_policy_autoplus_combined_none_full_vin @regression @TestCaseKey=PAT-T3636
  Scenario: Fully Issuing a Policy as agent using blue streak seal as agent
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I check for underwriter referrals and login as CMI user to resolve it in case it is there using blue streak seal
    When I finish issuing the policies
    Then the product status should be "Issued"