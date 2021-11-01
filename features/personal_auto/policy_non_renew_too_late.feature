@auto @policy_issuance
Feature: Policy Non-renew Too Late

  @fixture_auto_policy_none_combined_none_full_vin @PAT-2115 @TestCaseKey=PAT-T3558 @post_deploy_candidate @regression
  Scenario: Policy Non-renew Too Late
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then I provide a reason in the "policy_non_renew_01" file
    And The following reasons should appear in the list for non renew
      | Insurance Score                                 |
      | Lack of Supporting Business                     |
      | Other                                           |
      | Ineligible Vehicle                              |
      | Underwriting Information Requested Not Received |
      | No supporting business                          |
      | Claims Activity And/Or Violation Activity       |
    And The Date notice should be 25 days before the Non-renewal effective date
    Then I close the cancellation modal
    And the policy should show "Inforce" or "Issued" with tooltip message "Policy is set to Non-Renew"




