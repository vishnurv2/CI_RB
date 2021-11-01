@auto @policy_change @new_business @policy_issuance @indiana_auto @personal_auto
Feature: Account Summary Policy Change

  # Claims is not ready
  @PAT-3101 @fixture_account_summary_policy_changes_3 @wip
  Scenario: An Auto Policy is viewable in Report a Claim dropdown in Claims Summary
    Given I have an existing account
    And I click the "Policies" tab
    And The auto policy matches whats in the products table

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @TestCaseKey=PAT-T92 @post_deploy_candidate @regression
  Scenario: Account Summary Policy Change Quote Options
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I save premium after issuing the policy completely from "In - Auto" page
    When I select Create Policy Change for the auto product
    Then I add a policy change with "Specify Date"
    When I edit the first vehicle from the auto policy summary page with the file "2010_honda_accord_partial_vin_non_agreed"
    Then I click on policy change link
    Then I verify and submit the changes on quote management page

  @fixture_auto_policy_none_combined_none_adjusted @regression @delete_when_done @TestCaseKey=PAT-T91
  Scenario: Account Summary Policy Change Premium Difference - Summary of Changes
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I save premium after issuing the policy completely from "In - Auto" page
    When I select Create Policy Change for the auto product
    Then I add a policy change with "Specify Date"
    When I edit the first vehicle from the auto policy summary page with the file "2010_honda_accord_partial_vin_non_agreed"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should differ from the new premium
    And the summary of changes premium should equal total premium

  @fixture_auto_policy_none_combined_none_adjusted @regression @delete_when_done @TestCaseKey=PAT-T93
  Scenario: Account Summary Policy Change Name Change
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I save premium after issuing the policy completely from "In - Auto" page
    When I select Create Policy Change for the auto product
    Then I add a policy change with "Specify Date"
    When I edit the auto applicant name
    When I navigate to policies "Open Policy Changes" using the left nav
    Then the initial premium should not differ from the new premium
