@watercraft @account_management
Feature: Watercraft optional coverages

  @fixture_watercraft_policy @delete_when_done @PAT-4288 @TestCaseKey=PAT-T20
  Scenario:  Watercraft - general information modal - stand alone watercraft
    Given I have started a new watercraft policy up to the "auto_general_info" modal
    Then I validate the question attach policy and its default option selected as "No"
    And I save and continue till "Watercraft Operator" modal
    When I add an additional Indiana "watercraft" product up to "auto_general_info_modal" using the fixture file "watercraft_policy"
    Then I validate the question attach policy and its default option selected as "No"
    And I close the "auto_general_info" modal
    When I click modify General Information of Watercraft
    Then I validate the question attach policy and its default option selected as "No"
