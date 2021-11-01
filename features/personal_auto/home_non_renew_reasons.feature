@homeowners @new_business @policy_issuance
Feature: Home - Non Renew Reasons

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T841 @regression @PAT-9242
  Scenario:  Home - non renew Reasons
    Given I have started a new home policy through the "auto policy coverages" modal
    And I fully issue the home policy
    And the products status should be "INFORCE" or "ISSUED"
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
      | Other                       |
    And I validate filled wording on notice for the following reasons
      | No supporting business                          |
      | Inspection / Condition of Premises              |
      | No Longer Owner Occupied                        |
      | Underwriting Information Requested Not Received |

  @fixture_home_policy_issuance_agent @delete_when_done @TestCaseKey=PAT-T5222 @PAT-9242 @regression
  Scenario: Home non renew using Agent
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports for home
    Then I check for underwriter referrals and login as CMI user to resolve it in case it is there
    When I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate "renew" option is not present

