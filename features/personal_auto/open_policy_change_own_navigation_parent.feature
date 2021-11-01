@umbrella @policy_change
Feature: Move "Open Policy Change" from under Policies and make it it's own navigation parent

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @PAT-12163
  Scenario: Policy change validation for affiliate discount criteria
    Given I have created a new "umbrella" policy
    And I fully issue the umbrella policy
    And I save premium after issuing the policy completely from "In - Umbrella" page
    When I navigate to policies "In - Umbrella" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    And I verify the option Open Policy Change should present on left nav with its own navigation
    And I navigate to "Open Policy Changes" using the left nav
    Then I should see the Open Policy Changes page after navigation