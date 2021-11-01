@homeowners @account_management
Feature: Home policies can be created

  @fixture_home_policy_none_combined_none @delete_when_done @TestCaseKey=PAT-T47 @ci
  Scenario:  HOME New Home Policy
    Given I have started a new home policy through the "property info" modal
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel

  @fixture_home_policy_none_combined_none @delete_when_done @regression @TestCaseKey=PAT-T3629
  Scenario:  HOME Policy Coverages have required fields
    Given I have started a new home policy up to the "auto policy coverages" modal
    When I save and close the auto policy coverages modal
    Then I should see the following errors on the auto policy coverages modal:
      | Coverage A - Replacement Cost must be at least $5,000    |
      | Coverage A - Replacement Cost is required                |
      | Coverage B - Other Structures is required                |
      | Coverage C - Contents is required                        |
      | Coverage D - Loss of use is required                     |

#  @fixture_home_policy_none_combined_none_loss_settlement @delete_when_done
#  Scenario:  HOME New Home Policy with Actual Cash Value Loss Settlement
#    Given I have created a new "home" policy
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage Various Coverages Batch 1
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_policy_assisted_living_care                        |   PAT-4440        |
#      | home_business_property_increased_limit                  |   PAT-4441        |
#      | home_business_pursuits                                  |   PAT-4441        |
#      | home_coverage_c_firearms                                |   PAT-4446        |
#      | home_coverage_c_jewelry                                 |   PAT-4446        |
#
#  # Tamanna - this is the expected format needed here
#  # Please remove the scenario outlines and make the tests their own scenarios.
#  @delete_when_done @regression @PAT-4437
#  Scenario:  HOME New Home Policy with Optional Coverage loss settlement roof
#    Given I have created a new "home" policy using the home_policy_none_combined_none_loss_settlement_roof fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage Various Coverages Batch 2
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_coverage_c_money                                   |   PAT-4446        |
#      | home_coverage_c_electronics                             |   PAT-4446        |
#      | home_coverage_c_securities                              |   PAT-4446        |
#      | home_coverage_c_silverware                              |   PAT-4446        |
#      | home_credit_card_forgery                                |   PAT-4446        |
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage - Various Coverages Batch 3
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_earthquake                                         |   PAT-4452        |
#      | home_earthquake_loss                                    |   PAT-4453        |
#      | home_farmers_personal                                   |   PAT-4456        |
#      | home_farmers_personal_rented                            |   PAT-4457        |
#      | home_business_plus                                      |   PAT-4460        |
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage - Various Coverages Batch 4
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_incident_farming_liability                         |   PAT-4463        |
#      | home_incident_farming_liability_owned_operated          |   PAT-4464        |
#      | home_incidental_low_power_rec_vehicle                   |   PAT-4465        |
#      #| home_inland_flood                                      |   PAT-4173        | story not complete
#      | home_landlords_furnishing_coverage                      |   PAT-6922        |
#      | home_liability_extension                                |   PAT-4468        |
#      #| home_liability_extension_rented_to_others               |   PAT-xxxx        |
#
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage Various Coverages Batch 5
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_limited_fungi_rot                                  |   PAT-4508        |
#      | home_loss_assessment_additional_location                |   PAT-4470        |
#      | home_loss_assessment_resident_premises                  |   PAT-4471        |
#      | home_manual_coverage                                    |   PAT-4472        |
#      | home_motorized_golf_carts                               |   PAT-4459        |
#      | home_ordinance_or_law_increased_limit                   |   PAT-????        |
#      #| home_other_member_insureds_household                    |   PAT-4477        |
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage Various Coverages Batch 6
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_other_structures_off_premise                       |   PAT-4478        |
#      ##| home_other_structures_rented_premise                    |   PAT-4479        | This has a condition before showing look at story
#      | home_other_structures_specifically_insured              |   PAT-4480        |
#      | home_other_structures_exclusion_endorsement             |   PAT-4942        |
#      | home_permitted_incidental_occupancies_in_residence      |   PAT-4481        |
#      | home_permitted_incidental_occupancies_other_residence   |   PAT-6272        |
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage Various Coverages Batch 7
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_personal_cyber_protection                          |   PAT-4180        |
#      | home_personal_injury                                    |   PAT-4482        |
#      | home_property_located_self_storage                      |   PAT-4484        |
#      | home_personal_property_other_residence                  |   PAT-4483        |
#     #| home_plus_ten                                           |   PAT-4944        | PAT-7354
#      | home_refrigerated_property                              |   PAT-4485        |
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage Various Coverages Batch 8
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_rental_theft                                       |   PAT-4455        |
#      | home_replacement_cost_loss_settlement_non_building_structures   |    PAT-4487   |
#      | home_replacement_cost_on_contents                       |   PAT-4488    |
#      | home_replacement_cost_on_home                           |   PAT-4489    |
#      | home_residence_additional_rate                          |   PAT-4490    |
#      | home_snowmobile_coverage                                |   PAT-4492    |
#
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage Various Coverages Batch 9
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_special_loss_settlement                            |   PAT-4494    |
#      | home_student_away_from_home                             |   PAT-4496    |
#      | home_theft_of_building_materials                        |   PAT-4497    |
#      | home_theft_of_personal_property                         |   PAT-4498    |
#      | home_theft_of_tools                                     |   PAT-4499    |
#      | home_utility_line_protection                            |   PAT-4502    |
#
#  @delete_when_done @regression
#  Scenario Outline:  HOME New Home Policy with Optional Coverage Various Coverages Batch 9
#    Given I have created a new "home" policy using the <fixture_file> fixture
#    And the account summary should have an applicant
#    Then the property information I entered should be displayed in the property information panel
#    And the coverages I entered display in the home coverages panel
#    And the optional coverage should be saved in the coverages modal
#    Examples:
#      | fixture_file                                            |   story           |
#      | home_canine_liability                                   |   PAT-4981        |
#      | home_contingent_worker_compensation                     |   PAT-4445        |
#      | home_dock_coverage                                      |   PAT-4449        |
#      | home_functional_replacement_loss                        |   PAT-4458        |
#      | home_hydrostatic_pressure                               |   PAT-4461        |
#
#
#
#
