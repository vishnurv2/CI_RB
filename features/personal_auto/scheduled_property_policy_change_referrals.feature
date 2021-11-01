@scheduled_property @policy_change
Feature: Scheduled Property - Policy Change Referrals

  @fixture_scheduled_property_policy_issuance @delete_when_done @TestCaseKey=PAT-T1032 @PAT-4357 @regression
  Scenario:  Scheduled Property - Policy Change Referrals
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    When I navigate to policies "IN - Scheduled Property" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    And I edit scheduled classes and items
    And I should see the following referral messages on referrals page after policy change
      | One or more scheduled personal property items are valued over $100,000. Underwriter approval is required prior to binding. |