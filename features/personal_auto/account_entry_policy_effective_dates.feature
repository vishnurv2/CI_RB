@auto @account_management @fixture_account_entry_spike @TestCaseKey=PAT-T78
Feature: Account logging Policy effective Dates

  Background:
    Given I have logged in
    And I add a product from the left nav
    Then The "Add Product" modal should be visible
    When I select a the personal product "automobile"

  Scenario: Setting the policy effective date sets the policy expiration date in ci run
    And I set the all products state to "Indiana"
    And I set the policy effective date to "today"
    Then the policy expiration date is set to one year from the effective date
    And the policy expiration date is not editable
