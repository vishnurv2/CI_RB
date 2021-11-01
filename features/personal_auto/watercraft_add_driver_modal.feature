@watercraft @new_business
Feature: Watercraft - Add Driver Modal - require license state and license number at issuance

  @fixture_watercraft_policy_driver_modal @delete_when_done @PAT-9799 @TestCaseKey=PAT-T935
  Scenario:  Watercraft - Add Driver Modal - require license state and license number at issuance
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      | Driver license number is required |
      | Driver license State is required  |
