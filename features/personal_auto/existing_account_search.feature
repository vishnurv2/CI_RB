@personal_auto @account_management @auto
Feature: Ability to search by account using top search bar

  @TestCaseKey=PAT-T215
  Scenario: I can pull up an existing account
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    Then I should be on the Account Summary page


