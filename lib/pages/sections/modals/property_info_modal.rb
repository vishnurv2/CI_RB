# frozen_string_literal: true

class PropertyInfoModal < BaseModal
  select_button_set(:residential_location_type, id: 'selectedPropertyType')
  select(:form_type, id: 'formType')
  button(:prefill_property, xpath: '//p-button[contains(@id, "prefillPropertyInfo")]/button', hooks: WFA_HOOKS)
  text_field(:year_built_field, name: 'yearBuilt', hooks: WFA_HOOKS)
  #text_field(:date_purchased, id: /datePurchased/, hooks: WFA_HOOKS)
  radio(:under_construction_yes, id: 'underConstructionY')
  select(:course_of_construction_type, id: 'courseOfConstructionType')
  date_field(:start_date_of_construction, id: 'startDateOfConstruction')
  date_field(:estimated_completion_date, id: 'estimatedCompletionDate')
  radio(:applicant_general_contractor_yes, id: 'isGeneralContractorY')
  radio(:applicant_general_contractor_no, id: 'isGeneralContractorN')
  radio(:under_construction_no, id: 'underConstructionN')
  select(:premise_use, id: 'dwellingUseCode')
  radio(:initial_residence_extends_liability_yes, id: 'InitialResidenceExtendsLiabilityIndY')
  radio(:initial_residence_extends_liability_no, id: 'InitialResidenceExtendsLiabilityIndN')
  select_button_set(:number_of_families, id: 'numFamilies')
  text_field(:number_of_family_units, id: 'numberOfFamilyUnits')
  select_button_set(:number_of_stories, id: 'numStories')
  select(:roof_type, id: 'roofMaterialCode')
  #select_button_set(:roof_updates, id: 'roofUpdates')
  #text_field(:roof_updated_year_field, name: 'roofUpdatedYear')
  select(:structure_type, id: 'structureType')
  select(:construction_type, id: 'constructionCode')
  select_button_set(:distance_from_water, id: 'distanceFromWaterSource')
  select(:protection_class_select, id: 'protectionClassCode')
  radio(:protection_class_override_yes, id: 'protectionClassOverrideY')
  radio(:protection_class_override_no, id: 'protectionClassOverrideN')
  checkbox(:protection_class_override_checkbox, xpath: './/p-checkbox[../span[contains(text(), "Protection Class Override")]]')

  select(:primary_heat, id: 'primaryHeatCode')
  select(:secondary_heat, id: 'supplementalHeatCode')
  select(:fuel_storage_location, id: 'fuelStorageLocation')
  #questions
  radio(:solid_fuel_heating_appliance_yes, id: 'solidFuelHeatingApplianceY')
  radio(:solid_fuel_heating_appliance_no, id: 'solidFuelHeatingApplianceN')
  radio(:swimming_pool_premises_yes, id: 'swimmingPoolY')
  radio(:swimming_pool_premises_no, id: 'swimmingPoolN')
  radio(:trampoline_premises_yes, id: 'trampolineY')
  radio(:trampoline_premises_no, id: 'trampolineN')

  text_field(:fire_district_code, id: 'fireDistrictCode')
  text_field(:responding_fire_station, id: 'respondingFireStation')

  #dwelling
  select(:rating_tier, id: 'ratingTier')
  select(:premise_address, xpath: './/app-address//p-dropdown')
  radio(:seasonal_dwelling_yes, id: 'seasonalDwellingY')
  radio(:seasonal_dwelling_no, id: 'seasonalDwellingN')
  select(:occupancy, id: /occupancyTypeCode/)

  def protection_class=(pc)
    unless protection_class_select_element.present?
      protection_class_override_checkbox.check
    end
    protection_class_select.set(pc)
  end

  def initial_residence_extends_liability=(answer)
    send("initial_residence_extends_liability_#{answer.downcase}").select
  end
  
  def protection_class_override=(answer)
    send("protection_class_override_#{answer.downcase}").select
  end

  def under_construction=(answer)
    send("under_construction_#{answer.downcase}").select
  end

  def applicant_general_contractor=(answer)
    send("applicant_general_contractor_#{answer.downcase}").select
  end

  def seasonal_dwelling=(answer)
    send("seasonal_dwelling_#{answer.downcase}").select
  end

   def year_built=(year)
     # This is a hack for now, somethings is off with this input field.....
     2.times do
       year_built_field_element.click
       year_built_field_element.set('')
       year_built_field_element.send_keys("#{year}")
     end
   end

  #def updated_roof_year=(year)
    # This is a hack for now, somethings is off with this input field.....
  #  2.times do
  #    roof_updated_year_field_element.click
  #    roof_updated_year_field_element.set('')
  #    roof_updated_year_field_element.send_keys("#{year}")
  #  end
  #end

  def prefill_property_info=(ans)
    if ans
      prefill_property_element.click if !year_built_field_element.present?
      Watir::Wait.until(timeout: 120) { year_built_field_element.present? }
    end
  end

  def solid_fuel_heating_appliance=(answer)
    send("solid_fuel_heating_appliance_#{answer.downcase}").select
  end

  def swimming_pool_premises=(answer)
    send("swimming_pool_premises_#{answer.downcase}").select
  end

  def trampoline_premises=(answer)
    send("trampoline_premises_#{answer.downcase}").select
  end
end
