@watercraft @account_management
Feature: WT - Party Modal - Driver - Display Information & Link

  @delete_when_done @TestCaseKey=PAT-T5407 @PAT-11822 @regression
  Scenario: WT - Party Modal - Verify product name is link to summary page and edit link opens Add/Edit driver modal
    Given I have created a new "Auto" policy using the auto_existing_driver_self fixture
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_existing_driver_self_1"
    When I click edit on the applicant panel and open driver tab
    Then I verify warning message, links to product summary and edit link for driver modal
