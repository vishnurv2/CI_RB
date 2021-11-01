@auto @party_validation @state_indiana @personal_auto @account_information @account_summary
Feature: User view account summary and make adjustments to applicants

  @delete_when_done @TestCaseKey=PAT-T90
  Scenario: Unable to delete last applicant from account
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I have loaded the fixture file named "account_summary_agency"
    When I navigate to "Account Overview" using the left nav
    Then I shouldn't be able to delete the only applicant on the account summary page

  @delete_when_done @TestCaseKey=PAT-T89
  Scenario: Add person applicant with a description address
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I have loaded the fixture file named "c_1_5"
    When I navigate to "Account Overview" using the left nav
    And I add another applicant from the account summary page
    Then the new applicant should be displayed in the general information

  @delete_when_done @TestCaseKey=PAT-T88 @regression
  Scenario: Remove an applicant on an existing account
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I have loaded the fixture file named "c_1_2_6"
    When I navigate to "Account Overview" using the left nav
    And I add another applicant from the account summary page
    When I try to delete the applicant I added
    Then I should see a prompt asking me if I'm sure I want to remove the applicant
    When I answer no to the remove applicant prompt
    Then the applicant should remain in the list
    When I answer yes to the remove applicant prompt
    Then the applicant should be removed
