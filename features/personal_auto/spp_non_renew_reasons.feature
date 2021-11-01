@scheduled_property @policy_change
Feature: Scheduled Property - Non Renew Reasons

  @fixture_scheduled_property_policy_issuance @delete_when_done @TestCaseKey=PAT-T848 @regression @PAT-9244
  Scenario:  Scheduled Property - non renew Reasons
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    Then the products status should be "INFORCE" or "ISSUED"
    Then I validate reason dropdown for non renew
      | Claims Activity                                 |
      | Underwriting Information Requested Not Received |
      | Lack of Supporting Business                     |
      | No supporting business                          |
      | Other                                           |
    And I validate blank wording on notice for the following reasons
      | Claims Activity             |
      | Lack of Supporting Business |
      | No supporting business      |
      | Other                       |
    And I validate filled wording on notice for the following reasons
      | Underwriting Information Requested Not Received |

  @fixture_scheduled_property_policy_agent @delete_when_done @TestCaseKey=PAT-T5225 @PAT-9244 @regression
  Scenario: Scheduled Property non renew using Agent
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate "renew" option is not present