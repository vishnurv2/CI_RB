@umbrella @vehicle
Feature: Umbrella - Exposures insured with another carrier - Vehicles

  @fixture_home_policy_none_combined_none_loss_settlement @delete_when_done @regression @PAT-4255 @TestCaseKey=PAT-T255
  Scenario:  Umbrella - Exposures insured with another carrier - Vehicles tab
    Given I have created a new "home" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    When I provide values for "Vehicles" through "vehicles" fixture file
    Then I validate products displayed in exposures insured with another carrier panel
      | products                               |
      | Automobile                             |
      | Automobile - Limited Use               |
      | Company Car                            |
      | Camper / Motorhome                     |
      | Street Motorcycle                      |
      | Off-Road Motorcycle (less than 250cc)  |
      | Off-Road Motorcycle (250cc or greater) |
      | ATV - 3 - wheel                        |
      | ATV - 4 - wheel                        |
      | Snowmobile                             |
      | Golf Cart                              |
      | Moped / Scooter                        |
      | Dune Buggy                             |
    When I click on edit on 1 product in exposures insured with another carrier panel
    Then I validate by save and close the exposures modal without providing fields
    And the exposures modal should be closed
    Then I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 1 product in exposures insured with another carrier panel
    Then I validate by save and close the exposures modal without providing fields
    And I should see a validation error message in exposures modal

  @fixture_home_policy_none_combined_none_loss_settlement @delete_when_done @regression @PAT-4255 @TestCaseKey=PAT-T255 @wip
  Scenario:  Umbrella - Exposures insured with another carrier - Vehicles tab - provide details and validate
    Given I have created a new "home" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    When I provide values for "Vehicles" through "vehicles" fixture file
    Then I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 1 product in exposures insured with another carrier panel
    Then I validate by providing fields for all the products using "vehicles" fixture file
    And I validate all the values displayed in the exposures insured with another carrier panel for all the products

  @fixture_home_policy_none_combined_none_loss_settlement @delete_when_done @regression @PAT-4255 @TestCaseKey=PAT-T299
  Scenario:  Umbrella - Exposures insured with another carrier - Vehicles tab - verify limits dropdown for Combined Single Limits
    Given I have created a new "home" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    When I provide values for "Vehicles" through "vehicles" fixture file
    And I click on edit on 1 product in exposures insured with another carrier panel
    Then I should see the following limit options for "Combined Single Limits" in the modal
      | limit    |
      | $300,000 |
      | $500,000 |
      | other    |

  @fixture_home_policy_none_combined_none_loss_settlement @delete_when_done @regression @PAT-4255 @TestCaseKey=PAT-T300
  Scenario:  Umbrella - Exposures insured with another carrier - Vehicles tab- verify limits dropdown for Split Limits
    Given I have created a new "home" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    When I provide values for "Vehicles" through "vehicles" fixture file
    And I click on edit on 1 product in exposures insured with another carrier panel
    Then I should see the following limit options for "Split Limits" in the modal
      | limit                      |
      | $250,000/$500,000/$100,000 |
      | $250,000/$500,000/$250,000 |
      | $300,000/$300,000/$300,000 |
      | $500.000/$500,000/$500,000 |
      | other                      |