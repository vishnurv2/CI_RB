@auto @account_management
Feature: Domestic abuse flag

  @PAT-9620 @TestCaseKey=PAT-T5803 @regression
  Scenario: Add domestic abuse flag
    Given I have created a new "auto" policy using the auto_policy_none_combined_none fixture
    When I navigate to "Account Overview" using the left nav
    And I click on "Flag for domestic abuse" from Actions dropdown
    And I fill the data in "add domestic abuse flag" modal with account_domestic_abuse fixture file and "add" flag using "sample_pdf_1"


  @PAT-9621 @TestCaseKey=PAT-T5804 @regression
  Scenario: Remove domestic abuse flag
    Given I have created a new "auto" policy using the auto_policy_none_combined_none fixture
    And I navigate to "Account Overview" using the left nav
    And I click on "Flag for domestic abuse" from Actions dropdown
    And I fill the data in "add domestic abuse flag" modal with account_domestic_abuse fixture file and "add" flag using "sample_pdf_1"
    When I click on "Remove Domestic Abuse Flag" from Actions dropdown
    Then I fill the data in "remove domestic abuse flag" modal with account_remove_domestic_abuse fixture file and "remove" flag using "sample_pdf_1"







