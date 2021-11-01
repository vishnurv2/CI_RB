@auto @new_business
Feature: WT - Begin Application - Applicant E-mail should have red asterisk

  @delete_when_done @fixture_c_1_3_no_email @TestCaseKey=PAT-T5487 @PAT-11787 @regression
  Scenario: WT - Begin Application - Applicant E-mail should have red asterisk
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I should see an issue to resolve containing "Email is required"