@auto @driver
Feature: Auto - MVR Auto - Remove discounts

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin_youthful_driver @TestCaseKey=PAT-T3288 @PAT-9768
  Scenario: Auto - MVR Auto - Remove discounts for recent effective date
    Given I have created a new "Auto" policy
    When I click on edit the first driver
    Then I validate the following options should not display on the driver modal
      | Options                |
      | Good Student           |
      | Driver Training        |
      | Student away at school |
    And I select "Teen Smart Participation" on drivers modal
    Then I validate the following options should display on the driver modal
      | Options                           |
      | Teen Smart Participation          |
      | Teen Smart Certification Checkbox |
    And I close the "auto driver" modal

  @delete_when_done @fixture_auto_policy_mvp_remove_discounts @TestCaseKey=PAT-T3289 @PAT-9768
  Scenario: Auto - MVR Auto - Remove discounts - for old effective date
    Given I have created a new "Auto" policy
    When I click on edit the first driver
    Then I validate the following options should display on the driver modal
      | Options                |
      | Good Student           |
      | Driver Training        |
      | Student away at school |