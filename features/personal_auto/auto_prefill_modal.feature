@auto @vehicle @driver @indiana_auto @personal_auto @auto_prefill
Feature: Auto Prefill

  @fixture_auto_policy_autoplus_combined_none_clue_prefill @delete_when_done @TestCaseKey=PAT-T126
  Scenario: Auto prefill pulls drivers and autos
    Given I have started a new auto policy up to the "auto prefill" modal
    Then I should see my expected drivers and vehicles in the auto prefill modal
    When I populate the auto prefill modal
    Then I should see a vehicle modal for each of the vehicles I prefilled
    #And I should see a driver modal for each of the drivers prefilled
    #And each driver should show up in the driver assignment modal

  # Test no longer workable, as the prefill driver was removed from the modal.
  @regression @fixture_auto_policy_autoplus_combined_none_clue_prefill @delete_when_done @TestCaseKey=PAT-T127 @known_issue
  Scenario Outline: Auto Prefill Reloads From Add Buttons After Being Closed
    Given I have started a new auto policy up to the "auto prefill" modal
    And I dismiss the "auto prefill" modal
    And I select the <add_button> button on the <button's_panel> panel
    Then The "auto prefill" modal should be visible
    Examples:
      | add_button         | button's_panel     |
      | add button         | vehicle info panel |
      | add driver button  | driver info panel  |

  # Test no longer workable, as the prefill driver was removed from the modal.
  @regression @fixture_auto_policy_autoplus_combined_none_clue_prefill @delete_when_done @TestCaseKey=PAT-T125 @known_issue
  Scenario: Auto Prefill Reason Other Displays Text Area
    Given I have started a new auto policy up to the "auto prefill" modal
    When I uncheck the first prefill driver
    And I select Other as the first prefill remove reason
    Then I should see a text area below the first reason select list
    When I select Disabled as the first prefill remove reason
    Then I should not see a text area below the first reason select list
