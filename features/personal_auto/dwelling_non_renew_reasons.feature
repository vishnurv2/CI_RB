@dwelling @policy_issuance
Feature: Dwelling - Non Renew Reasons

  @fixture_dwelling_policy_issuance @delete_when_done @TestCaseKey=PAT-T840 @regression @PAT-9246
  Scenario:  Dwelling - non renew Reasons
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the dwelling policy
    Then the products status should be "INFORCE" or "ISSUED"
    Then I validate reason dropdown for non renew
      | Inspection / Condition of Premises              |
      | No Longer Owner Occupied                        |
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
      | Inspection / Condition of Premises              |
      | No Longer Owner Occupied                        |
      | Underwriting Information Requested Not Received |

  @fixture_dwelling_policy_agent @delete_when_done @TestCaseKey=PAT-T5223 @PAT-9246 @regression
  Scenario: Dwelling non renew using Agent
    Given I have created a new "dwelling" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate "renew" option is not present

