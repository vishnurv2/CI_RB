@multiple @new_business
Feature: Umbrella - Exposures Insured with Another Carrier - Watercraft tab

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T423 @regression @PAT-4259 @known_issue @PAT-11479
  Scenario: Umbrella - Exposures insured with another carrier - Watercraft tab
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Given I add an additional Indiana "umbrella" product after fully issue till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    When I provide values for "Watercraft" through "watercraft" fixture file
    Then I validate products displayed in exposures insured with another carrier panel
      | products                                                           |
      | Sailboat                                                           |
      | Boats with Outboard Motors, 150 H.P or Less                        |
      | Boats with Outboard Motors, more than 150 H.P                      |
      | Boats with Inboard or Inboard / Outboard Motors, 250 H.P or less   |
      | Boats with Inboard or Inboard / Outboard Motors, more than 250 H.P |
      | Personal Watercraft (Jet Ski, Waverunner)                          |
    When I click on edit on 3 product in exposures insured with another carrier panel
    Then I validate by save and close the exposures modal without providing fields
    And the exposures modal should be closed


  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @regression @PAT-4259 @TestCaseKey=PAT-T3273 @known_issue @PAT-11479
  Scenario: Umbrella - Exposures insured with another carrier - Watercraft tab - provide details and validate
    Given I have created a new "Auto" policy
    Then I add an additional Indiana "umbrella" product after fully issue till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    When I provide values for "Watercraft" through "watercraft" fixture file
    When I click on edit on 3 product in exposures insured with another carrier panel
    Then I validate exposures modal after providing fields using "watercraft" fixture file and save and close it
    And I validate all the values displayed in the exposures insured with another carrier panel for product 4 on umbrella summary screen


  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @regression @PAT-4259 @TestCaseKey=PAT-T3274 @known_issue @PAT-11479
  Scenario: Umbrella - Exposures insured with another carrier - Watercraft tab - begin issuance of umbrella
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I add an additional Indiana "umbrella" product after fully issue till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    When I provide values for "Watercraft" through "watercraft" fixture file
    Then I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 3 product in exposures insured with another carrier panel
    Then I validate exposures modal after providing fields using "watercraft" fixture file and save and close it
    And I validate all the values displayed in the exposures insured with another carrier panel for product 4 on umbrella summary screen

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T637 @regression @PAT-4259
  Scenario: Begin issuance of umbrella - Exposures insured with another carrier - Watercraft tab - error message when not provide details
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Given I add an additional Indiana "umbrella" product after fully issue till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    When I provide values for "Watercraft" through "watercraft" fixture file
    Then I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 3 product in exposures insured with another carrier panel
    Then I validate by save and close the exposures modal without providing fields
    And I should see a validation error message in exposures modal