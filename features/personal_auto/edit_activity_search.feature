@search_activity @auto
Feature: Edit Activity search

  @fixture_auto_policy_applicants_details_abc_email @TestCaseKey=PAT-T339
  Scenario: Activity search - Add the notes and check its description should be editable
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I log activity for "notes" by providing description as "testing purpose"
    Then I validate by searching "Note" and its description
    And I edit "Note" activity and select the Priority Restrictive checkbox
    And I edit again and check all the greyed options should be present
    Then I validate by searching "Note" and its description

  @fixture_auto_policy_applicants_details_abc_email @TestCaseKey=PAT-T340
  Scenario: Activity search - Add the email and check its description should be editable
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I log activities for "emails" by providing description as "testing purpose"
    Then I validate by searching "Email" and its description
    And I click on the "activity" tab
    And I edit "Email" activity and verified the gray area
    Then I validate by searching "Email" and its description

  @fixture_auto_policy_applicants_details_abc_email @TestCaseKey=PAT-T341
  Scenario: Activity search - Attaching files from logged Activity
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I log activity for "notes" by providing description as "testing purpose" and click on the attach file
    When I upload the "sample_pdf_1" as an other document for activity
    Then I validate by searching "Note" and its description