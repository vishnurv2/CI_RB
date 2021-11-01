@auto @account_management
Feature: Warning message -leaving page - switching between accounts with open docked composer

  @delete_when_done @PAT-12457 @regression @TestCaseKey=PAT-T5785
  Scenario: Warning message about leaving page - activities - note, email, call and meeting
    Given I have created a new "Auto" policy using the auto_existing_driver_self fixture
    And I select "no" activity from activity modal
    And I verify account change warning message for "activity"
    And I select "note" activity from activity modal
    And I verify account change warning message for "note"
    And I select "email" activity from activity modal
    And I verify account change warning message for "email"
    And I select "call" activity from activity modal
    And I verify account change warning message for "call"
    And I select "meeting" activity from activity modal
    And I verify account change warning message for "meeting"


