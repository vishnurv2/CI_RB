@umbrella @account_management
Feature: Documents - retain in agency

  @fixture_umbrella_policy @delete_when_done @PAT-4129 @regression @TestCaseKey=PAT-T38
  Scenario: Umbrella - validate documents under Forward To central section
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I begin issuance
    And I navigate to "Documents" using the left nav
    When I click "view" button of "Application" document
    Then I validate for a new tab