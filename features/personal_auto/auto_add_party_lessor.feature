@auto @party_validation @new_business
Feature: Auto - Party - Lessor

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7345 @TestCaseKey=PAT-T425 @regression
  Scenario:  Auto - Account Summary Page - Party - Lessor
    Given I have created a new "Auto" policy
    And I add a vehicle from the fixture file "camper"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Lessor" and add new party details
    Then I validate "Lessor" role details and "save and add another party" the modal
    And I close the add party modal and return to account summary page
    Then I select party type as "Business Entity" and role as "Lessor" and add new party details
    Then I try to choose the vehicle under role applies to and validate hover over message





