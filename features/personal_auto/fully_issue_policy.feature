@account_management @auto
Feature: Policy Issuance

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T217 @ci
  Scenario: Fully Issuing a Policy
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I finish issuing the policy
    Then the products status should be "INFORCE" or "ISSUED"

  # The bell icon is removed.
  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @PAT-7431 @known_issue @TestCaseKey=PAT-T3637
  Scenario: Validate the bell icon before and after resolving all issues
    Given I have created a new "Auto" policy
    And I begin issuance
    Then The red dot should be present on bell icon
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    And I refresh the page
    Then The red dot should not be present on bell icon

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @regression @TestCaseKey=PAT-T3638
  Scenario: Fully Issuing a Policy using blue streak seal
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals using blue streak seal
    When I finish issuing the policy
    Then the products status should be "INFORCE" or "ISSUED"