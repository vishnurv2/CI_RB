@multiple @policy_change
Feature: Product Summary Actions - Edit Policy becomes Create Policy Change with function

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @TestCaseKey=PAT-T572 @PAT-8528 @post_deploy_candidate @regression
  Scenario: Create Policy change - Policy change modal is present in Auto policy actions dropdown
    Given I have created a new "Auto" policy
    Given I add an additional Indiana "residential" product after fully issue till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I fully issue the multiple policies
    When I navigate to policies "In-Auto" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I validate policy change modal appears

    # this needs to change on reports page
  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @regression @PAT-8528 @TestCaseKey=PAT-T3562
  Scenario: Create Policy change - Policy change modal is present in Homeowners policy actions dropdown
    Given I have created a new "Auto" policy
    Given I add an additional Indiana "residential" product after fully issue till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I fully issue the multiple policies
    Then I resolve any underwriter referrals using blue streak seal or approvals
    When I navigate to policies "In-Homeowners" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I validate policy change modal appears

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @regression @PAT-8528 @TestCaseKey=PAT-T3563
  Scenario: Create Policy change - option is disabled one already active un-submitted policy
    Given I have created a new "Auto" policy
    Given I add an additional Indiana "residential" product after fully issue till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I fully issue the multiple policies
    When I navigate to policies "In-Auto" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first vehicle from the auto policy summary page with the file "2010_honda_accord_partial_vin_non_agreed"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then I navigate to "Account Overview" using the left nav
    And I validate Create Policy Change is disabled for already active policy



