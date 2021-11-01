@new_business @homeowners @policy_change
Feature: Home - Cancel Reasons

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T842 @regression @PAT-9237
  Scenario:  Home Cancel Reasons
    Given I have started a new home policy through the "auto policy coverages" modal
    And I fully issue the home policy
    And the products status should be "INFORCE" or "ISSUED"
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

  @fixture_home_policy_issuance_agent @delete_when_done @TestCaseKey=PAT-T5252 @PAT-9237 @regression
  Scenario: Home cancel using Agent
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports for home
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate reason dropdown for cancel
      | Insureds request                    |
      | Insureds deceased                   |
      | Moved out of state                  |
      | Rewritten to another Central Policy |

