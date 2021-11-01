@auto @party_validation
Feature: Auto - Party - Trust

  @fixture_auto_party_trust_only_required @PAT-7344 @delete_when_done @regression @TestCaseKey=PAT-T468
  Scenario: Validating trust - present on account overview page
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I validate "Trust" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Trust" should be displayed on the account overview page

  @fixture_auto_party_trust_only_required @PAT-7344 @delete_when_done @regression @TestCaseKey=PAT-T468
  Scenario: Validating trust - two roles are added
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    #Then I validate "Trust" role details and "save and close" the modal
    #And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I add another role "Loss Payee"
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Loss Payee , Trust" should be displayed on the account overview page

  @fixture_auto_party_trust_only_required @PAT-7344 @delete_when_done @regression @TestCaseKey=PAT-T619
  Scenario: Validating deleted trust should not be present on account overview page
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I validate "Trust" role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I add another role "Loss Payee"
    And I save and close the "add applicant" modal
    And the new party with "organization name" and roles as "Loss Payee , Trust" should be displayed on the account overview page
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I add another role "Loss Payee"
    Then I delete and validate the deleted party from applicant modal
    And the new party with "organization name" and roles as "Loss Payee , Trust" should not be displayed on the account overview page