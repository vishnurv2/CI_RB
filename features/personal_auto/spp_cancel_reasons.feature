@scheduled_property @policy_issuance @policy_change
Feature: Scheduled Property - Cancel Reasons

  @fixture_scheduled_property_policy_issuance @delete_when_done @TestCaseKey=PAT-T846 @regression @PAT-9239
  Scenario:  Scheduled Property - cancel Reasons
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    Then the products status should be "INFORCE" or "ISSUED"
    Then I validate reason dropdown for cancel
      | Insureds request                                |
      | Insureds deceased                               |
      | Moved out of state                              |
      | Rewritten to another Central Policy             |
      | Claims Activity                                 |
      | Underwriting Information Requested Not Received |
      | Lack of Supporting Business                     |
      | No supporting business                          |
      | Non-Payment of Premium                          |
      | Other                                           |

  @fixture_scheduled_property_policy_agent @delete_when_done @TestCaseKey=PAT-T5255 @PAT-9239 @regression
  Scenario: Scheduled Property cancel using Agent
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    When I answer all the underwriting questions
    #Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate reason dropdown for cancel
      | Insureds request                    |
      | Insureds deceased                   |
      | Moved out of state                  |
      | Rewritten to another Central Policy |