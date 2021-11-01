@auto @account_management
Feature: Account General Info

  @TestCaseKey=PAT-T83
  Scenario: Using an Existing Account Open the Account General Info Modal
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    When I open the account general info modal
    Then The "Account General Info" modal should be visible
    Then I close the "Account General Info" modal

  @TestCaseKey=PAT-T84 @known_issue
  Scenario: Using an Existing Account Modify the Account General Info
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    And I modify the account general info
    Then I should see the new account general info

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T82
  Scenario: Existing account displays agency and agency contact
    Given I have created a new "auto" policy
    And I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "account_summary_agency"
    Then the expected agency and agency contact should be visible in General Information
