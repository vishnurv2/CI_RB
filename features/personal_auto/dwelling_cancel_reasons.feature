@dwelling @policy_issuance
Feature: Dwelling - Cancel Reasons

  @fixture_dwelling_policy_issuance @delete_when_done @TestCaseKey=PAT-T844 @regression @PAT-9241
  Scenario:  Dwelling - Cancel Reasons
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the dwelling policy
    Then the products status should be "INFORCE" or "ISSUED"
    Then I validate reason dropdown for cancel
      | Insureds request                                |
      | Insureds deceased                               |
      | Moved out of state                              |
      | Rewritten to another Central Policy             |
      | Inspection / Condition of Premises              |
      | No Longer Owner Occupied                        |
      | Claims Activity                                 |
      | Underwriting Information Requested Not Received |
      | Lack of Supporting Business                     |
      | No supporting business                          |
      | Non-Payment of Premium                          |
      | Other                                           |

  @fixture_dwelling_policy_agent @delete_when_done @TestCaseKey=PAT-T5253 @PAT-9241 @regression
  Scenario: Dwelling Cancel using Agent
    Given I have created a new "dwelling" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate reason dropdown for cancel
      | Insureds request                    |
      | Insureds deceased                   |
      | Moved out of state                  |
      | Rewritten to another Central Policy |

