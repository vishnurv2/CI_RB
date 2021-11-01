@party_validation @auto
Feature: Party - Validations/UW Referrals

  @fixture_auto_policy_party_loss_payee @delete_when_done @regression @PAT-8024 @TestCaseKey=PAT-T506
  Scenario:  Party - Validations - UW Referrals
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_party_loss_payee"
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I select all the products and "save and close" the modal
    And I select party type as "Business Entity" and role as "LLC" and add new party details
    Then I select all the products and "save and close" the modal
    And I should not see any issues on issues to resolve page
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      | Trust to have at least one trustee.  |
      | LLC to have at least one LLC Member. |
    And I should see the following referral messages on referrals page
      |LLC and Trust present, Underwriter approval required.|

