@homeowners @account_management
Feature: Home policies can be created

  @fixture_home_policy_none_combined_none @delete_when_done @PAT-4021 @TestCaseKey=PAT-T219
  Scenario:  Validate Territory PPC modal
    Given I have started a new home policy through the "property info" modal
    And the account summary should have an applicant
    When I navigate to "Reports" using the left nav
    And I click the eye icon on "Territory, Protection Class, Flood" report
    Then I should see the "Protection class" section
    And I validate fields under Geocoding Information using the home_geocoding_information fixture

  @fixture_auto_policy_none_combined_none @delete_when_done @regression @PAT-4021 @TestCaseKey=PAT-T232
  Scenario: Validate Territory PPC modal Auto policy
    Given I have created a new "Auto" policy
    When I navigate to "Reports" using the left nav
    And I click the eye icon on "Territory" report
    Then I should not see the "Protection class" section
    And I validate fields under Geocoding Information using the auto_geocoding_information fixture

  @fixture_home_policy_territory_no_hit @delete_when_done @regression @PAT-4021 @PAT-7362 @TestCaseKey=PAT-T221 @wip
  Scenario:  Validate status of Territory report as Multiple hits
    Given I have started a new home policy through the "property info" modal
    And the account summary should have an applicant
    When I navigate to "Reports" using the left nav
    Then I validate status for "Territory, Protection Class, Flood" report as "Multiple Hits"

    # instead of no hit, status is empty
  @fixture_home_policy_territory_multiple_hits @delete_when_done @regression @PAT-4021 @PAT-7362 @TestCaseKey=PAT-T220 @known_issue @wip
  Scenario:  Validate status of Territory report as no hit
    Given I have started a new home policy through the "property info" modal
    And the account summary should have an applicant
    When I navigate to "Reports" using the left nav
    Then I validate status for "Territory, Protection Class, Flood" report as "No Hit"


