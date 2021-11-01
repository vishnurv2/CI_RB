@watercraft @new_business
Feature: Watercraft - Cancel Reasons

  @fixture_watercraft_policy @delete_when_done @TestCaseKey=PAT-T847 @regression @PAT-9240
  Scenario:  Watercraft - cancel Reasons
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
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

  @fixture_watercraft_policy_agent @delete_when_done @TestCaseKey=PAT-T5256 @regression @PAT-9240
  Scenario: Watercraft cancel using Agent
    Given I have created a new "watercraft" policy
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

