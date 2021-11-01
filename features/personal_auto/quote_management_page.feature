@auto @account_management
Feature: Quote Management page

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T11
  Scenario: Validation of product status after navigating to quote management page
    Given I have created a new "auto" policy
    And I open and save the coverages
    When I navigate to "Account Overview" using the left nav
    Then the product status should be "Incomplete Quote"
    And I navigate to "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to "Account Overview" using the left nav
    Then the product status should be "Quoted"

  @delete_when_done @fixture_quote_management @PAT-7436 @TestCaseKey=PAT-T128 @regression
  Scenario: Quote management page - validate coverages
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I navigate to "Quote Management" using the left nav
    And I validate the following coverages
    | Liability            |
    | Other Than Collision |
    | Collision            |