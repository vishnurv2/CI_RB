@auto @account_management
Feature: CMI Employees Summary Page

  @fixture_z_1 @delete_when_done @regression @TestCaseKey=PAT-T157
  Scenario: Referrals Can be Viewed
    Given I have created a new "Auto" policy
    And I add 1 random drivers from the auto summary page
    When I navigate to "Quote Management" using the left nav
    And I navigate to "Referrals" using the left nav
    Then I can view the referral

  @regression @fixture_auto_policy_autoplus_combined_none @delete_when_done @TestCaseKey=PAT-T155
  Scenario: Policy Issuance shows all products and vehicle override panels appear
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I add an additional Indiana "automobile" product using the fixture file "auto_policy_sig_split_uninsured"
    And I navigate to "Quote Management" using the left nav
    When I navigate to "Overrides" using the left nav
    Then I should see 2 override panels
    #And each override panel should include 1 vehicle override panel

  @fixture_auto_policy_autoplus_combined_tier @delete_when_done @TestCaseKey=PAT-T158 @post_deploy_candidate @regression
  Scenario Outline: Vehicle Tier Overrides Save
    Given I have created a new "Auto" policy
    And I add an additional Indiana "automobile" product using the fixture file "auto_policy_sig_split_uninsured_tier"
    And I begin issuance
    When I navigate to "Overrides" using the left nav
    And I apply a <override_type> override on vehicle 1 in panel 1
    Then I should see the <override_type> override that I applied on vehicle 1 in panel 1
    And I apply a <override_type> override on vehicle 1 in panel 2
    Then I should see the <override_type> override that I applied on vehicle 1 in panel 2
    Examples:
      | override_type |
      | Tier          |

  @regression @fixture_auto_policy_territory_override @delete_when_done @TestCaseKey=PAT-T156
  Scenario: Vehicle Territory Overrides Save
    Given I am on the CMI employees page for a new auto policy
    And I begin issuance
    Then I should see a "Territory" in override panel 1
    When I apply a Territory override on vehicle 1 in panel 1
    Then the "Territory" override in panel 1 should show as applied

  ### below not complete ####
  # 5/15 Package Discount not available yet
  @regression @fixture_auto_policy_effective_tomorrow_override_effective_yesterday @delete_when_done @wip @TestCaseKey=PAT-T3688
  Scenario: Vehicle Override Date Before Effective Date Validation Message Appears
    Given I am on the CMI employees page for a new auto policy
    When I apply the "Package Discount" override in panel 1
    Then I should see the override invalid date validation message
