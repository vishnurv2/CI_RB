@watercraft @party_validation
Feature: WT - Watercraft - Add Driver - No Business Parties

  @fixture_watercraft_policy_add_party @regression @delete_when_done @TestCaseKey=PAT-T5418 @PAT-12269
  Scenario: WT - Watercraft - Add Driver - No Business Parties
    Given I have created a new "watercraft" policy
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And I click on add watercraft driver
    Then I validate select existing party dropdown on watercraft drivers modal