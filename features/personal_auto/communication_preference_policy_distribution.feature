@auto @account_management
Feature: Communication Preference

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5350 @PAT-11595 @regression
  Scenario: Auto - Communication Preference - Policy Distribution
    Given I have created a new "auto" policy
    And I fully issue the policy
    And I navigate to "Communication Preference" using the left nav
    Then I validate details on the policy distribution tab

  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @TestCaseKey=PAT-T5351 @PAT-7540 @regression
  Scenario: Communication Preference - Text notification
    Given I have created a new "auto" policy
    And I fully issue the policy
    And I navigate to "Communication Preference" using the left nav
    Then I validate details on the text notification tab

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5387 @PAT-11389 @regression
  Scenario: Auto - Communication Preference - E-signature
    Given I have created a new "auto" policy
    And I fully issue the policy
    And I navigate to "Communication Preference" using the left nav
    #Then I provide details on the e signature tab
    Then I should not see the e signature tab in Communication Preference tab