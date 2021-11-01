@watercraft @new_business
Feature: Watercraft - Non Renew Reasons

  @fixture_watercraft_policy @delete_when_done @TestCaseKey=PAT-T849 @regression @PAT-9245
  Scenario:  Watercraft - non renew Reasons
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
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

  @fixture_watercraft_policy_agent @delete_when_done @TestCaseKey=PAT-T5251 @regression @PAT-9245
  Scenario: Watercraft non renew using Agent
    Given I have created a new "watercraft" policy
    And I begin issuance
    When I answer all the underwriting questions
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate "renew" option is not present

