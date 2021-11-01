@homeowners @new_business @party_validation
Feature: Homeowners - Party - Loss Payee

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T464 @regression
  Scenario:  Homeowners - Party - Loss Payee
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Loss Payee" should be displayed on the account overview page

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T507 @regression
  Scenario:  Homeowners - Party - Loss Payee - Add another role and validate it
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Additional Insured"
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Additional insured , Loss Payee" should be displayed on the account overview page

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T3625
  Scenario:  Homeowners - Party - Loss Payee - Add another role and delete it
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Additional Insured"
    And I delete the added role
    And the new party with "organization name" and roles as "Loss Payee" should be displayed on the account overview page

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T465 @regression
  Scenario:  Homeowners - Policy Summary page - Party - Loss Payee
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to my quote "IN - Homeowners" using the left nav
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Loss Payee" should be displayed on the account overview page

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T508 @regression
  Scenario:  Homeowners - Policy Summary page - Party - Loss Payee - Add another role and validate it
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to my quote "IN - Homeowners" using the left nav
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Additional Insured"
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Additional insured , Loss Payee" should be displayed on the account overview page

  @fixture_home_party_loss_payee @delete_when_done @PAT-7951 @TestCaseKey=PAT-T3626
  Scenario:  Homeowners  - Policy Summary page - Party - Loss Payee - Add another role and delete it
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I navigate to my quote "IN - Homeowners" using the left nav
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Additional Insured"
    And I delete the added role
    And the new party with "organization name" and roles as "Loss Payee" should be displayed on the account overview page
