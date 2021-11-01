@homeowners @new_business @party_validation
Feature: Homeowners - Party - Mortgagee

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T466 @post_deploy_candidate @regression
  Scenario:  Homeowners - Party - Mortgagee - Account Summary Page
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Mortgagee" and add new party details
    Then I validate "Mortgagee" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Mortgagee" should be displayed on the account overview page

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T653 @regression
  Scenario:  Homeowners - Add Party - Mortgagee- Account Summary Page - Add Another Role
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Mortgagee" and add new party details
    Then I add another role "Trust"
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Mortgagee , Trust" should be displayed on the account overview page

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T654 @regression
  Scenario:  Homeowners - Add Party - Mortgagee - Account Summary Page - Add Another Role and then delete that role
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Mortgagee" and add new party details
    Then I add another role "Trust"
    Then I delete and validate the deleted party from applicant modal

