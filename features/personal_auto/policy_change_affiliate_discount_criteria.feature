@umbrella @policy_change
Feature: Policy change for affiliate discount criteria

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T5642 @PAT-11310
  Scenario: Policy change validation for affiliate discount criteria
    Given I have created a new "umbrella" policy
    And I fully issue the umbrella policy
    And I save premium after issuing the policy completely from "In - Umbrella" page
    When I navigate to policies "In - Umbrella" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I update the Affiliate Discount in general info modal from No to "Central-appointed insurance agency owner or employee affiliate group"
    Then I should see the following issue messages on alerts side bar
      | Affiliate discount requires EFT (or annual pay)|
      |Affiliate discount requires E-Policy (Terms and Conditions must be accepted)|
      |Affiliate discount requires E-billing (or is Mortgagee billed) |