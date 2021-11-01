@auto @account_management
Feature: Policy Issuance

  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @PAT-12345 @TestCaseKey=PAT-T3559 @regression @post_deploy_candidate
  Scenario: Policy Issuance shows all products and product premiums sum correctly
    Given I have created a new "Auto" policy
    And I add an additional Indiana "automobile" product
    When I navigate to my quote "Quote Management" using the left nav
    Then the total premium for paid in full should be correct
    Then I click the begin issuance
    When I answer all the auto underwriting questions
    Then I order CLUE and MVR reports for multiple policies
    And I resolve any underwriter referrals using blue streak seal or approvals
    Then I navigate to my quote "Quote Management" using the left nav
    Then I should see 2 products to issue
    And the total premium for the products to issue should be correct
