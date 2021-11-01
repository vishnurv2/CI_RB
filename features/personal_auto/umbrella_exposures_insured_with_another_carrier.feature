@umbrella @account_management
Feature: Umbrella - Exposures insured with another carrier

  @fixture_auto_policy_exposure_vehicle @delete_when_done @regression @PAT-6333 @TestCaseKey=PAT-T28
  Scenario: Umbrella - Exposures insured with another carrier
    Given I have created a new "Auto" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I click on add exposures insured with another carrier
    And The "exposures insured with another carrier" modal should be visible

  @fixture_umbrella_policy @delete_when_done @regression @PAT-4061 @TestCaseKey=PAT-T263
  Scenario: Umbrella - Exposures insured with another carrier - validate containers in the modal
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    And I validate following containers in "exposures insured with another carrier" modal
      | containers             |
      | Vehicles               |
      | Location / Property    |
      | Watercraft             |
      | Business Property      |
      | Farm Land              |
      | Student Away From Home |

  @fixture_umbrella_policy @delete_when_done @regression @PAT-4256 @PAT-7620 @PAT-7727 @TestCaseKey=PAT-T2121
  Scenario: Umbrella - Exposures insured with another carrier - Location or Property
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Location / Property" through "location_property" fixture file
    Then I validate products displayed in exposures insured with another carrier panel
      | products                             |
      | Owner Occupied - Single Family Homes |
      | Owner Occupied - Single Family Homes |
      | Owner Occupied - Multi Family Homes  |
      | Owner Occupied - Multi Family Homes  |
    When I click on edit on 1 product in exposures insured with another carrier panel
    Then I validate by save and close the exposures modal without providing fields
    And the exposures modal should be closed
    Then I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 1 product in exposures insured with another carrier panel
    Then I validate by save and close the exposures modal without providing fields
    And I should see a validation error message in exposures modal
    Then I validate by save and close the exposures modal after providing fields using "location_property" fixture file
    And I validate all the values displayed in the exposures insured with another carrier panel for product 1

  @fixture_umbrella_policy @delete_when_done @regression @PAT-4256 @TestCaseKey=PAT-T287
  Scenario: Umbrella - Exposures insured with another carrier - Location or Property - validate limits dropdown options
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Location / Property" through "location_property" fixture file
    And I click on edit on 1 product in exposures insured with another carrier panel
    Then I should see the following limits options in the modal
      | limits     |
      | $300,000   |
      | $400,000   |
      | $500,000   |
      | $1,000,000 |
      | other      |