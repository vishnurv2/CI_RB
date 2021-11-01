@auto @new_business
Feature: Account Overview Actions-report a claim should not show unless policy has been issued

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5376 @PAT-12317 @regression
  Scenario: Account Overview Actions-report a claim should not show unless policy has been issued
    Given I have created a new "Auto" policy
    And I validate "Report a Claim" is not present in actions dropdown
    And I begin issuance
    Then I validate "Report a Claim" is not present in actions dropdown
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I finish issuing the policy
    Then the products status should be "INFORCE" or "ISSUED"
    And I validate "Report a Claim" is present in actions dropdown