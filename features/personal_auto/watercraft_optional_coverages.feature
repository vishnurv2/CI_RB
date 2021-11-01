@watercraft @account_management
Feature: Watercraft optional coverages

  @fixture_watercraft_policy @delete_when_done @PAT-4290 @TestCaseKey=PAT-T44
  Scenario:  Watercraft - validate optional coverages modal through edit icon
    Given I have started a new watercraft policy through the "auto_policy_coverages" modal
    And I click on modify watercraft optional coverages information
    Then The "auto policy optional coverages" modal should be visible

  @fixture_watercraft_policy @delete_when_done @PAT-4290 @PAT-7598 @TestCaseKey=PAT-T79
  Scenario:  Watercraft - validate optional coverages when Enhanced Coverage - Summit is selected
    Given I have started a new watercraft policy through the "auto_policy_coverages" modal
    And I click on modify watercraft optional coverages information
    When I provide details for watercraft policy optional coverages modal
    Then I validate Emergency Service Expanded Coverage when Enhanced Coverage Summit is selected
    And validate Personal Effects when Enhanced Coverage Summit is selected
    And validate Boating Equipment Coverage Increase

  @fixture_watercraft_policy_no_enhanced @delete_when_done @PAT-4290 @TestCaseKey=PAT-T81
  Scenario:  Watercraft - validate optional coverages when Enhanced Coverage - Summit is not selected
    Given I have started a new watercraft policy through the "auto_policy_coverages" modal
    And I click on modify watercraft optional coverages information
    When I provide details for watercraft policy optional coverages modal
    Then I validate Emergency Service Expanded Coverage when Enhanced Coverage Summit is not selected
    And validate Personal Effects when Enhanced Coverage Summit is not selected
    And validate Boating Equipment Coverage Increase

  @fixture_watercraft_policy @delete_when_done @PAT-4290 @regression @TestCaseKey=PAT-T80
  Scenario:  Watercraft - validate default values of Boating Equipment Coverage Increase when unselected or selected
    Given I have started a new watercraft policy through the "auto_policy_coverages" modal
    Then I validate default values of Boating Equipment Coverage Increase

    # Note: This test is not working currently. Will be worked upon once this functionality is available in application.
  @fixture_watercraft_policy @delete_when_done @PAT-4290 @regression @wip
  Scenario:  Watercraft - validate optional coverages modal through add product
    Given I have started a new watercraft policy up to the "auto_policy_optional_coverages" modal
    Then The "auto policy optional coverages" modal should be visible
