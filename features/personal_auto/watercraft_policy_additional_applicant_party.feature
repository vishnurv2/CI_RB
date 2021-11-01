@watercraft @party_validation
Feature: Add additional applicant and party to a watercraft policy account

  @fixture_watercraft_policy_add_party @delete_when_done @TestCaseKey=PAT-T1696
  Scenario: Adding additional applicant in watercraft policy account
    Given I have created a new "watercraft" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Applicant" and add new party details
    Then I validate "Applicant" role details and "save and close" the modal

  @fixture_watercraft_policy_add_party @regression @delete_when_done @TestCaseKey=PAT-T1697
  Scenario: Adding additional party Loss Payee in watercraft policy account
    Given I have created a new "watercraft" policy
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Loss Payee" should be displayed on the account overview page
