@homeowners @new_business
Feature: Fully Home policy issuance As an Agent

  @fixture_home_policy_issuance_agent @delete_when_done @TestCaseKey=PAT-T3621 @post_deploy_candidate @regression
  Scenario: Home Policy fully issuance as Agent
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports for home
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_home_policy_prefill_issuance_agent @delete_when_done @regression @TestCaseKey=PAT-T3622
  Scenario: Home Policy fully issuance Prefill Address
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports for home
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_home_policy_type_5s_summit_homeowners_agent @delete_when_done @regression @TestCaseKey=PAT-T3623
    Scenario: Home Policy type 5S Summit fully issuance as Agent
      Given I have started a new home policy through the "auto policy coverages" modal
      And I begin issuance
      When I answer all the underwriting questions
      Then I order CLUE and MVR reports for home
      Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
      When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_home_policy_type_5g_signature_homeowners_agent @delete_when_done @regression @TestCaseKey=PAT-T3624
  Scenario:  Home Policy type 5G Signature fully issuance as Agent
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports for home
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"