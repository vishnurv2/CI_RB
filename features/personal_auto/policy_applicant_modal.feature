@auto @account_management
Feature: Add policy applicants modal

  @TestCaseKey=PAT-T242
  Scenario: Trigger validation errors while adding an policy applicant
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add a blank auto applicant
    Then I should see the following errors on the page
      | First Name is required.    |
      | Last Name is required.     |
      | Date Of Birth is required. |
      | Street is required.        |
      | City is required.          |
      | State is required.         |
      | Zip is required.           |

  @TestCaseKey=PAT-T245
  Scenario: Auto Applicant Modal Populates With Applicant Data
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then the expected applicant data should appear in the modal from the "Auto Policy Summary" page

  @fixture_auto_policy_none_combined_none @TestCaseKey=PAT-T2114
  Scenario: Edit Auto Applicant Modal Populates With Applicant Data
    Given I have created a new "auto" policy
    And I have loaded the fixture file named "c_1_2_5"
    When I edit the first applicant from the "Auto Policy Summary" page
    Then the applicant should have changed from the "Auto Policy Summary" page

  @TestCaseKey=PAT-T244
  Scenario: Add an applicant to an existing auto policy
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I have loaded the fixture file named "c_1_2_7"
    When I add another auto applicant
    Then the new applicant should be displayed in the general information from the "Auto Policy Summary" page

  @TestCaseKey=PAT-T243
  Scenario: Personal auto summary - add applicant modal
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I click on name of the policy applicant
    And I validate that add applicant modal is getting displayed