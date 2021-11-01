@account_management
Feature: Log new personal account modal

  Background:
    Given I have logged in
    And I log new personal account

  @fixture_b_1_1 @TestCaseKey=PAT-T241
  Scenario: Validation of mandatory fields
    When I save and close new personal account modal
    Then I should see the following errors on the page
      | Agency is required.              |
      | Agency Contact is required.      |
      | First Name is required.          |
      | Last Name is required.           |
      | Date Of Birth is required.       |
      | Street is required.              |
      | City is required.                |
      | State is required.               |
      | Zip is required.                 |


  @fixture_b_1_1 @TestCaseKey=PAT-T239
  Scenario: Validation of error message on trying to add another applicant without completing first applicant
    When I click on add another applicant
    Then I should see error message "Please fill the first applicant details first." in the toast alert

  @fixture_b_1_1 @delete_when_done @TestCaseKey=PAT-T240
  Scenario: Add first applicant details
    When I enter an agency name
    And I add first applicant using the first_applicant_details fixture
    And I save and close new personal account modal
    Then I print my new account ID

  @fixture_b_1_1 @TestCaseKey=PAT-T5568 @PAT-11763 @regression
  Scenario: WT - Log New Personal Account- Disable Primary Address - New Address for first applicant
    Then I validate primary new address dropdown is disabled
