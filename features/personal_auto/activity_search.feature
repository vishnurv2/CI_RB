@search_activity @auto
Feature: Activity search

  @fixture_auto_policy_applicants_details_abc_email @TestCaseKey=PAT-T390
  Scenario: Activity search - search by notes and its description
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I log activity for "notes" by providing description as "testing purpose"
    Then I validate by searching "Note" and its description

  @fixture_auto_policy_applicants_details_abc_email @regression @TestCaseKey=PAT-T419 @lambda
  Scenario: Activity search - search by emails and its description
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I log activities for "emails" by providing description as "testing purpose"
    Then I validate by searching "Email" and its description

  @fixture_auto_policy_applicants_details_abc_email @regression @TestCaseKey=PAT-T420
  Scenario: Activity search - search by calls and its description
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I log activities for "calls" by providing description as "testing purpose"
    Then I validate by searching "Call" and its description

  @fixture_auto_policy_applicants_details_abc_email @regression @TestCaseKey=PAT-T421
  Scenario: Activity search - search by description
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I log activity for "notes" by providing description as "testing purpose"
    And I log activities for "emails" by providing description as "testing purpose"
    And I log activities for "calls" by providing description as "testing purpose"
   # And I log activities for "tasks" by providing description as "testing purpose"
    Then I validate by searching description in activity tab

  # task feature has been disabled from the application
  @fixture_auto_policy_applicants_details_abc_email @regression @TestCaseKey=PAT-T422 @wip
  Scenario: Activity search - search by tasks and its description
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I log activities for "tasks" by providing description as "testing purpose"
    Then I validate by searching "Task" and its description


  @fixture_auto_policy_applicants_details_abc_email @regression @PAT-11651 @TestCaseKey=PAT-T5824 @wip
  Scenario: Activity search - search using filters
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I log activity for "notes" by providing description as "account search" related to "account"
    And I log activities for "emails" by providing description as "account search" related to "account"
    And I log activities for "calls" by providing description as "account search" related to "account"
    And I log activities for "tasks" by providing description as "account search" related to "account"
    And I log activity for "notes" by providing description as "Product search" related to "product"
    And I log activities for "emails" by providing description as "Product search" related to "product"
    And I log activities for "calls" by providing description as "Product search" related to "product"
    And I log activities for "tasks" by providing description as "Product search" related to "product"
    Then I validate by searching description in activity tab using "account/product" filter with option "account level only"
    And I validate by searching description in activity tab using "account/product" filter with option "Quotes"
    And I validate by searching description in activity tab using "type" filter with option "notes"
    And I validate by searching description in activity tab using "type" filter with option "emails"
    And I validate by searching description in activity tab using "type" filter with option "calls"
    And I validate by searching description in activity tab using "type" filter with option "tasks"
