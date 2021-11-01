@auto
Feature: Policy Summary Page

  @TestCaseKey=PAT-T265
  Scenario: The Last Account Applicant Cannot Be Deleted
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I shouldn't be able to delete the only applicant on the auto policy summary page
