@auto @party_validation
Feature: ability to add a party when I have began issuance and then go to the account summary page

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-8486 @TestCaseKey=PAT-T518 @post_deploy_candidate @regression
  Scenario: Able to add a party from add party link
    Given I have created a new "Auto" policy
    When I click on "Add a party" link on Thank you model after clicking on begin issuance
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details after navigating from Thank you modal
    Then I validate "Loss Payee" role details and "save and close" the modal
    And the new party with "organization name" and roles as "Loss Payee" should be displayed on the account overview page


