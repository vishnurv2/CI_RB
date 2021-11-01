@multiple @party_validation
Feature: Umbrella - Party - Trust

  @fixture_umbrella_party_trust @delete_when_done @PAT-8034 @TestCaseKey=PAT-T485 @regression @umbrella
  Scenario:  Umbrella - Party - Trust First
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I validate "Trust" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Trust" should be displayed on the account overview page

  @fixture_umbrella_party_trust @delete_when_done @PAT-8034 @TestCaseKey=PAT-T486 @regression
  Scenario:  Umbrella - Policy Summary page - Party - trust
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    Then I navigate to my quote "IN - Umbrella" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I validate "Trust" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Trust" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-8034 @TestCaseKey=PAT-T528 @regression
  Scenario:  Umbrella - Party - Trust - Add another role and validate it
    Given I have created a new "Auto" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_party_trust"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I add another role "Loss Payee" for auto
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Loss Payee , Trust" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-8034 @TestCaseKey=PAT-T529 @regression
  Scenario:  Umbrella - Policy Summary page - Party - Trust - Add another role and validate it
    Given I have created a new "Auto" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_party_trust"
    And I begin issuance
    Then I navigate to my quote "IN - Auto Plus" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I add another role "Loss Payee" for auto
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Loss Payee , Trust" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-8034 @TestCaseKey=PAT-T530 @regression
  Scenario:  Umbrella - Party - Trust - Add another role and delete it
    Given I have created a new "Auto" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_party_trust"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I add another role "Loss Payee"
    And I delete the added role
    And the new party with "organization name" and roles as "Trust" should be displayed on the account overview page

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-8034 @TestCaseKey=PAT-T531 @regression
  Scenario:  Umbrella - Policy Summary page - Party - Trust - Add another role and delete it
    Given I have created a new "Auto" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_party_trust"
    And I begin issuance
    Then I navigate to my quote "IN - Auto Plus" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I add another role "Loss Payee" for auto
    And I delete the added role
    And the new party with "organization name" and roles as "Trust" should be displayed on the account overview page