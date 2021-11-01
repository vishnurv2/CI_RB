@dwelling @reports_validation
Feature: Reports - Summary Section - Renewal Inspections

  @fixture_dwelling_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T5386 @wip
  Scenario: Renewal inspections panel verification
    Given I have created a new "dwelling" policy
    And I fully issue the dwelling policy
    Then I navigate to "Reports" using the left nav
    And I click on Show order history link on reports page
    Then I should see history record fields headers
    And I click on Show order history link on reports page