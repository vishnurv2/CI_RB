@dwelling @account_management
Feature: Create dwelling policy with different policy optional coverage

  @fixture_dwelling_policy_issuance @delete_when_done @TestCaseKey=PAT-T3647 @post_deploy_candidate @regression
  Scenario: A dwelling policy optional coverages list
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    Then I should see these dwelling policy optional coverages available
      | coverage                                              |
      | Actual Cash Value Loss Settlement                     |
      | Actual Cash Value Loss Settlement Roof Surface        |
      | Animal Exclusion Endorsement                          |
      | Business Pursuits                                     |
      | Canine  Exclusion Endorsement                         |
      | Course of Construction                                |
      | Earthquake                                            |
      | Equipment Breakdown                                   |
      | Functional Replacement Cost Loss Settlement           |
      | Limited Fungi Wet or Dry Rot or Bacteria Coverage     |
      | Loss Assessment Residence Premises                    |
      | Improvements Alterations and Additions                |
      | Manual Coverage                                       |
      | Ordinace or Law Increased Limit                       |
      | Other Structures Specifically Insured On Premise      |
      | Other Structures Exclusion Endorsement                |
      | Replacement Cost on the Dwelling-Additional Amount    |
      | Theft                                                 |
      | Theft of Building Materials                           |

  @fixture_dwelling_policy_issuance_all_coverages @regression @delete_when_done @TestCaseKey=PAT-T3648 @wip
  Scenario: Dwelling policy with all optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate all the dwelling optional coverages are present on Policy Level Optional Coverages panel

  @fixture_dwelling_policy_actual_cash_value @delete_when_done @TestCaseKey=PAT-T3649 @regression
  Scenario: Dwelling policy with Actual Cash Value Loss Settlement optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Actual Cash Value Loss Settlement" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_course_of_construction @regression @delete_when_done @TestCaseKey=PAT-T3650
  Scenario: Dwelling policy with Course of Construction optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Course of Construction" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_animal_exclusion @regression @delete_when_done @TestCaseKey=PAT-T3651
  Scenario: Dwelling policy with Animal Exclusion Endorsement optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Animal Exclusion Endorsement" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_actual_cash_value_roof @regression @delete_when_done @TestCaseKey=PAT-T3652
  Scenario: Dwelling policy with Actual Cash Value Loss Settlement - Roof Surface optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Actual Cash Value Loss Settlement Roof Surface" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_business_pursuits @regression @delete_when_done @TestCaseKey=PAT-T3653
  Scenario: Dwelling policy with Business Pursuits optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Business Pursuits" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_canine_exclusion_endorsement @regression @delete_when_done @TestCaseKey=PAT-T3654
  Scenario: Dwelling policy with Canine - Exclusion Endorsement optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Canine Exclusion Endorsement" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_earthquake @regression @delete_when_done @TestCaseKey=PAT-T3655
  Scenario: Dwelling policy with Earthquake optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Earthquake" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_equipment_breakdown @regression @delete_when_done @TestCaseKey=PAT-T3656
  Scenario: Dwelling policy with Equipment Breakdown optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Equipment Breakdown" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_functional_replacement_cost_loss @regression @delete_when_done @TestCaseKey=PAT-T3657
  Scenario: Dwelling policy with Functional Replacement Cost Loss Settlement optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Functional Replacement Cost Loss Settlement" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_limited_fungi @regression @delete_when_done @TestCaseKey=PAT-T3658
  Scenario: Dwelling policy with Limited Fungi Wet or Dry Rot or Bacteria Coverage optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Limited Fungi Wet or Dry Rot or Bacteria Coverage" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_loss_assessment_residence_premises @regression @delete_when_done @TestCaseKey=PAT-T3659
  Scenario: Dwelling policy with Loss Assessment Residence Premises optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Loss Assessment Residence Premises" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_improvements_alterations @regression @delete_when_done @TestCaseKey=PAT-T3660
  Scenario: Dwelling policy with Improvements Alterations and Additions optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Improvements Alterations and Additions" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_ordinace_or_law_increased @regression @delete_when_done @TestCaseKey=PAT-T3661
  Scenario: Dwelling policy with Ordinace or Law Increased Limit optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Ordinace or Law Increased Limit" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_other_structures_specifically @regression @delete_when_done @TestCaseKey=PAT-T3662
  Scenario: Dwelling policy with Other Structures Specifically Insured On Premise optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Other Structures Specifically Insured On Premise" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_other_structures_exclusion_endorsement @regression @delete_when_done @TestCaseKey=PAT-T3663
  Scenario: Dwelling policy with Other Structures Exclusion Endorsement optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Other Structures Exclusion Endorsement" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_replacement_cost @regression @delete_when_done @TestCaseKey=PAT-T3664
  Scenario: Dwelling policy with Replacement Cost on the Dwelling-Additional Amount optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Replacement Cost on the Dwelling-Additional Amount" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_theft @regression @delete_when_done @TestCaseKey=PAT-T3665
  Scenario: Dwelling policy with Theft optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Theft" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_theft_of_building_materials @regression @delete_when_done @TestCaseKey=PAT-T3666
  Scenario: Dwelling policy with Theft of Building Materials optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Theft of Building Materials" present on Policy Level Optional Coverages dwelling panel

  @fixture_dwelling_policy_manual_coverage @regression @delete_when_done @TestCaseKey=PAT-T3667
  Scenario: Dwelling policy with Manual Coverage optional coverages selected
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    When I provide details for dwelling policy optional coverages modal
    Then I validate "Manual Coverage" present on Policy Level Optional Coverages dwelling panel