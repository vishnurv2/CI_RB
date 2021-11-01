@epic_c @story_c_1 @state_indiana @personal_auto @account_information @account_summary @wip
Feature: User view account summary and make adjustments to products

  @fixture_c_1_3_no_email @delete_when_done @TestCaseKey=PAT-T3699
  Scenario: Product grid do not issue button
    Given I have created a new "Auto" policy
    And I navigate to "Account Overview" using the left nav
    When I select do not issue for the auto product
    Then the product status should be "Do Not Issue"
    And the issue option should be available for the auto product
    When I select issue for the auto product
    Then the product status should be back to the original value

  @regression @fixture_auto_policy_none_combined_none @delete_when_done @TestCaseKey=PAT-T3700
  Scenario: Product grid delete button
    Given I have created a new "Auto" policy
    And I navigate to "Account Overview" using the left nav
    When I try to delete the auto product
    Then I should be prompted if I really want to delete the product
    When I answer no to deleting the product
    Then the product should not be removed from the product grid
    When I try to delete the auto product
    And I answer yes to deleting the product
    Then the product should be removed from the product grid

  @regression  @fixture_auto_policy_none_combined_none @delete_when_done @TestCaseKey=PAT-T3701
  Scenario: Product Status Changes Color With Validity Of Information
    Given I have started a new auto policy through the "auto" modal
    When I begin issuance
    Then The following left nav items should have red exclamation points
      | left_nav_item          |
      | Account Overview       |
      | IN - Auto              |
      | Issues To Resolve      |
    And the vehicle status color should be red
    And the product status color should be red
    And I navigate to "IN - Auto" using the left nav
    When I edit the first vehicle from the auto policy summary page with the file "2016_cadillac_escalade_full_vin_change"
    And I resolve the issues to resolve
    Then The following left nav items should have green check marks
      | left_nav_item          |
      | Account Overview       |
      | IN - Auto              |
    And the vehicle status color should not be red
    And the product status color should not be red

  @fixture_c_1_3_no_email_with_referral @delete_when_done @regression @TestCaseKey=PAT-T3702
  Scenario: Product status changes based on quote and issue progress
    Given I have created a new "Auto" policy
    And I view the account summary
    When I navigate to "Quote Options" using the left nav
    And  I navigate to "Account Overview" using the left nav
    Then the product status should be "Pending Approval"
    When I Approve all referrals
    And  I navigate to "Account Overview" using the left nav
    Then the product status should be "Quoted"
    When I begin issuance
    And  I navigate to "Account Overview" using the left nav
    Then the product status should be "Incomplete Issue"
