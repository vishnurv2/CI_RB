@auto @account_management
Feature: WT - Notification Toast for Premium Change

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5383 @PAT-11775 @regression
  Scenario: WT - Notification Toast for Premium Change
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I order CLUE and MVR reports
    And I validate premium change modal notification toast
    Then I navigate to "IN - Auto" using the left nav
    And I provide affiliate discount on general information modal
    Then I validate premium change modal notification toast for affiliate discount