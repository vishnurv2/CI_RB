@homeowners @account_management
Feature: Home policies can be created

  @fixture_home_policy_none_combined_none_loss_settlement @delete_when_done @TestCaseKey=PAT-T3707
  Scenario:  HOME New Home Policy with Actual Cash Value Loss Settlement
    Given I have created a new "home" policy
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel

  #BATCH 1
  @delete_when_done @regression @PAT-4437 @TestCaseKey=PAT-T3708
  Scenario:  HOME New Home Policy with Optional Coverage loss settlement roof
    Given I have created a new "home" policy using the home_policy_none_combined_none_loss_settlement_roof fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4440 @TestCaseKey=PAT-T3709
  Scenario:  HOME New Home Policy with Optional Coverage Assisted Living Care
    Given I have created a new "home" policy using the home_policy_assisted_living_care fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal


  @delete_when_done @regression @PAT-4441 @TestCaseKey=PAT-T3710
  Scenario:  HOME New Home Policy with Optional Coverage Business Property - Increased Limit
    Given I have created a new "home" policy using the home_business_property_increased_limit fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4441 @TestCaseKey=PAT-T3711
  Scenario:  HOME New Home Policy with Optional Coverage Business Pursuits
    Given I have created a new "home" policy using the home_business_pursuits fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4446 @TestCaseKey=PAT-T3712
  Scenario:  HOME New Home Policy with Optional Coverage C - Increased Limits of Liability - Firearms
    Given I have created a new "home" policy using the home_coverage_c_firearms fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4446 @TestCaseKey=PAT-T3713
  Scenario:  HOME New Home Policy with Optional Coverage C - Increased Limits of Liability - Jewelry Watches Furs
    Given I have created a new "home" policy using the home_coverage_c_jewelry fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

#BATCH 2
  @delete_when_done @regression @PAT-4446 @TestCaseKey=PAT-T3714
  Scenario:  HOME New Home Policy with Optional Coverage C - Increased Limits of Liability - Money
    Given I have created a new "home" policy using the home_coverage_c_money fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4446 @TestCaseKey=PAT-T3715
  Scenario:  HOME New Home Policy with Optional Coverage C - Electronic
    Given I have created a new "home" policy using the home_coverage_c_electronics fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4446 @TestCaseKey=PAT-T3716
  Scenario:  HOME New Home Policy with Optional Coverage C - Securities
    Given I have created a new "home" policy using the home_coverage_c_securities fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal


  @delete_when_done @regression @PAT-4446 @TestCaseKey=PAT-T3717
  Scenario:  HOME New Home Policy with Optional Coverage C - Silverware Goldware Pewterware
    Given I have created a new "home" policy using the home_coverage_c_silverware fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4446 @TestCaseKey=PAT-T3718
  Scenario:  HOME New Home Policy with Optional Coverage - Credit Card Forgery
    Given I have created a new "home" policy using the home_credit_card_forgery fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

    #BATCH 3
  @delete_when_done @PAT-4452 @TestCaseKey=PAT-T3719 @post_deploy_candidate @regression
  Scenario:  HOME New Home Policy with Optional Coverage - Earthquake
    Given I have created a new "home" policy using the home_earthquake fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4453 @TestCaseKey=PAT-T3720
  Scenario:  HOME New Home Policy with Optional Coverage  - Earthquake Loss Assessment
    Given I have created a new "home" policy using the home_earthquake_loss fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4456 @TestCaseKey=PAT-T3721
  Scenario:  HOME New Home Policy with Optional Coverage-Farming Personal Liability - Away From Premises-Owned - Operated by Insured
    Given I have created a new "home" policy using the home_farmers_personal fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4457 @TestCaseKey=PAT-T3722
  Scenario:  HOME New Home Policy with Optional Coverage-- Farming Personal Liability - Away From Premises-Rented to Others
    Given I have created a new "home" policy using the home_farmers_personal_rented fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4460 @TestCaseKey=PAT-T3723
  Scenario:  HOME New Home Policy with Optional Coverage - Home Business Plus
    Given I have created a new "home" policy using the home_business_plus fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal


    #BATCH-4
  @delete_when_done @regression @PAT-4463 @TestCaseKey=PAT-T3741
  Scenario:  HOME New Home Policy with Optional Coverage Farming Personal Liability - Away From Premises
    Given I have created a new "home" policy using the home_incident_farming_liability fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4464 @TestCaseKey=PAT-T3742
  Scenario:  HOME New Home Policy with Optional Coverage Farming Personal Liability - owned operated
    Given I have created a new "home" policy using the home_incident_farming_liability_owned_operated fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4465 @TestCaseKey=PAT-T3743
  Scenario:  HOME New Home Policy with Optional Coverage Incidental Low Power Recreational Vehicle
    Given I have created a new "home" policy using the home_incidental_low_power_rec_vehicle fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4173 @TestCaseKey=PAT-T3744
  Scenario:  HOME New Home Policy with Optional Coverage Inland Flood
    Given I have created a new "home" policy using the home_inland_flood fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-6922 @TestCaseKey=PAT-T3745
  Scenario:  HOME New Home Policy with Optional Coverage - Landlords Furnishings Coverage
    Given I have created a new "home" policy using the home_landlords_furnishing_coverage fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4468 @TestCaseKey=PAT-T3746
  Scenario:  HOME New Home Policy with Optional Coverage Liability Extension - Occupied by Insured
    Given I have created a new "home" policy using the home_liability_extension fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @TestCaseKey=PAT-T3747
  Scenario:  HOME New Home Policy with Optional Coverage Liability Extension - Rented to Others
    Given I have created a new "home" policy using the home_liability_extension_rented_to_others fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

