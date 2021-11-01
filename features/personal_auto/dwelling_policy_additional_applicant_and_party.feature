@dwelling @party_validation
Feature: Add additional applicant and party to a dwelling policy account

  @fixture_dwelling_policy_add_party @regression @delete_when_done @TestCaseKey=PAT-T1691
  Scenario: Adding additional applicant in dwelling policy account
    Given I have created a new "dwelling" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Applicant" and add new party details
    Then I validate "Applicant" role details and "save and close" the modal

  @fixture_dwelling_policy_add_party @delete_when_done @TestCaseKey=PAT-T1692 @post_deploy_candidate @regression
  Scenario: Adding additional party Loss Payee in dwelling policy account
    Given I have created a new "dwelling" policy
    And I select party type as "Business Entity" and role as "Additional Insured" and add new party details
    Then I validate "Additional Insured" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Additional insured" should be displayed on the account overview page
