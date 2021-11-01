@auto @party_validation
Feature: Add Party - Lessor - Do not issue status

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7345 @TestCaseKey=PAT-T426 @post_deploy_candidate @regression
  Scenario:  Add Party - Lessor - Do not issue status
    Given I have created a new "Auto" policy
    And I click on "Do not issue" from Actions dropdown
    And I select party type as "Business Entity" and role as "Lessor" and add new party details
    Then I validate that there are no vehicles to choose