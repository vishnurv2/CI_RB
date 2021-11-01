@auto @account_management
Feature: Save Quote - Save Quote Action Item

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5592 @PAT-11408 @regression
  Scenario: Save Quote from product summary page
    Given I have created a new "Auto" policy
    And I click on "Save Quote" from Actions dropdown
    Then I validate by searching "Quote Saved" in activity tab

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5643 @PAT-11408 @regression
  Scenario: Save Quote from quote management page
    Given I have created a new "Auto" policy
    And I navigate to my quote "Quote Management" using the left nav
    Then I click on "Save Quote" from quote management page
    And I validate by searching "Quote Saved" in activity tab

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5593 @PAT-11409 @regression
  Scenario: Save Quote - Action Log Entry and Filter
    Given I have created a new "Auto" policy
    And I click on "Save Quote" from Actions dropdown
    Then I validate by searching "Quote Saved" in activity tab
    And I validate a new tab opens on clicking view quote