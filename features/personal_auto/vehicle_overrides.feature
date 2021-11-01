@auto @new_business
Feature: WT - Overrides - Remove Override and Update Territory on Garage Address Change of Vehicle

  @fixture_auto_policy_autoplus_combined_none_full_vin @regression @PAT-12657 @TestCaseKey=PAT-T5867
  Scenario: WT - Overrides - Remove Override and Update Territory on Garage Address Change of Vehicle
    Given I have created a new "auto" policy
    And I begin issuance
    Then I navigate to "Overrides" using the left nav
    Then I should see a "Territory" in override panel 1
    When I apply the "Territory" override in panel 1
    Then the "Territory" override in panel 1 should show as overridden
    Then I navigate to "IN - Auto Plus" using the left nav
    And I click on edit the first vehicle
    And I validate overridden status on Territory field on vehicle modal
    Then I change garage address and validate status on Territory field

