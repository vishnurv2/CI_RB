@policy_change @auto
Feature: WT - Product Summary - Actions - Edit Policy Change

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @PAT-11987 @TestCaseKey=PAT-T5821 @regression
  Scenario: WT - Product Summary - Actions - Edit Policy Change
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I finish issuing the policy
    And I add a policy change and specify the effective date
    And I refresh the page
    And I click on "Edit Policy Change" from Actions dropdown
    Then I edit policy change