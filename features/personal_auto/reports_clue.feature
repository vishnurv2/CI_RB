@auto @reports_validation
Feature: Features Dependent on CLUE Reports

#  currently we are getting as "no policy losses" and "no unassigned driver losses" in Reports result modal
  @delete_when_done @fixture_auto_policy_autoplus_combined_none_clue_prefill @regression @TestCaseKey=PAT-T264 @known_issue
  Scenario: CLUE reports can be disputed
    Given I have created a new "Auto" policy
    And I navigate to "Reports" using the left nav
    When I order the "CLUE" report
    Then the Auto CLUE report should contain the expected data
    When I dispute the first policy loss in the clue report
    Then I should see UI allowing me to choose a reason to dispute the loss


  ### Tests below have not been verified ####
    ## somehow this doesnt click the checkbox , its not found ddl 9-25
  # Resolve issues to resolve!!
  @fixture_policy_losses @delete_when_done @known_issue @wip @TestCaseKey=PAT-T3339
  Scenario: CLUE Report Results From Policy Losses can be Disputed
    Given I have started a new auto policy through the "auto vehicle coverages" modal
    When I navigate to "Reports" using the left nav
    And I order the "Clue" report
    And I dispute the current report
    Then I can view the disputed CLUE report

  @fixture_unassigned_loss @delete_when_done @wip @TestCaseKey=PAT-T3340
  Scenario: CLUE Report Drivers can be Assigned
    Given I have started a new auto policy through the "auto driver" modal
    When I navigate to "Reports" using the left nav
    And I order the "Clue" report
    And I assign drivers to all unassigned losses in the current report
    Then I can view the Auto CLUE report driver assignment

  @delete_when_done @fixture_report_results_auto_general_info_modal_manual_losses @wip @TestCaseKey=PAT-T3341
  Scenario: Manual Losses Added at Auto General Info Modal Appear and Can Be Deleted
    Given I have created a new "Auto" policy
    And I navigate to "Reports" using the left nav
    When I order the "Clue" report
    Then the report should contain the manually added losses
    When I delete the fixture's first manually added loss
    Then I should not see the deleted manually added loss
