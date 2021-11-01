@auto @vehicle @party_validation
Feature: Auto - Party - Loss Payee

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7346 @TestCaseKey=PAT-T463 @regression
  Scenario:  Auto - Party - Loss Payee
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Loss Payee" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7346 @TestCaseKey=PAT-T509 @regression
  Scenario:  Auto - Policy Summary page - Party - Loss Payee
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to my quote "IN - Auto Plus" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Loss Payee" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7346 @TestCaseKey=PAT-T510 @regression @bug-PAT-11399
  Scenario:  Auto - Party - Loss Payee - validation of mandatory fields
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details only one required left
    Then I save and close the "add applicant" modal
    And I should see the following errors on the page
      | Organization Name is required. |
      #| Street is required.            |
      #| City is required.              |
      #| State is required.             |
      #| Zip is required.               |

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7346 @TestCaseKey=PAT-T511 @regression
  Scenario:  Auto - Policy Summary page - Party - Loss Payee - validation of mandatory fields
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to my quote "IN - Auto Plus" using the left nav
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details only one required left
    Then I save and close the "add applicant" modal
    And I should see the following errors on the page
      | Organization Name is required. |
      #| Street is required.            |
      #| City is required.              |
      #| State is required.             |
      #| Zip is required.               |

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7346 @TestCaseKey=PAT-T512 @regression
  Scenario:  Auto - Party - Loss Payee - validate that already selected product is disabled
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal for auto
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate that the product is disabled which was already selected

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7346 @TestCaseKey=PAT-T513 @regression
  Scenario:  Auto - Policy Summary page - Party - Loss Payee - validate that already selected product is disabled
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to my quote "IN - Auto Plus" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal for auto
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate that the product is disabled which was already selected

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7346 @TestCaseKey=PAT-T514 @regression @lambda
  Scenario:  Auto - Party - Loss Payee - Add another role and validate it
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Trust"
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Loss Payee , Trust" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7346 @TestCaseKey=PAT-T515 @regression
  Scenario:  Auto - Policy Summary page - Party - Loss Payee - Add another role and validate it
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to my quote "IN - Auto Plus" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Trust"
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Loss Payee , Trust" should be displayed on the account overview page