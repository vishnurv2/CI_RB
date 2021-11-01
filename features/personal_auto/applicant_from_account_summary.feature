@auto @party_validation
Feature: ability to add a party with the role of an applicant

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7341 @TestCaseKey=PAT-T405 @regression
  Scenario: Check Add applicant option - not present in parties modal
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I click on plus on party model "Add Party" and "Link Accounts" should present there
    But I checked Add Applicants should not be present

  @fixture_auto_policy_party_applicant_only_required @PAT-7341 @TestCaseKey=PAT-T550 @delete_when_done @regression
  Scenario: Create an Applicant - fill only required details in new party model
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Applicant" and add new party details
    Then I validate "Applicant" role details and "save and close" the modal

  @fixture_auto_policy_party_applicant_only_required @PAT-7341 @TestCaseKey=PAT-T551 @regression @delete_when_done
  Scenario: Click save and add another applicant from new party modal will create a new applicant
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Applicant" and add new party details
    Then I validate "Applicant" role details and "save and close" the modal
    And I select party type as "Individual" and role as "Applicant" and add new party details
    Then I validate "Applicant" role details and "save and add another party" the modal
    And I select party type as "Individual" and role as "Applicant" and add new party details after navigating from Thank you modal
    Then I validate "Applicant" role details and "save and close" the modal