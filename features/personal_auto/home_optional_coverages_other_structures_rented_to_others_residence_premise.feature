@homeowners @account_management
Feature: Homeowners - Optional coverage - Other Structures Rented to Others Residence Premise

  @fixture_home_optional_coverage_rented_to_others_residence_premise_3_special_secondary @delete_when_done @regression @PAT-4479 @TestCaseKey=PAT-T34
  Scenario:  Homeowners - Optional coverage - Other Structures Rented to Others Residence Premise - H03 and the primary use or occupancy as secondary
    Given I have started a new home policy through the "auto policy coverages" modal
    Then the policy should not display the coverage "Other Structures - Rented to Others - Residence Premise"

  @fixture_home_optional_coverage_rented_to_others_residence_premise_6c_summit_condo_owners @delete_when_done @regression @PAT-4479 @TestCaseKey=PAT-T408
  Scenario:  Homeowners - Optional coverage - Other Structures Rented to Others Residence Premise - Condo and the primary use or occupancy as secondary
    Given I have started a new home policy through the "auto policy coverages" modal
    Then the policy should not display the coverage "Other Structures - Rented to Others - Residence Premise"

  @fixture_home_optional_coverage_residence_premise_3_special @delete_when_done @regression @PAT-7882 @TestCaseKey=PAT-T411
  Scenario:  Homeowners - Optional coverage - Other Structures Rented to Others Residence Premise - H03 and the primary use or occupancy as primary
    Given I have started a new home policy through the "auto policy coverages" modal
    Then the policy should display the coverage "Other Structures - Rented to Others - Residence Premise"
    And I open the policy level optional coverages
    When I have populated the auto policy optional coverages modal
    And I save and close the "auto policy optional coverages" modal

  @fixture_home_optional_coverage_residence_premise_3_special @delete_when_done @regression @PAT-7882 @TestCaseKey=PAT-T3627
  Scenario:  Homeowners - Optional coverage - Other Structures Rented to Others Residence Premise - Validate liability limits and medical payments values displayed
    Given I have started a new home policy through the "auto policy coverages" modal
    And I modify the policy level coverages
    And I save the coverages provided on policy level coverages modal
    Then I open the policy level optional coverages
    And I validate the liability limits and medical payments displayed

  @fixture_home_optional_coverage_residence_premise_3_special @delete_when_done @regression @PAT-7882 @TestCaseKey=PAT-T3628
  Scenario:  Homeowners - Optional coverage - Other Structures Rented to Others Residence Premise - Validate error message on removing mandatory field
    Given I have started a new home policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    When I have populated the auto policy optional coverages modal
    And I save and close the "auto policy optional coverages" modal
    Then I open the policy level optional coverages
    And I validate error message on removing mandatory field


