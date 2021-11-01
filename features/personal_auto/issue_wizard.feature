@auto @account_management
Feature: Issue Wizard - Choose Policy Distribution Updates

  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @PAT-9950 @TestCaseKey=PAT-T5375 @regression
  Scenario: Issue Wizard - Choose Policy Distribution Updates
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I navigate till issue wizard policy distribution modal and validate it