@auto @party_validation
Feature: Add Party - Additional Interest - Auto-account summary page

  @fixture_auto_policy_party_loss_payee @delete_when_done @TestCaseKey=PAT-T489 @PAT-7340
  Scenario:  Auto - Account Summary Page - Party - Additional Interest
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Additional Interest" and add new party details
    Then I validate "Additional Interest" role details and "save and close" the modal for auto
    And the new party with "organization name" and roles as "Additional Interest" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @TestCaseKey=PAT-T569 @PAT-7340 @regression
  Scenario:  Auto - Account Summary Page - Party - Additional Interest - Add another role
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Additional Interest" and add new party details
    Then I add another role "Trust" for auto
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Additional Interest , Trust" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @TestCaseKey=PAT-T570 @PAT-7340 @regression
  Scenario:  Auto - Account Summary Page - Party - Additional Interest - Add another role and then delete that role
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Additional Interest" and add new party details
    Then I add another role "Trust" for auto
    Then I delete and validate the deleted party from applicant modal