#BATCH-5
  @delete_when_done @regression @PAT-4580 @TestCaseKey=PAT-T3748
  Scenario:  HOME New Home Policy with Optional Coverage Various Coverages - Limited Fungi Wet or Dry Rot or Bacteria Coverage
    Given I have created a new "home" policy using the home_limited_fungi_rot fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4470 @TestCaseKey=PAT-T3749
  Scenario:  HOME New Home Policy with Optional Coverage Various Coverages - Loss Assessment - Additional Locations
    Given I have created a new "home" policy using the home_loss_assessment_additional_location fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4471 @TestCaseKey=PAT-T3750
  Scenario:  HOME New Home Policy with Optional Coverage Various Coverages - Loss Assessment - Residence Premises
    Given I have created a new "home" policy using the home_loss_assessment_resident_premises fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4472 @TestCaseKey=PAT-T3751
  Scenario:  HOME New Home Policy with Optional Coverage Various Coverages - Manual Coverage
    Given I have created a new "home" policy using the home_manual_coverage fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4449 @TestCaseKey=PAT-T3752
  Scenario:  HOME New Home Policy with Optional Coverage Various Coverages - Motorized Golf Cart
    Given I have created a new "home" policy using the home_motorized_golf_carts fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @TestCaseKey=PAT-T3753
  Scenario:  HOME New Home Policy with Optional Coverage Various Coverages - Ordinance or Law - Increased Limit
    Given I have created a new "home" policy using the home_ordinance_or_law_increased_limit fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4477 @TestCaseKey=PAT-T3754
  Scenario:  HOME New Home Policy with Optional Coverage Various Coverages -Other Members of Insureds Household Coverage
    Given I have created a new "home" policy using the home_other_member_insureds_household fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

    #BATCH-6

  @delete_when_done @regression @PAT-4478 @TestCaseKey=PAT-T3755
  Scenario:  HOME New Home Policy with Optional Coverage - Other Structures - Not Specifically Insured - Off Premise
    Given I have created a new "home" policy using the home_other_structures_off_premise fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4479 @TestCaseKey=PAT-T3756
  Scenario:  HOME New Home Policy with Optional Coverage - Other Structures-Rented to Others-Residence Premise
    Given I have created a new "home" policy using the home_other_structures_rented_premise fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4480 @TestCaseKey=PAT-T3757
  Scenario:  HOME New Home Policy with Optional Coverage - Other Structures - Specifically Insured - Off Premise
    Given I have created a new "home" policy using the home_other_structures_specifically_insured fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4942 @TestCaseKey=PAT-T3758
  Scenario:  HOME New Home Policy with Optional Coverage - Other Structures Exclusion Endorsement
    Given I have created a new "home" policy using the home_other_structures_exclusion_endorsement fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4481 @TestCaseKey=PAT-T3759
  Scenario:  HOME New Home Policy with Optional Coverage - Permitted Incidental Occupancies- In Residence
    Given I have created a new "home" policy using the home_permitted_incidental_occupancies_in_residence fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-6272 @TestCaseKey=PAT-T3760
  Scenario:  HOME New Home Policy with Optional Coverage - Permitted Incidental Occupancies-Other Residence
    Given I have created a new "home" policy using the home_permitted_incidental_occupancies_other_residence fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

    #BATCH-7
  @delete_when_done @regression @PAT-4180 @TestCaseKey=PAT-T3761
  Scenario:  HOME New Home Policy with Optional Coverage - Personal Cyber Protection
    Given I have created a new "home" policy using the home_personal_cyber_protection fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4482 @TestCaseKey=PAT-T3762
  Scenario:  HOME New Home Policy with Optional Coverage - Personal Injury
    Given I have created a new "home" policy using the home_personal_injury fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4484 @TestCaseKey=PAT-T3763
  Scenario:  HOME New Home Policy with Optional Coverage - Personal Property Located in a Self-Storage Facility-Increased Limit
    Given I have created a new "home" policy using the home_property_located_self_storage fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal


  @delete_when_done @regression @PAT-4483 @TestCaseKey=PAT-T3764
  Scenario:  HOME New Home Policy with Optional Coverage - Personal Property-Increased Limit-Other Residences
    Given I have created a new "home" policy using the home_personal_property_other_residence fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4944 @TestCaseKey=PAT-T3765
  Scenario:  HOME New Home Policy with Optional Coverage - Plus Ten
    Given I have created a new "home" policy using the home_plus_ten fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4485 @TestCaseKey=PAT-T3766
  Scenario:  HOME New Home Policy with Optional Coverage - refrigerated property
    Given I have created a new "home" policy using the home_refrigerated_property fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

    #BATCH-8
  @delete_when_done @regression @PAT-4455 @TestCaseKey=PAT-T3767
  Scenario:  HOME New Home Policy with Optional Coverage - Rental Theft
    Given I have created a new "home" policy using the home_rental_theft fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4487 @TestCaseKey=PAT-T3768
  Scenario:  HOME New Home Policy with Optional Coverage - Replacement Cost Loss Settlement of Certain Non-Building Structures
    Given I have created a new "home" policy using the home_replacement_cost_loss_settlement_non_building_structures fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4488 @TestCaseKey=PAT-T3769
  Scenario:  HOME New Home Policy with Optional Coverage - Replacement Cost on Contents
    Given I have created a new "home" policy using the home_replacement_cost_on_contents fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4489 @TestCaseKey=PAT-T3770
  Scenario:  HOME New Home Policy with Optional Coverage - Replacement Cost on the Home-Additional Amount
    Given I have created a new "home" policy using the home_replacement_cost_on_home fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4490 @TestCaseKey=PAT-T3771
  Scenario:  HOME New Home Policy with Optional Coverage -Residence Employees -Additional Rate for More Than Two Employees
    Given I have created a new "home" policy using the home_residence_additional_rate fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4492 @TestCaseKey=PAT-T3772
  Scenario:  HOME New Home Policy with Optional Coverage -Snowmobile Coverage
    Given I have created a new "home" policy using the home_snowmobile_coverage fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

    #BATCH-9
  @delete_when_done @regression @PAT-4494 @TestCaseKey=PAT-T3773
  Scenario:  HOME New Home Policy with Optional Coverage - Special Loss Settlement
    Given I have created a new "home" policy using the home_special_loss_settlement fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4496 @TestCaseKey=PAT-T3774
  Scenario:  HOME New Home Policy with Optional Coverage - Student Away From Home
    Given I have created a new "home" policy using the home_student_away_from_home fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4497 @TestCaseKey=PAT-T3775
  Scenario:  HOME New Home Policy with Optional Coverage - Theft of Building Materials
    Given I have created a new "home" policy using the home_theft_of_building_materials fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4498 @TestCaseKey=PAT-T3776
  Scenario:  HOME New Home Policy with Optional Coverage - Theft of Personal Property Dwelling Under Construction
    Given I have created a new "home" policy using the home_theft_of_personal_property fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4499 @TestCaseKey=PAT-T3777
  Scenario:  HOME New Home Policy with Optional Coverage - Theft of Tools Optional Deductible
    Given I have created a new "home" policy using the home_theft_of_tools fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4502 @TestCaseKey=PAT-T3778
  Scenario:  HOME New Home Policy with Optional Coverage - Utility Line Protection
    Given I have created a new "home" policy using the home_utility_line_protection fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

    #BATCH-10

  @delete_when_done @regression @PAT-4981 @TestCaseKey=PAT-T3779
  Scenario:  HOME New Home Policy with Optional Coverage - Canine - Exclusion Endorsement
    Given I have created a new "home" policy using the home_canine_liability fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4445 @TestCaseKey=PAT-T3780
  Scenario:  HOME New Home Policy with Optional Coverage - Contingent Workers Compensation
    Given I have created a new "home" policy using the home_contingent_worker_compensation fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4449 @TestCaseKey=PAT-T3781
  Scenario:  HOME New Home Policy with Optional Coverage - Dock Coverage
    Given I have created a new "home" policy using the home_dock_coverage fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4458 @TestCaseKey=PAT-T3782
  Scenario:  HOME New Home Policy with Optional Coverage - Functional Replacement Cost Loss Settlement
    Given I have created a new "home" policy using the home_functional_replacement_loss fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @PAT-4461 @TestCaseKey=PAT-T3783
  Scenario:  HOME New Home Policy with Optional Coverage - Hydrostatic Pressure
    Given I have created a new "home" policy using the home_hydrostatic_pressure fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal


    #optional coverages which were not covered earlier
  @delete_when_done @regression @TestCaseKey=PAT-T3784
  Scenario:  HOME New Home Policy with Optional Coverage - Animal - Exclusion Endorsement -1
    Given I have created a new "home" policy using the home_animal_exclusion_endorsement fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @TestCaseKey=PAT-T3785
  Scenario:  HOME New Home Policy with Optional Coverage - Animal - Exclusion Endorsement -2
    Given I have created a new "home" policy using the home_animal_exclusion_endorsement fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @TestCaseKey=PAT-T3786
  Scenario:  HOME New Home Policy with Optional Coverage - Sinkhole Collapse Coverage
    Given I have created a new "home" policy using the home_sinkhole_collapse_coverage fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @TestCaseKey=PAT-T3787
  Scenario:  HOME New Home Policy with Optional Coverage - Sports Plus
    Given I have created a new "home" policy using the home_sports_plus fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @TestCaseKey=PAT-T3788
  Scenario:  HOME New Home Policy with Optional Coverage - Special Computer Coverage
    Given I have created a new "home" policy using the home_special_computer_coverage fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @TestCaseKey=PAT-T3789
  Scenario:  HOME New Home Policy with Optional Coverage - Identity Fraud Protection
    Given I have created a new "home" policy using the home_identity_fraud_protection fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal

  @delete_when_done @regression @TestCaseKey=PAT-T3790
  Scenario:  HOME New Home Policy with Optional Coverage - Equipment Breakdown
    Given I have created a new "home" policy using the home_equipment_breakdown fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal


  @delete_when_done @regression @TestCaseKey=PAT-T3791
  Scenario:  HOME New Home Policy with Optional Coverage - Other Structures - Specifically Insured - On Premise
    Given I have created a new "home" policy using the home_other_structures_specifically_insured_on_premise fixture
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel
    And the coverages I entered display in the home coverages panel
    And the optional coverage should be saved in the coverages modal
