@auto @policy_change @new_business
Feature: WT - Premium Snapshot

  @delete_when_done @TestCaseKey=PAT-T5486 @PAT-12162 @regression @wip
  Scenario: WT - Premium Snapshot in Policy Change View Updates
    Given I have created a new "Auto" policy using the auto_existing_driver_self fixture
    Then I verify premium snapshot labels for Quote
    And I begin issuance
    When I navigate to my quote "IN-Auto" using the left nav
    Then I verify premium snapshot labels for Application
    When I issue the policy fully
    And I navigate to policies "IN-Auto" using the left nav
    Then I verify premium snapshot labels for Inforce
    When I click on "Create Policy Change" from Actions dropdown
    And I add a policy change with "Specify Date"
    And I edit the auto applicant name
    And I Issue Policy Change
    And I navigate to policies "IN-Auto" using the left nav
    Then I verify premium snapshot labels for policy_change


