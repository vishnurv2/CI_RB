@homeowners @account_management
Feature: Homeowners - Optional coverage - Personal Cyber Protection

  @fixture_home_optional_coverage_personal_cyber_protection_3_special @delete_when_done @regression @PAT-4180 @TestCaseKey=PAT-T29
  Scenario:  Homeowners - Optional coverage - Personal Cyber Protection
    Given I have started a new home policy through the "auto policy coverages" modal
    And I check the premium displayed
    And I open the policy level optional coverages
    When I have populated the auto policy optional coverages modal
    And I save and close the "auto policy optional coverages" modal
    Then the old premium should differ from the new premium
    And I click on modify property information modal
    And I provide details and save and close property information modal using "personal_cyber_protection_5g_signature" fixture
    Then I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "personal_cyber_protection_5g_signature" fixture
    And I open the policy level optional coverages
    And I populate auto policy optional coverages modal and save and close using "auto_policy_optional_coverages_1" fixture
    And I check the premium displayed
    Then I open the policy level optional coverages
    And I populate auto policy optional coverages modal and save and close using "personal_cyber_protection_5g_signature" fixture
    Then the old premium should differ from the new premium