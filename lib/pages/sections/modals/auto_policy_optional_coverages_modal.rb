# frozen_string_literal: true

class AutoPolicyOptionalCoveragesModal < BaseModal
  SELECT_FIELD_HOOKS ||= CptHook.define_hooks do
    before(:select).call(->(e) { e.scroll.to }).with(:self)
    before(:select).call(:click)
  end
  SCROLL_HOOKS ||= CptHook.define_hooks do
    before(:select).call(->(e) { e.scroll.to }).with(:self)
  end
  checkbox(:corporate_auto_coverage, xpath: './/app-dynamic-control[.//text()[contains(., "orporate")]]/.//p-checkbox')
  checkbox(:extended_non_owned_coverage, xpath: './/app-dynamic-control[.//text()[contains(., "xtended")]]/.//p-checkbox')
  checkbox(:manual_coverage, xpath: './/app-dynamic-control[.//text()[contains(., "anual")]]/.//p-checkbox')
  checkbox(:mexico_coverage, xpath: './/app-dynamic-control[.//text()[contains(., "exico")]]/.//p-checkbox')
  checkbox(:named_non_owner_coverage, xpath: './/app-dynamic-control[.//text()[contains(., "amed")]]/.//p-checkbox')

  sections(:manual_coverages, ManualCoveragePanel, item: { class: 'coverageIterationPanel' }, hooks: WFA_HOOKS)
  radio_set(:eno_coverage_selection, xpath: '.', item: { id: /ExtendedNonOwnedCoverageOptions/ })
  select(:eno_driver, id: /ExtendedNonOwnedDriverSelection/, hooks: SELECT_FIELD_HOOKS)

  ##-------------HOME OPTIONAL COVERAGES--------------#
  # # Actual Cash Value Loss Settlement - DONE
  checkbox(:actual_cash_value_loss_settlement, id: 'ActualCashValueLossSettlementSelected')
  select(:coverage_a_replacement_cost_percentage, id: /ActualCashValueLossSettlement_CoverageAtoReplacementCostPercentage/, hooks: SELECT_FIELD_HOOKS) # Coverage A to Replacement Cost Percentage

  # Actual Cash Value Loss Settlement - Roof Surface - DONE
  checkbox(:actual_cash_value_loss_settlement_roof, id: 'ActualCashValueRoofSurfaceSelected')
  checkbox(:animal_exclusion_endorsement, id: 'AnimalLiabilityExclusionSelected')
  checkbox(:actual_cash_value_loss_settlement_roof_surface, id: 'ActualCashValueRoofSurfaceSelected')
  textarea(:description_of_animal, id: /AnimalLiabilityExclusionDescription/)

  # Additions and Alterations - Increased Limit
  checkbox(:additions_and_alterations_increased_limit, id: 'AdditionsAlterationsIncreasedLimitSelected')
  text_field(:additions_and_alterations_increased_limit_total_limit, xpath: './/p-checkbox[label[contains(text(), "Additions and Alterations - Increased Limit")]]//ancestor::app-dynamic-control//label[contains(text(),"Total Limit")]//following-sibling::app-currency-input/input[1]')

  # Additions and Alterations - Other Residence
  checkbox(:additions_and_alterations_other_residence, id: 'AdditionsAlterationsOtherResidenceSelected')
  text_field(:additions_and_alterations_other_residence_total_limit, xpath: './/p-checkbox[label[contains(text(), "Additions and Alterations - Other Residence")]]//ancestor::app-dynamic-control//label[contains(text(),"Total Limit")]//following-sibling::app-currency-input/input[1]')

  # Assisted Living Care - DONE
  checkbox(:assisted_living_care, id: 'AssistedLivingCareSelected')
  text_field(:total_personal_property_limit, id: /currency_2545undefined/)
  text_field(:name_of_resident, id: /AssistedLivingCare_NameOfResident/)
  text_field(:location_of_resident, id: /AssistedLivingCare_AssistedLivingCareStreet/)
  text_field(:assisted_living_city, id: /AssistedLivingCare_AssistedLivingCareCity/)
  select(:assisted_living_state, id: /AssistedLivingCare_AssistedLivingCareState/, hooks: SELECT_FIELD_HOOKS)
  text_field(:assisted_living_zip, name: /AssistedLivingCare_AssistedLivingCareZip/)

  # Business Property Increased limit - DONE
  checkbox(:business_property_increased_limit, id: 'BusinessPropertyIncreasedLimitsSelected')
  select(:total_on_premise_limit, id: /BusinessPropertyIncreasedLimits_OnPremiseLimit/, hooks: SELECT_FIELD_HOOKS)

  # Business Pursuits - DONE
  checkbox(:business_pursuits, id: 'BusinessPursuitsSelected')
  text_field(:name_of_business, id: /NameOfBusiness/)
  select(:type_of_business, id: /TypeOfBusiness/, hooks: SELECT_FIELD_HOOKS)
  textarea(:business_desc, id: /DescriptionOfBusiness/)
  select(:liability_limit, id: /LiabilityLimit/, hooks: SELECT_FIELD_HOOKS)
  select(:med_pay, id: /MedPay/, hooks: SELECT_FIELD_HOOKS)

  # Canine Liability Exclusion - DONE
  checkbox(:canine_liability, id: 'CanineLiabilityExclusionSelected')
  text_field(:name_of_the_dog, id: /CanineName/)
  text_field(:breed_of_the_dog, id: /CanineBreed/)
  checkbox(:canine_exclusion_endorsement, id: 'CanineLiabilityExclusionSelected')
  checkbox(:course_of_construction, id: 'CourseofConstructionSelected')
  select(:course_of_construction_type, id: /CourseofConstruction_CourseofConstructionType/, hooks: SELECT_FIELD_HOOKS)
  radio_set(:general_contractor_no, xpath: './/label[contains(text(),"No")]/../../p-radiobutton[@id="CourseofConstruction_IsApplicantGeneralContractor_1"]')
  date_field(:date_of_construction, id: 'CourseofConstruction_StartDateofConstruction_1')
  date_field(:estimated_completion_date, id: 'CourseofConstruction_EstimatedCompletionDate_1')
  radio_set(:occupied_during_construction_no, xpath: './/label[contains(text(),"No")]/../../p-radiobutton[@id="CourseofConstruction_OccupiedDuringConstruction_1"]')

  # Contingent Worker Compensation - DONE
  checkbox(:home_contingent_worker_compensation, id: 'ContigentWorkersCompSelected')

  # Coverage C - Increased Limits of Liability - Firearms - DONE
  checkbox(:coverage_c_increased_limits_firearms, id: 'PropertySpecialLiabilityFirearmsSelected')
  text_field(:coverage_c_firearms_total_limit, xpath: './/label[contains(text(),"Total Limit")]//following-sibling::app-currency-input/input[1]')

  # Coverage C - Increased Limits of Liability - Jewelry, Watches & Furs - DONE
  checkbox(:coverage_c_increased_limits_jewelry, id: 'PropertySpecialLiabilityJewelryWatchesFursSelected')
  select(:coverage_c_jewelry_total_limit, id: /PropertySpecialLiabilityJewelryWatchesFurs_PropertySpecialLiabilityJewelryWatchesFursLimit/, hooks: SELECT_FIELD_HOOKS)

  # Coverage C - Increased Limits of Liability - Money - DONE
  checkbox(:coverage_c_increased_limits_money, id: 'PropertySpecialLiabilityMoneySelected', hooks: WFA_HOOKS)
  select(:coverage_c_money_total_limit, id: /PropertySpecialLiabilityMoney_PropertySpecialLiabilityMoneyLimit/, hooks: SELECT_FIELD_HOOKS)

  # Coverage C - Increased Limits of Liability - Portable Electronic Equipment in or upon a Motor Vehicle DONE
  checkbox(:coverage_c_increased_limits_electronic, id: 'PropertySpecialLiabilityVehicleElectronicEquipmentSelected')
  select(:coverage_c_electronic_total_limit, id: /PropertySpecialLiabilityVehicleElectronicEquipment_PropertySpecialLiabilityVehicleElectronicEquipmentLimit/, hooks: SELECT_FIELD_HOOKS)

  # Coverage C - Increased Limits of Liability - Securities DONE
  checkbox(:coverage_c_increased_limits_securities, id: 'PropertySpecialLiabilitySecuritiesSelected')
  text_field(:coverage_c_securities_total_limit, xpath: './/label[contains(text(),"Total Limit")]//following-sibling::app-currency-input/input[1]')

  # Coverage C - Increased Limits of Liability - Silverware, Goldware & Pewterware, - DONE
  checkbox(:coverage_c_increased_limits_silverware, id: 'PropertySpecialLiabilitySilverwareSelected', hooks: WFA_HOOKS)
  select(:coverage_c_silverware_total_limit, id: /PropertySpecialLiabilitySilverware_PropertySpecialLiabilitySilverwareLimit/, hooks: SELECT_FIELD_HOOKS)

  # Credit Card Forgery - DONE
  checkbox(:credit_card_forgery, id: 'CreditCardSelected', hooks: SCROLL_HOOKS)
  select(:credit_card_forgery_total_limit, id: /CreditCard_CreditCardLimit/, hooks: SELECT_FIELD_HOOKS)

  # Dock Coverage - DONE
  checkbox(:home_dock_coverage, id: 'DockSelected')

  # Earthquake - DONE
  checkbox(:earthquake, id: 'EarthquakeSelected')
  select(:earthquake_deductible, id: 'Earthquake_EarthquakeDeductible_1', hooks: SELECT_FIELD_HOOKS)
  select_button_set(:masonary_veneer_coverage, id: /Earthquake_MasonryVeneerCoverage/)

  def masonary_veneer_coverage=(opt)
    masonary_veneer_coverage_element.span(text: opt).click
  end

  text_field(:earthquake_year_built, id: /Earthquake_YearBuilt/)

  # Earthquake Loss Assessment - DONE
  checkbox(:earthquake_loss_assessment, id: 'EarthquakeLossAssessmentSelected')
  text_field(:earthquake_loss_assessment_total_limit, xpath: './/p-checkbox[label[contains(text(), "Earthquake Loss Assessment")]]//ancestor::app-dynamic-control//label[contains(text(),"Total Limit")]//following-sibling::app-currency-input/input[1]')
  text_field(:earthquake_loss_assessment_street, id: /addr1_EarthquakeLossAssessment_EarthquakeLossAssessmentAddress/)
  text_field(:earthquake_loss_assessment_city, id: /city_EarthquakeLossAssessment_EarthquakeLossAssessmentAddress/)
  select(:earthquake_loss_assessment_state, xpath: '//div[text()="State"]/../p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:earthquake_loss_assessment_zip, name: /postalCode_EarthquakeLossAssessment_EarthquakeLossAssessmentAddress/)

  # Farmers Personal Liability - Owned & Operated by Insured - Away From Premises - DONE
  checkbox(:farmers_personal_liability, id: 'FarmersPersonalLiabilitySelected')
  select_button_set(:farmers_personal_liability_type, id: /FarmersPersonalLiabilityType/)

  def farmers_personal_liability_type=(opt)
    farmers_personal_liability_type_element.span(text: opt).click
  end

  text_field(:farmers_total_acres, id: /FarmersPersonalLiabilityNumberOfAcres/)

  text_field(:farmers_num_of_employees_less_than_40, id: /FarmersPersonalLiabilityNumberOfEmpsWhoWork40DaysOrLess/)
  text_field(:farmers_num_of_employees_greater_than_40, id: /FarmersPersonalLiabilityNumberOfEmpsWhoWorkOver41To180Days/)
  text_field(:farmers_num_of_employees_greater_than_181, id: /FarmersPersonalLiabilityNumberOfEmpsWhoWorkOver180Days/)

  # Farmers Personal Liability - Rented to Others - Away From Premises - DONE
  text_field(:farmers_personal_liability_rented_street, id: /addr1_FarmersPersonalLiability/)
  text_field(:farmers_personal_liability_rented_city, id: /city_FarmersPersonalLiability/)
  select(:farmers_personal_liability_rented_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:farmers_personal_liability_rented_zip, name: /postalCode_FarmersPersonalLiability/)

  #Functional Replacement Cost Loss Settlement - DONE
  checkbox(:home_functional_replacement_loss, id: 'FunctionalReplacementCostLossSettlementSelected')
  checkbox(:functional_replacement_cost_loss_settlement, id: 'FunctionalReplacementCostLossSettlementSelected')
  radio_set(:are_there_swimming_pools_on_residence_premises, xpath: '.', item: { id: /ReplacementLossSettlementForNonBuildings_Pools/ })
  checkbox(:improvements_alterations_and_additions, id: 'AdditionsAlterationsSelected')
  text_field(:amount, xpath: './/label[contains(text(),"Amount")]//following-sibling::app-currency-input/input[1]')

  # Hydrostatic Pressure - DONE
  checkbox(:home_hydrostatic_pressure, id: 'HydrostaticPressureSelected')

  # Home Business Plus - DONE
  checkbox(:home_business_plus, id: 'HomeBusinessPlusSelected')
  select(:home_business_classification, id: /HomeBusinessPlus_HomeBusinessClassificationType/, hooks: SELECT_FIELD_HOOKS)
  text_field(:home_business_num_visitors, id: /HomeBusinessPlus_NumberOfVisitorsPerWeek/)
  text_field(:home_business_annual_gross_receipts, id: /HomeBusinessPlus_AnnualGrossReceipts/)
  select(:home_business_deductible, id: /HomeBusinessPlus_HomeBusinessPlusDeductible/, hooks: SELECT_FIELD_HOOKS)
  select(:home_business_personal_liability, id: /HomeBusinessPlus_HomeBusinessPlusLiabilityLimit/, hooks: SELECT_FIELD_HOOKS)
  select(:home_business_medical_payments, id: /HomeBusinessPlus_HomeBusinessMedPayLimit/, hooks: SELECT_FIELD_HOOKS)
  select(:home_business_cellular, id: /HomeBusinessPlus_HomeBusinessCellPhoneLimit/, hooks: SELECT_FIELD_HOOKS)

  # Incidental Farming Liability - Off Premise - DONE
  checkbox(:home_farming_liability_off_premise, id: 'IncidentalFarmingPersonalLiabilitySelected')
  select_button_set(:home_farming_liability_off_premise_type, xpath: '//*[contains(@id,"IncidentalFarmingLiabilityType") or contains(@id,"FarmersPersonalLiabilityType")]')
  div(:no_of_acres_error_message, xpath: './/input[contains(@id,"FarmersPersonalLiabilityNumberOfAcres")]/following-sibling::div')

  def home_farming_liability_off_premise_type=(opt)
    home_farming_liability_off_premise_type_element.span(text: opt).click
  end

  text_field(:home_farming_liability_off_premise_acres, id: /FarmersPersonalLiabilityNumberOfAcres/)

  text_field(:home_farming_liability_off_premise_emp_40_days_less, id: /FarmersPersonalLiabilityNumberOfEmpsWhoWork40DaysOrLess/)
  text_field(:home_farming_liability_off_premise_emp_40_days_to_180, id: /FarmersPersonalLiabilityNumberOfEmpsWhoWorkOver41To180Days/)
  text_field(:home_farming_liability_off_premise_emp_180_more, id: /FarmersPersonalLiabilityNumberOfEmpsWhoWorkOver180Days/)

  #textarea(:home_farming_liability_off_premise_description, id: /IncidentalFarmingLiabilityOffPremise_IncidentalFarmingOffPremiseDescription/)
  text_field(:home_farming_liability_off_premise_street, xpath: '//*[contains(@id, "addr1_IncidentalFarmingPersonalLiability") or contains(@id, "addr1_FarmersPersonalLiability")]')
  text_field(:home_farming_liability_off_premise_city, xpath: '//*[contains(@id, "city_FarmersPersonalLiability") or contains(@id, "city_IncidentalFarmingPersonalLiability")]')
  select(:home_farming_liability_off_premise_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_farming_liability_off_premise_zip, xpath: '//*[contains(@name, "postalCode_FarmersPersonalLiability") or contains(@name, "postalCode_IncidentalFarmingPersonalLiability")]')

  # Incidental Farming Liability - On Premise - DONE
  checkbox(:home_farming_liability_on_premise, id: 'IncidentalFarmingLiabilityOnPremiseSelected')
  textarea(:home_farming_liability_on_premise_description, id: /IncidentalFarmingLiabilityOnPremise_IncidentalFarmingOnPremiseDescription/)

  # Incidental Low Power Recreational Vehicle - DONE
  checkbox(:home_incidental_low_power_rec_vehicle, id: 'LowPowerMotorVehicleSelected')
  textarea(:home_incidental_low_power_rec_vehicle_description, id: /LowPowerMotorVehicle_LowPowerMotorVehicleDescription/)

  # Inland Flood - DONE
  checkbox(:home_inland_flood, id: 'InlandFloodSelected')
  radio(:home_inland_flood_five_years_no, xpath: '//p-radiobutton[contains(@id, "InlandFlood_AnyFloodClaims") and .//label[text()="No"]]')
  radio(:home_inland_flood_five_years_yes, xpath: '//p-radiobutton[contains(@id, "InlandFlood_AnyFloodClaims") and .//label[text()="Yes"]]')

  def home_inland_flood_five_years=(text)
    send("home_inland_flood_five_years_#{text.downcase}").select
  end

  select(:home_inland_flood_limit, id: /InlandFlood_InlandFloodLimit/, hooks: SELECT_FIELD_HOOKS)
  select(:home_inland_flood_deductible, id: /InlandFlood_InlandFloodDeductible/, hooks: SELECT_FIELD_HOOKS)

  # Landlord's Furnishings Coverage - DONE
  checkbox(:home_landlords_furnishings_coverage, id: 'LandlordFurnishingsSelected')
  select(:home_landlords_furnishings_coverage_limit, id: /LandlordFurnishings_LandlordFurnishingsLimit/, hooks: SELECT_FIELD_HOOKS)
  text_field(:home_landlords_furnishings_coverage_street, id: /addr1_LandlordFurnishings_LandlordFurnishingsAddress_1/)
  text_field(:home_landlords_furnishings_coverage_city, id: /city_LandlordFurnishings_LandlordFurnishingsAddress_1/)
  select(:home_landlords_furnishings_coverage_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_landlords_furnishings_coverage_zip, name: /postalCode_LandlordFurnishings_LandlordFurnishingsAddress_1/)

  # Liability Extension - Rented to Others -DONE
  checkbox(:home_liability_extension, id: 'LiabilityExtensionOccupiedSelected')
  select(:home_liability_extension_num_families, id: /AdditionalResidenceOccupiedNumberOfFamilies/, hooks: SELECT_FIELD_HOOKS)
  text_field(:home_liability_extension_street, id: /addr1_LiabilityExtensionOccupied/)
  text_field(:home_liability_extension_city, id: /city_LiabilityExtensionOccupied/)
  select(:home_liability_extension_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_liability_extension_zip, name: /postalCode_LiabilityExtensionOccupied/)

  #Liability Extension -Rented To Others - DONE
  checkbox(:home_liability_extension_rented_to_others, id: 'LiabilityExtensionRentedSelected', hooks: WFA_HOOKS)
  select(:home_liability_extension_rented_num_families, id: /AdditionalResidenceRentedNumberOfFamilies/, hooks: SELECT_FIELD_HOOKS)
  text_field(:home_liability_extension_rented_street, id: /addr1_LiabilityExtensionRented/)
  text_field(:home_liability_extension_rented_city, id: /city_LiabilityExtensionRented/)
  select(:home_liability_extension_rented_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_liability_extension_rented_zip, name: /postalCode_LiabilityExtensionRented/)

  # Limited Fungi Wet or Dry Rot or Bacteria Coverage - DONE
  checkbox(:home_limited_fungi_rot, id: 'LimitedFungiSelected', hooks: WFA_HOOKS)
  select(:home_limited_fungi_rot_liability_property, id: /LimitedFungi_PropertyCoverageLimit/, hooks: SELECT_FIELD_HOOKS)
  select(:home_limited_fungi_rot_liability_limit, id: /LimitedFungi_LiabilityCoverageLimit/, hooks: SELECT_FIELD_HOOKS)
  checkbox(:limited_fungi_wet_or_dry_rot_or_bacteria_coverage, id: 'LimitedFungiSelected')

  # Loss Assessment - Additional Locations - DONE
  checkbox(:home_loss_assessment_additional_locations, id: 'LossAssessmentAdditionalLocationsSelected')
  select(:home_loss_assessment_additional_locations_limit, id: /LossAssessmentAmount/, hooks: SELECT_FIELD_HOOKS)
  text_field(:home_loss_assessment_additional_locations_street, id: /addr1_LossAssessmentAdditionalLocations/)
  text_field(:home_loss_assessment_additional_locations_city, id: /city_LossAssessmentAdditionalLocations/)
  select(:home_loss_assessment_additional_locations_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_loss_assessment_additional_locations_zip, name: /postalCode_LossAssessmentAdditionalLocations/)

  # Loss Assessment - Residence Premises - DONE
  checkbox(:home_loss_assessment_resident_premises, xpath: '//*[@id="LossAssessmentSelected" or contains(@id,"LossAssessmentResidencePremisesSelected")]', hooks: WFA_HOOKS)
  select(:home_loss_assessment_resident_premises_limit, id: 'LossAssessmentResidencePremises_LossAssessmentResidencePremisesLimit_1', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_loss_assessment_resident_premises_limit_input, id: /LossAssessment_LossAssessmentResidencePremisesLimit/)
  checkbox(:loss_assessment_residence_premises, id: 'LossAssessmentSelected')
  textarea(:loss_assessment_residence_description, id: 'LossAssessment_LossAssessmentResidencePremisesDescription_1')

  # Manual Coverage - DONE
  checkbox(:home_manual_coverage, id: 'ManualEndorsementSelected')
  text_field(:home_manual_coverage_premium, xpath: './/label[contains(text(),"Premium")]//following-sibling::app-currency-input/input[1]')
  textarea(:home_manual_coverage_description, id: /ManualEndorsementDescription/)

  # Motorized Golf Cart - Physical Loss Coverage - DONE
  checkbox(:home_motorized_golf_cart, id: 'GolfCartPhysicalLossSelected')
  text_field(:home_motorized_golf_cart_year, id: /GolfCartYear/)
  text_field(:home_motorized_golf_cart_make, id: /GolfCartMake/)
  text_field(:home_motorized_golf_cart_model, id: /GolfCartModel/)
  text_field(:home_motorized_golf_cart_identification, id: /GolfCartIdentificationNumber/)
  text_field(:home_motorized_golf_cart_limit, xpath: './/p-checkbox[label[contains(text(), "Motorized Golf Cart - Physical Loss Coverage")]]//ancestor::app-dynamic-control//label[contains(text(),"Limit")]//following-sibling::app-currency-input/input[1]')

  # Ordinace or Law - Increased Limit - DONE
  checkbox(:home_ordinance_or_law, id: 'BuildingOrdinanceOrLawSelected', hooks: WFA_HOOKS)
  select(:home_ordinance_or_law_limit, id: /BuildingOrdinanceOrLaw_BuildingOrdinanceOrLawLimit/, hooks: SELECT_FIELD_HOOKS)
  checkbox(:ordinace_or_law_increased_limit, id: 'BuildingOrdinanceOrLawSelected')

  # Other Members of Insured's Household Coverage - DONE
  checkbox(:home_other_members_insureds_household, id: 'OtherMembersOfHouseHoldSelected')
  text_field(:home_other_members_insureds_household_total, id: /OtherMembersOfHouseHold_NumberOfOtherMembersOfHousehold/)
  text_field(:home_other_members_insureds_household_names, id: /OtherMembersOfHouseHold_OtherMembersName/)

  #Other Structures - Not Specifically Insured - Off Premise - DONE
  checkbox(:home_other_structures_insured_off_premise, id: 'OtherStructuresOffPremisesSelected')
  text_field(:home_other_structures_insured_off_premise_street, id: /addr1_OtherStructuresOffPremises_OtherStructuresOffPremisesAddress/)
  text_field(:home_other_structures_insured_off_premise_city, id: /city_OtherStructuresOffPremises_OtherStructuresOffPremisesAddress/)
  select(:home_other_structures_insured_off_premise_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_other_structures_insured_off_premise_zip, name: /postalCode_OtherStructuresOffPremises_OtherStructuresOffPremisesAddress/)

  #Other Structures - Rented to Others - Residence Premise - DONE
  checkbox(:home_other_structures_rented_premise, id: 'StructuresRentedToOthersSelected')
  text_field(:home_other_structures_rented_premise_limit, xpath: './/label[contains(text(),"Total Limit for Rented Structure")]//following-sibling::app-currency-input/input[1]')
  textarea(:home_other_structures_rented_premise_description, id: /StructuresRentedToOthersDescription/)
  select_button_set(:home_other_structures_rented_premise_families, id: /StructuresRentedToOthersNumOfFamilies/)

  def home_other_structures_rented_premise_families=(opt)
    home_other_structures_rented_premise_families_element.span(text: opt).click
  end

  span(:structures_rented_to_others_liability_limit, id: /StructuresRentedToOthersLiabilityLimit/)
  span(:structures_rented_to_others_medical_payments, id: /StructuresRentedToOthersMedicalPayments/)

  # Other Structures - Specifically Insured - DONE
  checkbox(:home_other_structures_specifically_insured, id: 'StructuresAwayFromResidenceSelected')
  select_button_set(:home_other_structures_specifically_insured_location, id: /StructuresAwayFromResidence_SpecificOtherStructuresLocation/) # took out ?
  def home_other_structures_specifically_insured_location=(opt)
    home_other_structures_specifically_insured_location_element.span(text: opt).click
  end

  text_field(:home_other_structures_specifically_insured_street, id: /addr1_StructuresAwayFromResidence/)
  text_field(:home_other_structures_specifically_insured_city, id: /city_StructuresAwayFromResidence/)
  select(:home_other_structures_specifically_insured_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_other_structures_specifically_insured_zip, name: /postalCode_StructuresAwayFromResidence/)
  text_field(:home_other_structures_specifically_insured_limit, xpath: './/p-checkbox[label[contains(text(), "Other Structures - Specifically Insured - Off Premise")]]//ancestor::app-dynamic-control//label[contains(text(),"Limit")]//following-sibling::app-currency-input/input[1]')
  textarea(:home_other_structures_specifically_insured_description, id: /StructuresAwayFromResidenceDescription/)

  #Other Structures Exclusion Endorsement - DONE
  checkbox(:home_other_structures_exclusion_endorsement, id: 'OtherStructuresExclusionEndorsementSelected')
  checkbox(:other_structures_exclusion_endorsement, id: 'OtherStructuresExclusionEndorsementSelected')
  textarea(:home_other_structures_exclusion_endorsement_description, id: /OtherStructuresExclusionEndorsement_StructureDescription/)
  checkbox(:replacement_cost_on_the_dwelling_additional_amount, xpath: '//*[@id="ReplacementCostOnDwellingSelected" or @id="ReplacementCostProtectionSelected"]')

  #Permitted Incidental Occupancies - In Residence - DONE
  checkbox(:home_permitted_incidental_occupancies_in_residence, id: 'PermittedIncidentalOccupanciesSelected')
  select_button_set(:home_permitted_incidental_occupancies_in_residence_location, id: /PermittedIncidentalOccupanciesLocationType/)

  def home_permitted_incidental_occupancies_in_residence_location=(opt)
    home_permitted_incidental_occupancies_in_residence_location_element.span(text: opt).click
  end

  select(:home_permitted_incidental_occupancies_in_residence_type, id: /PermittedIncidentalOccupanciesType/, hooks: SELECT_FIELD_HOOKS)
  textarea(:home_permitted_incidental_occupancies_in_residence_description, id: /BusinessDescription/)

  # Permitted Incidental Occupancies - In Residence
  text_field(:home_permitted_incidental_occupancies_in_residence_street, id: /addr1_PermittedIncidentalOccupancies/)
  text_field(:home_permitted_incidental_occupancies_in_residence_city, id: /city_PermittedIncidentalOccupancies/)
  select(:home_permitted_incidental_occupancies_in_residence_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_permitted_incidental_occupancies_in_residence_zip, name: /postalCode_PermittedIncidentalOccupancies/)

  # Permitted Incidental Occupancies - Other Residence
  # removed and merged above -- checkbox(:home_permitted_incidental_occupancies_other_residence, id: 'PermittedIncidentalOccupanciesInOtherResidenceSelected')
  # textarea(:home_permitted_incidental_occupancies_other_residence_description, id: /PermittedIncidentalOccupanciesInOtherResidence_DescriptionOfBusiness/)
  text_field(:home_permitted_incidental_occupancies_other_residence_street, id: /addr1_PermittedIncidentalOccupancies/)
  text_field(:home_permitted_incidental_occupancies_other_residence_city, id: /city_PermittedIncidentalOccupancies/)
  select(:home_permitted_incidental_occupancies_other_residence_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_permitted_incidental_occupancies_other_residence_zip, name: /postalCode_PermittedIncidentalOccupancies/)

  # Personal Cyber Protection - DONE
  checkbox(:home_personal_cyber_protection, id: 'PersonalCyberProtectionSelected')
  select(:home_personal_cyber_protection_amount, id: /PersonalCyberProtection_CyberProtectionAmount/, hooks: SELECT_FIELD_HOOKS)

  # Personal Injury - DONE
  checkbox(:home_personal_injury, id: 'PersonalInjurySelected')
  select_button_set(:home_personal_injury_type, id: /PersonalInjury_PersonalInjuryType/)

  def home_personal_injury_type=(opt)
    home_personal_injury_type_element.span(text: opt).click
  end

  # Personal Property Located in a Self-Storage Facility-Increased Limit - DONE
  checkbox(:home_property_located_self_storage, id: 'PropertyInSelfStorageSelected')
  text_field(:home_property_located_self_storage_limit, id: 'currency_2458undefined')
  #text_field(:home_property_located_self_storage_limit, xpath: './/label[contains(text(), "Limit included with Summit: $12,500  (25% of Coverage C - Contents)")]/../following-sibling::div/label//following-sibling::app-currency-input/input')
  label(:property_limit_included_message, xpath: '//*[@id = "PropertyInSelfStorageSelected"]/../../../..//label[contains(text(),"Limit included")]')
  div(:total_limit_error_message, class: /invalid/)

  #Personal Property-Increased Limit-Other Residences - DONE
  checkbox(:home_personal_property_other_residence, id: 'PropertyOtherResidenceIncreasedLimitsSelected')
  text_field(:home_personal_property_other_residence_limit, xpath: './/p-checkbox[label[contains(text(), "Personal Property-Increased Limit-Other Residences")]]//ancestor::app-dynamic-control//label[contains(text(),"Limit")]//following-sibling::app-currency-input/input[1]')
  text_field(:home_personal_property_other_residence_street, id: /PropertyOtherResidenceIncreasedLimits_AddressStreet/)
  text_field(:home_personal_property_other_residence_city, id: /PropertyOtherResidenceIncreasedLimits_AddressCity/)
  select(:home_personal_property_other_residence_state, id: /PropertyOtherResidenceIncreasedLimits_AddressState/, hooks: SELECT_FIELD_HOOKS)
  text_field(:home_personal_property_other_residence_zip, name: /PropertyOtherResidenceIncreasedLimits_AddressZipCode/)

  #New Xpath for Personal Property-Increased Limit-Other Residences
  text_field(:home_personal_property_other_residence_street_new, id: /addr1_PropertyOtherResidenceIncreasedLimits_PropertyOtherResidenceAddress/)
  text_field(:home_personal_property_other_residence_city_new, id: /city_PropertyOtherResidenceIncreasedLimits_PropertyOtherResidenceAddress/)
  select(:home_personal_property_other_residence_state_new, xpath: './/input[contains(@id,"state_PropertyOtherResidenceIncreasedLimits_PropertyOtherResidenceAddress")]/../../..', hooks: SELECT_FIELD_HOOKS)
  text_field(:home_personal_property_other_residence_zip_new, name: /postalCode_PropertyOtherResidenceIncreasedLimits_PropertyOtherResidenceAddress/)

  # Plus Ten ( NOT ON THE BOARD YET )
  checkbox(:home_plus_ten, id: 'PlusTenSelected')

  # Refrigerated Property - DONE
  checkbox(:home_refrigerated_property, id: 'RefrigeratedPropertySelected')

  # Rental Theft - DONE
  checkbox(:home_rental_theft, id: 'RentalTheftSelected')
  checkbox(:theft, id: 'TheftSelected')
  text_field(:on_premises, xpath: './/label[contains(text(),"On Premises")]//following-sibling::app-currency-input/input[1]')
  text_field(:off_premises, xpath: './/label[contains(text(),"Off Premises")]//following-sibling::app-currency-input/input[1]')

  # Replacement Cost Loss Settlement of Certain Non-Building Structures - DONE
  checkbox(:home_replacement_cost_loss_settlement_non_building_structures, id: 'ReplacementLossSettlementForNonBuildingsSelected')
  # radio(:home_replacement_cost_non_building_structures_pool, id: /ReplacementLossSettlementForNonBuildings_Pools/)
  def home_replacement_cost_loss_settlement_non_building_structures_pool=(text)
    option = elements(xpath: '//p-radiobutton[contains(@id, "ReplacementLossSettlementForNonBuildings_Pools")]').find {|item|item.label.text == text}
    option.label.click
  end
  # Replacement Cost on the Home-Additional Amount
  checkbox(:home_replacement_cost_on_home, id: 'ReplacementCostOnHomeSelected', hooks: WFA_HOOKS)
  select(:home_replacement_cost_on_home_total_percent, id: /ReplacementCostOnHome_TotalPercentageCoverage/, hooks: SELECT_FIELD_HOOKS)

  # Replacement Cost on Contents
  checkbox(:home_replacement_cost_on_contents, id: 'ReplacementCostOnContentsSelected')

  # Residence Employees -Additional Rate for More Than Two Employees - DONE
  checkbox(:home_residence_additional_rate, id: 'AdditionalResidenceEmployeesSelected')
  text_field(:home_residence_additional_rate_total_employees, id: /AdditionalResidenceEmployees_NumberEmployees/)

  # Sinkhole Collapse Coverage
  checkbox(:home_sinkhole_collapse_coverage, id: 'SinkHoleCollapseSelected')

  # Snowmobile Coverage DONE
  checkbox(:home_snowmobile_coverage, id: 'SnowmobileSelected', hooks: WFA_HOOKS)
  text_field(:home_snowmobile_coverage_year, id: /Snowmobile_1_Year/)
  text_field(:home_snowmobile_coverage_make, id: /Snowmobile_1_Make/)
  text_field(:home_snowmobile_coverage_model, id: /Snowmobile_1_Model/)
  text_field(:home_snowmobile_coverage_identification, id: /Snowmobile_1_IdentificationNumber/)
  text_field(:home_snowmobile_coverage_limit, xpath: './/p-checkbox[label[contains(text(), "Snowmobile Coverage")]]//ancestor::app-dynamic-control//label[contains(text(),"Limit")]//following-sibling::app-currency-input/input[1]')

  #Special Computer Coverage
  checkbox(:home_special_computer_coverage, id: 'SpecialComputerSelected')

  # Special Loss Settlement - DONE
  checkbox(:home_special_loss_settlement, id: 'SpecialLossSettlementSelected')
  select(:home_special_loss_settlement_total, id: /SpecialLossSettlement_PercentageReplacement/, hooks: SELECT_FIELD_HOOKS)

  # Student Away From Home
  checkbox(:home_student_away_from_home, id: 'StudentAwayFromHomeSelected')
  text_field(:home_student_away_from_home_student_name, id: /StudentAwayFromHome_StudentName/)
  text_field(:home_student_away_from_home_school, id: /StudentAwayFromHome_SchoolName/)
  text_field(:home_student_away_from_home_school_address, id: /StudentAwayFromHome_StudentAwayFromHomeStreet/)
  text_field(:home_student_away_from_home_school_city, id: /StudentAwayFromHome_StudentAwayFromHomeCity/)
  select(:home_student_away_from_home_school_state, id: /StudentAwayFromHome_StudentAwayFromHomeState/, hooks: SELECT_FIELD_HOOKS)
  text_field(:home_student_away_from_home_school_zip, name: /StudentAwayFromHome_StudentAwayFromHomeZip/)
  text_field(:number_of_students_away_from_home, id: /NumberOfStudentsAwayFromHome/)
  # Theft of Building Materials
  checkbox(:home_theft_of_building_materials, id: 'BuildingSuppliesTheftSelected')
  text_field(:home_theft_of_building_materials_limit, xpath: './/label[contains(text(),"Limit")]//following-sibling::app-currency-input/input')
  checkbox(:theft_of_building_materials, id: 'BuildingSuppliesTheftSelected')
  select(:building_material_total_limit, id: 'BuildingSuppliesTheft_TotalLimit_1')
  #
  # Theft of Personal Property Dwelling Under Construction
  checkbox(:home_theft_of_personal_property, id: 'PropertyTheftUnderConstructionSelected')
  text_field(:home_theft_of_personal_property_limit, xpath: './/label[contains(text(),"Limit")]//following-sibling::app-currency-input/input[1]')
  date_field(:home_theft_of_personal_property_inception, id: /PropertyTheftUnderConstruction_InceptionDate/)
  date_field(:home_theft_of_personal_property_expire, id: /PropertyTheftUnderConstruction_ExpirationDate/)
  #  #
  # Theft of Tools Optional Deductible
  checkbox(:home_theft_of_tools, id: 'ToolTheftSelected')
  select(:home_theft_of_tools_limit, id: /ToolTheft_Limit/, hooks: SELECT_FIELD_HOOKS)
  #
  # Utility Line Protection
  checkbox(:home_utility_line_protection, id: 'UtilityLineProtectionSelected')

  #-------------WATERCRAFT OPTIONAL COVERAGES--------------#
  # Emergency Service Expanded Coverage
  checkbox(:emergency_service_expanded_coverage, id: 'ExpandedEmergencyServiceSelected')
  select(:wes_total_limit, id: /ExpandedEmergencyService_TotalLimit/, hooks: SELECT_FIELD_HOOKS)
  label(:wes_limit_included, text: 'Limit included with Summit Boat Owner: $1,000')

  # Personal Effects
  checkbox(:personal_effects, id: 'PersonalEffectsSelected')
  text_field(:wpe_total_limit, xpath: './/div[contains(@class, "coverage") and .//label[contains(text(), "Personal Effects")]]/.//app-currency-input/input')
  label(:wpe_limit_included, text: 'Limit included with Summit Boat Owner: $1,500')
  b(:wpe_included, text: /(Included)/)

  #Boating Equipment Coverage Increase
  checkbox(:boating_equipment_coverage_increase, id: 'BoatingEquipmentSelected')
  text_field(:wbe_total_limit, xpath: './/div[contains(@class, "coverage") and .//label[contains(text(), "Boating Equipment Coverage Increase")]]/.//app-currency-input/input')
  text_field(:manual_coverage_premium, xpath: './/label[contains(text(),"Premium")]//following-sibling::app-currency-input/input[1]')
  textarea(:manual_coverage_description_field, id: /ManualEndorsementDescription_1/)

  span(:wbe_warning_msg, class: /p-inline-message/) #DDL  ng11
  #span(:wbe_warning_msg, class: /ui-message-text/) #DDL  old

  div(:wbe_included_limit_error_msg, text: /included limit/)
  div(:wbe_selected_limit_error_msg, text: /selected value/)
  label(:wbe_bt0100, text: /Limit included with BT0100/)

  #Animal - Exclusion Endorsement- DONE
  checkbox(:animal_exclusion, id: 'AnimalLiabilityExclusionSelected')

  #Sports Plus-DONE
  checkbox(:home_sports_plus, id: 'SportsPlusSelected')

  #Identity Fraud Protection-DONE
  checkbox(:home_identity_fraud_protection, id: 'IdentityFraudProtectionSelected')

  #Equipment Breakdown-Done
  checkbox(:home_equipment_breakdown, id: 'EquipmentBreakdownSelected')
  checkbox(:equipment_breakdown, id: 'EquipmentBreakdownSelected')

  #Other Structures - Specifically Insured - On Premise
  checkbox(:home_other_structures_specifically_insured_on_premise, id: 'SpecificOtherStructuresSelected')
  text_field(:home_other_structures_specifically_insured_limit_on_premise, xpath: './/p-checkbox[label[contains(text(), "Other Structures - Specifically Insured - On Premise")]]//ancestor::app-dynamic-control//label[contains(text(),"Limit")]//following-sibling::app-currency-input/input[1]')
  textarea(:home_other_structures_specifically_insured_description_on_premise, id: /SpecificOtherStructuresDescription/)
  checkbox(:other_structures_specifically_insured_on_premise, id: 'SpecificOtherStructuresSelected')
  text_field(:total_limit_other_structures, xpath: './/p-checkbox[label[contains(text(), "Other Structures - Specifically Insured - On Premise")]]//ancestor::app-dynamic-control//label[contains(text(),"Limit")]//following-sibling::app-currency-input/input[1]')

  #Condo exclusively rented
  checkbox(:condo_exclusively_rented, id: 'CondoExclusivelyRentedSelected')
  checkbox(:include_theft_coverage, id: /CondoExclusivelyRented_IncludeTheftCoverage/)

  def coverages_values
    existing = []
    existing << ['Corporate Auto Coverage', corporate_auto_coverage_element.value] if corporate_auto_coverage_element.present?
    existing << ['Extended Non-Owned Coverage', extended_non_owned_coverage_element.value] if extended_non_owned_coverage_element.present?
    existing << ['Manual Coverage', manual_coverage_element.value] if manual_coverage_element.present?
    existing << ['Mexico Coverage', mexico_coverage_element.value] if mexico_coverage_element.present?
    existing << ['Named Non-Owner Coverage', named_non_owner_coverage_element.value] if named_non_owner_coverage_element.present?
    existing << ['Other Structures - Rented to Others - Residence Premise', home_other_structures_rented_premise_element.value] if home_other_structures_rented_premise_element.present?
    return existing
  end

  def coverages
    existing = []
    existing << ['Corporate Auto Coverage'] if corporate_auto_coverage_element.present?
    existing << ['Extended Non-Owned Coverage'] if extended_non_owned_coverage_element.present?
    existing << ['Manual Coverage'] if manual_coverage_element.present?
    existing << ['Mexico Coverage'] if mexico_coverage_element.present?
    existing << ['Named Non-Owner Coverage'] if named_non_owner_coverage_element.present?
    existing << ['Other Structures - Rented to Others - Residence Premise'] if home_other_structures_rented_premise_element.present?
    return existing
  end

  def home_optional_coverages_labels
    #divs(xpath: './/div[p-checkbox]')
    labels(xpath: './/div/p-checkbox/label')
  end

  def home_optional_coverages
    options = home_optional_coverages_labels.map { |e| e.text }.reject { |e| e.empty? }
    options
  end

  # Return all the elements containing currency input text field
  def get_currency_input_field_elements
    elements(xpath: './/label[contains(text(),"Limit") or contains(text(), "Accounts Receivable") or contains(text(), "On Premises") or contains(text(), "Off Premises")]//following-sibling::app-currency-input/input[1]')
  end

  # Clear input field of all the elements containing currency input text field
  def clear_currency_input_field_elements
    get_currency_input_field_elements.each do |ele|
      # This is a temporary work around for clearing the currency input field as '.clear' on element is not working
      ele.send_keys(:control, a)
    end
  end
end
