Feature: WT - Attached SPP & Watercraft - UW Q's

  @fixture_home_party_loss_payee @delete_when_done @TestCaseKey=PAT-T5394 @PAT-12311 @regression
  Scenario: WT - Attached SPP & Watercraft - UW Q's - Indicate Product in Section Header
    Given I have started a new home policy through the "auto policy coverages" modal
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_policy"
    And I add an additional Indiana "scheduled_property" product till "scheduled_property_classes_modal" using the fixture file "scheduled_property_policy_issuance"
    And I navigate to my quote "Quote Management" using the left nav
    When I navigate to "Underwriting Questions" tab on quote management page
    Then I verify product wise rows for UW questions



