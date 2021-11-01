@umbrella @policy_issuance
Feature: Umbrella - Non Renew Reasons

  @fixture_umbrella_policy @delete_when_done @TestCaseKey=PAT-T845 @regression @PAT-9243
  Scenario:  Umbrella - non renew Reasons
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I fully issue the umbrella policy
    Then the products status should be "INFORCE" or "ISSUED"
    Then I validate reason dropdown for non renew
      | Underlying Auto Cancelled / Nonrenewed          |
      | Claims Activity                                 |
      | Underwriting Information Requested Not Received |
      | Lack of Supporting Business                     |
      | No supporting business                          |
      | Other                                           |
    And I validate blank wording on notice for the following reasons
      | Claims Activity             |
      | Lack of Supporting Business |
      | Other                       |
    And I validate filled wording on notice for the following reasons
      | No supporting business                          |
      | Underlying Auto Cancelled / Nonrenewed          |
      | Underwriting Information Requested Not Received |

  @fixture_umbrella_policy_agent @delete_when_done @TestCaseKey=PAT-T5224 @PAT-9243 @regression
  Scenario: Umbrella non renew using Agent
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate "renew" option is not present

