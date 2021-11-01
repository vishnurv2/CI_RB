@reports
Feature: WT - Reports - Home Territory and WT - Reports-Dwelling Territory

  @fixture_home_policy_none_combined_none @delete_when_done @PAT-11711 @TestCaseKey=PAT-TXXX @regression @wip @homeowners
  Scenario: WT - Reports - Home Territory
    Given I have started a new home policy through the "auto policy coverages" modal
    When I navigate to "Reports" using the left nav
    Then I click the eye icon on "Territory, Protection Class, Flood" report
    And I validate details on territory protection class modal using home_territory_modal_information

  @fixture_dwelling_policy_issuance @delete_when_done @PAT-11715 @TestCaseKey=PAT-T5831 @regression @dwelling
  Scenario: WT - Reports-Dwelling Territory
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    When I navigate to "Reports" using the left nav
    And I click the eye icon on "Territory, Protection Class" report
    And I validate details on territory protection class modal using dwelling_territory_modal_information

  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @PAT-11708 @TestCaseKey=PAT-TXXX @regression @wip @auto
  Scenario: WT - Reports-Auto Territory
    Given I have created a new "Auto" policy
    When I navigate to "Reports" using the left nav
    And I click the eye icon on "Territory" report
    And I validate details on territory protection class modal using auto_territory_modal_information

  @fixture_scheduled_property_policy_issuance @delete_when_done @PAT-11824 @TestCaseKey=PAT-T5859 @regression @scheduled_property
  Scenario: WT - Reports-Scheduled Property - Territory
    Given I have created a new "scheduled_property" policy
    When I navigate to "Reports" using the left nav
    Then I validate that reports are not present for scheduled property

