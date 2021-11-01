@umbrella @policy_issuance
Feature: Umbrella - Cancel Reasons

  @fixture_umbrella_policy @delete_when_done @TestCaseKey=PAT-T843 @regression @PAT-9238
  Scenario:  Umbrella - cancel Reasons
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I fully issue the umbrella policy
    Then the products status should be "INFORCE" or "ISSUED"
    Then I validate reason dropdown for cancel
      | Insureds request                                |
      | Insureds deceased                               |
      | Moved out of state                              |
      | Rewritten to another Central Policy             |
      | Underlying Auto Cancelled / Nonrenewed          |
      | Claims Activity                                 |
      | Underwriting Information Requested Not Received |
      | Lack of Supporting Business                     |
      | No supporting business                          |
      | Non-Payment of Premium                          |
      | Other                                           |

  @fixture_umbrella_policy_agent @delete_when_done @TestCaseKey=PAT-T5254 @PAT-9238 @regression
  Scenario: Umbrella cancel using Agent
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate reason dropdown for cancel
      | Insureds request                    |
      | Insureds deceased                   |
      | Moved out of state                  |
      | Rewritten to another Central Policy |


