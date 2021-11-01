@auto @policy_change
Feature:  Policy change - version of the product when choose a filter view

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @regression @TestCaseKey=PAT-T601 @PAT-8426
  Scenario: Filter view validation after policy change
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I refresh the page
    When I navigate to policies "In-Auto" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    And I validate in filter view "POLICY CHANGE" and "INFORCE" or "ISSUED" should be present

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @regression @PAT-8426 @TestCaseKey=PAT-T3561 @known_issue
  Scenario:  Filter view and status validation after policy change
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I refresh the page
    When I navigate to policies "In-Auto" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first vehicle from the auto policy summary page with the file "2010_honda_accord_partial_vin_non_agreed"
    And I validate in filter view "POLICY CHANGE" and "INFORCE" or "ISSUED" should be present
    When I navigate to policies "Open Policy Changes" using the left nav
    And I begin issuance on policy change
    And I click on Create Policy Change from Account Overview
    Then I add a policy change with "Specify Date"
    Then I navigate to "Account Overview" using the left nav
    And I validate the status should be "CHANGE PENDING" for policy change
    #When I navigate to policies "In-Auto" using the left nav
    #And I validate in filter view data



