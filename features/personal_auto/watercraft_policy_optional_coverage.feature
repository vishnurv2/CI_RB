@watercraft @account_management
Feature: Create watercraft policy with different policy optional coverage

  @fixture_watercraft_policy_coverage_null @delete_when_done @TestCaseKey=PAT-T3253
  Scenario: A watercraft policy optional coverages list
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    Then I should see these watercraft policy optional coverages available
      | coverage                            |
      | Emergency Service Expanded Coverage |
      | Personal Effects                    |
      | Boating Equipment Coverage Increase |
      | Manual Coverage                     |

  @fixture_watercraft_policy_coverage_null @regression @delete_when_done @TestCaseKey=PAT-T3266
  Scenario: Watercraft policy with all optional coverages selected
    Given I have created a new "watercraft" policy
    And I click on modify watercraft optional coverages information
    When I provide details for watercraft policy optional coverages modal
    Then I validate all the optional coverages are present on Policy Level Optional Coverages panel

  @fixture_watercraft_optional_policy_coverage_emergency_service @delete_when_done @TestCaseKey=PAT-T3267
  Scenario: Watercraft policy with Emergency optional coverage selected
    Given I have created a new "watercraft" policy
    And I click on modify watercraft optional coverages information
    When I provide details for watercraft policy optional coverages modal
    Then I validate "Emergency Service Expanded Coverage" present on Policy Level Optional Coverages panel

  @fixture_watercraft_optional_policy_coverage_personal_effects @regression @delete_when_done @TestCaseKey=PAT-T3268
  Scenario: Watercraft policy with Personal Effects optional coverage selected
    Given I have created a new "watercraft" policy
    And I click on modify watercraft optional coverages information
    When I provide details for watercraft policy optional coverages modal
    Then I validate "Personal Effects" present on Policy Level Optional Coverages panel

  @fixture_watercraft_optional_policy_coverage_manual_coverage @regression @delete_when_done @TestCaseKey=PAT-T3269
  Scenario: Watercraft policy with Manual Coverage optional coverage selected
    Given I have created a new "watercraft" policy
    And I click on modify watercraft optional coverages information
    When I provide details for watercraft policy optional coverages modal
    Then I validate "Manual Coverage" present on Policy Level Optional Coverages panel

  @fixture_watercraft_optional_policy_coverage_boating_equipment @regression @delete_when_done @TestCaseKey=PAT-T3270
  Scenario: Watercraft policy with Boating Equipment optional coverage selected
    Given I have created a new "watercraft" policy
    And I click on modify watercraft optional coverages information
    When I provide details for watercraft policy optional coverages modal
    Then I validate "Boating Equipment Coverage Increase" present on Policy Level Optional Coverages panel



