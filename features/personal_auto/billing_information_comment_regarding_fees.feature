@auto @policy_issuance
Feature: Billing information per product post issuance - add comment regarding fees

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5377 @PAT-12228 @regression
  Scenario: Billing information per product post issuance - add comment regarding fees
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I finish issuing the policy
    Then the products status should be "INFORCE" or "ISSUED"
    And I navigate to policies "IN - Auto" using the left nav
    Then I validate comment regarding fees
