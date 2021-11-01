@umbrella @multiple
Feature: Umbrella - update validations

  @fixture_umbrella_policy @delete_when_done @PAT-12455 @TestCaseKey=PAT-T5793 @regression
  Scenario: Umbrella - update validations
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    And I validate number of acres for umbrella with farm land rented to others
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I open the policy level optional coverages
    And I validate number of acres for home with farm land rented to others