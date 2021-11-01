@umbrella @account_management
Feature: Underwriting Questions Page

  @fixture_umbrella_policy @delete_when_done @regression @PAT-4132 @TestCaseKey=PAT-T52
  Scenario: Underwriting Questions are Answered
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    Then The unflagged umbrella underwriting question answers should be their default values
    When I answer the umbrella underwriting questions "Yes" using umbrella_uw_questions fixture
#    And I navigate to "Issues to Resolve" using the left nav
    And I navigate to "Underwriting Questions" tab on quote management page
    Then The unflagged "umbrella" underwriting question answers should be "Yes"
    When I answer the umbrella underwriting questions "No"
#    And I navigate to "Issues to Resolve" using the left nav
    And I navigate to "Underwriting Questions" tab on quote management page
    Then The unflagged "umbrella" underwriting question answers should be "No"

  @fixture_umbrella_policy @delete_when_done @PAT-4132 @PAT-7548 @TestCaseKey=PAT-T278 @regression
  Scenario:  Umbrella - policy issuance without resolving under writing questions
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    When I resolve all issues except underwriting questions
    Then Issue button should not be enabled on "IN - Umbrella" page