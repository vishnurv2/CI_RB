@auto @account_management
Feature: Add applicants modal

  @TestCaseKey=PAT-T65
  Scenario: Trigger validation errors while adding an applicant
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I navigate to "Account Overview" using the left nav
    When I add a blank applicant
    Then I should see the following errors on the page
      | First Name is required.          |
      | Last Name is required.           |
      | Date Of Birth is required.       |
      | Street is required.              |
      | City is required.                |
      | State is required.               |
      | Zip is required.                 |

  @TestCaseKey=PAT-T68
  Scenario: Account Applicant Modal Populates With Applicant Data
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then the expected applicant data should appear in the modal from the "Account Summary" page

  @fixture_auto_policy_none_combined_none @TestCaseKey=PAT-T67
  Scenario: Account Applicant Data Changes After Save
    Given I have created a new "auto" policy
    When I edit the first applicant
    Then the applicant should have changed from the "Account Summary" page

  @fixture_auto_policy_none_combined_none @delete_when_done @TestCaseKey=PAT-T69
  Scenario: Add an applicant to an existing account
    Given I have created a new "auto" policy
    And I have loaded the fixture file named "c_1_2_5"
    When I navigate to "Account Overview" using the left nav
    And I add another applicant from the account summary page
    Then the new applicant should be displayed in the general information

  @TestCaseKey=PAT-T70
  Scenario: Account Applicant Modal View More Button for Person Applicants
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I have loaded the fixture file named "c_1_5"
    When I navigate to "Account Overview" using the left nav
    And I've started adding an applicant that is a Person
    When I select view more on the applicant panel
    Then I should see additional applicant fields
    When I select view less on the applicant panel
    Then I should not see additional applicant fields

  @fixture_auto_policy_none_combined_none @delete_when_done @TestCaseKey=PAT-T10
  Scenario: Edit an applicant to an existing account
    Given I have created a new "auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "c_1_2_1"
    And I add another applicant from the account summary page
    When I edit the last applicant
    Then the applicant data should be updated in the applicant grid

  @TestCaseKey=PAT-T66
  Scenario: Account summary - add applicant modal
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    Then I click on the name of the account applicant
    And I validate that add applicant modal is getting displayed