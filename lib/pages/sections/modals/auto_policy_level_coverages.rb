# frozen_string_literal: true

class AutoPolicyLevelCoveragesModal < BaseModal
  # toggle_button_list(:enhanced_coverage, id: 'EnhancedAutoCoverageInput')
  # toggle_button_list(:liability_type, id: 'LiabilityType')
  # select_list(:bodily_injury_liability, id: 'PersonalAutoBILiability')
  # select_list(:property_damage_liability, id: 'PDLiability')
  # select_list(:medical_payments, id: 'MedicalPayments')
  # select_list(:combined_single_limit, id: 'CombinedSingleLimit')
  # toggle_button_list(:uninsured_motorist, id: 'UMUIM')
  # select_list(:uninsured_motorist_limit, id: 'UMUIMLimit')
  # select_list(:uninsured_motorist_property_liability, id: 'UMUIMPD')
  # select_list(:uninsured_motorist_property_deductible, id: 'UMUIMPDDeductible')
  #
  # ## Note Decline Medical Coverage / Decline Property Damage Checkboxes are flaky,
  # #  I resorted to clicking the label instead, comenting out the checkbox.
  # # checkbox(:decline_medical_coverage, id: 'DeclineMedicalCoverage')
  # # checkbox(:decline_property_damage_coverage, id: 'DeclinePropertyDamageCoverage')
  # #
  # label(:decline_medical_coverage, xpath: '//label[@for="DeclineMedicalCoverage"]', default_method: :click)
  # label(:decline_property_damage_coverage, xpath: '//label[@for="DeclinePropertyDamageCoverage"]', default_method: :click)
  #
  # toggle_button_list(:uninsured_underinsured_type, id: 'UninsuredUnderinsuredType')
  #
  section(:address_details, AddressDetailsSection, id: /addressFields/)
  radio_set(:enhanced_coverage, xpath: './/label[contains(text(), "nhanced")]/..')
  radio(:auto_plus, text: 'Auto Plus')
  radio(:summit, text: 'Summit')
  radio(:signature, text: 'Signature')
  radio(:decline_enhanced_auto_coverage, text: 'None')
  checkbox(:named_non_owner, id: 'NamedNonOwnerSelected')
  label(:named_non_owner_label, xpath: './/p-selectbutton[contains(@id, "NamedNonOwner")]/../label')
  select_button_set(:named_individual_resident_relatives, xpath: '//p-selectbutton[contains(@id,"NamedNonOwner_NamedNonOwnerIndividualOrRelativesOption")]/div')
  button(:save_and_close_btn, xpath: '//p-button[@id="SaveandClose"]/button')
  select(:medical_payments, xpath: './/app-dynamic-control[.//label[text()="Medical Payments"]]/.//p-dropdown')
  #toggle_switch(:medical_payments_coverage, xpath: '//*[text()="Medical Payments"]/parent::div/following-sibling::div/p-inputswitch')
  checkbox(:medical_payments_coverage, xpath: './/p-checkbox[label[contains(text(), "Medical Payments")]]')

  select(:bodily_injury_liability, xpath: '//label[text()="Bodily Injury Liability"]/following-sibling::div/p-dropdown')
  select(:property_damage_liability, xpath: '//label[text()="Property Damage Liability"]/following-sibling::div/p-dropdown')
  select(:bodily_injury_limit, xpath: '//label[text()="Bodily Injury Limit"]/following-sibling::div/p-dropdown')

  select(:uninsured_underinsured_limit, id: 'UninsuredAndUnderInsuredSingleLimit')
  select(:uninsured_underinsured_deductible, xpath: '//label[text()="Deductible"]/following-sibling::div/p-dropdown')

  select(:combined_single_limit, id: /CombinedSingleLimit/)

  #toggle_switch(:uninsured_underinsured_coverage, xpath: '//*[text()="Uninsured / Underinsured Coverage"]/parent::div/following-sibling::div/p-inputswitch')
  checkbox(:uninsured_underinsured_coverage, xpath: '//p-checkbox[label[contains(text(), "Uninsured / Underinsured Coverage")]]')

  select_button_set(:uninsured_underinsured_type, xpath: '//*[text()="Uninsured Motorist"]//parent::div/parent::div') #is this an ordering thing?

  #toggle_switch(:uninsured_underinsured_property_damage, xpath: '//*[text()="Uninsured And Underinsured Property Damage"]/parent::div/following-sibling::div/p-inputswitch')
  checkbox(:uninsured_underinsured_property_damage, xpath: '//p-checkbox[label[contains(text(), "Property Damage")]]')
  checkbox(:include_property_damage_coverage, xpath: './/p-checkbox[label[contains(text(), "Include Property Damage Coverage")]]')
  select(:property_damage_deductible, xpath: './/label[text()="Property Damage Deductible"]/following-sibling::div/p-dropdown')
  select(:total_limit_property_damage_coverage, xpath: '(//label[text()="Total Limit"]/following-sibling::div/p-dropdown)[1]')

  #def uninsured_underinsured_property_damage?
  #  binding.pry
  #end

  toggle_button_list(:uninsured_underinsured_motorist, xpath: '//label[text()="Uninsured / Underinsured Coverage"]/following-sibling::div/p-selectbutton/div')
  select_button_set(:split_combined_single_limit, xpath: '//*[text()="Split Limits"]//parent::div/parent::div')

  select(:uninsured_motorist_property_liability, id: /UninsuredMotoristPropertyDamageLimit/)
  select(:uninsured_motorist_property_deductible, id: /UninsuredPropertyDamageDeductible/)

  label(:uninsured_motorist_property_damage_label, text: /Property Damage Deductible/)
  select(:uninsured_underinsured_property_damage_deductible, id: /UMUIMPDDeductible/)
  select(:uninsured_property_damage_deductible, id: /UMPDDeductible/)
  select(:uninsured_motorist_property_damage_deductible, id: 'UninsuredPropertyDamageDeductible')

  ## Controls for HOME ###
  text_field(:coverage_a, xpath: './/div[label[contains(text(), "Coverage A")]]/.//app-currency-input/input')
  text_field(:coverage_b, xpath: './/div[label[contains(text(), "Coverage B")]]/.//app-currency-input/input')
  text_field(:coverage_c, xpath: './/div[label[contains(text(), "Coverage C")]]/.//app-currency-input/input')
  text_field(:coverage_d, xpath: './/div[label[contains(text(), "Coverage D")]]/.//app-currency-input/input')
  select(:coverage_e_personal, id: /PersonalLiability_CoverageLimit/)
  select(:coverage_f_medical, id: /MedicalPayments_CoverageLimit/)
  select(:deductible, id: /Dwell_Deductible/)
  select(:wind_hail_deductible, id: /Dwell_WindHailDeductible/)
  checkbox(:water_backup_sump, id: 'WaterBackupSumpDischargeSelected')
  text_field(:water_backup_limit, id: /currency_2509undefined/)
  select(:water_backup_deductible, id: /WaterBackupDeductible/)
  checkbox(:protected_devices, id: /ProtectiveDevicesSelected/)
  checkbox(:essential_circuit_standby_generator, id: /DiscountEssentialCircuit/)
  checkbox(:non_electrical_backup_sump, id: /DiscountBackupSumpPump/)
  checkbox(:generator_portable, id: /DiscountGeneratorPortable/)
  checkbox(:local_burglar_alarm, id: /ProtectiveDevices_LocalBurglarAlarm/)

  ## Controls for UMBRELLA ###
  checkbox(:umbrella_enhanced_coverage, id: 'PersonalUmbrellaSummitSelected')
  select(:total_limit_liability, id: /PersonalUmbrella_TotalLimitOfLiability/)
  checkbox(:personal_injury_coverage, id: /PersonalUmbrellaPersonalInjurySelected/)
  checkbox(:umbrella_personal_injury, id: 'PersonalUmbrellaPersonalInjurySelected')
  checkbox(:umbrella_uninsured_underinsured, id: 'UninsuredUnderinsuredGroupRelationshipSelected')
  toggle_button_list(:uninsured_toggle, xpath: '//p-selectbutton[@id="UninsuredUnderinsuredGroupRelationshipMemberGroups"]/div')
  select(:total_limit, id: /(Uninsured|UninsuredUnderinsured)TotalLimit/)

  ## used for fetching the value of fields
  div(:total_limit_liability_value, xpath: '//label[contains(text(),"Total Limit of Liability")]/following::div')
  div(:total_limit_value, xpath: '//label[contains(text(),"Uninsured / Underinsured Coverage")]/following::p-dropdown/..')




  ## Controls for WATERCRAFT ###
  checkbox(:watercraft_enhanced_coverage, id: 'SummitBoatownerSelected')
  checkbox(:watercraft_personal_liability, id: 'PersonalLiabilitySelected')
  select(:wpl_coverage_x, id: /PersonalLiability_PersonalLiabilityLimit/)
  checkbox(:watercraft_medical_payments, id: 'MedicalPaymentsSelected')
  select(:wmp_coverage_y, id: /MedicalPayments_MedicalPaymentsLimit/)
  checkbox(:watercraft_uninsured_boaters_coverage, id: 'IncreasedUninsuredBoatersCoverageSelected')
  span(:error_message_text, class: /p-inline-message-text/)
  span(:personal_liability_value, id: /PersonalLiability_PersonalLiabilityLimit/)
  span(:medpay_value, id: /MedicalPayments_WatercraftMedicalPaymentsLimit/)

  #DWELLING##
  checkbox(:coverage_a_dwelling, id: /ReplacementCostSelected/)
  checkbox(:coverage_c_dwelling, id: /PersonalPropertySelected/)
  checkbox(:coverage_d_dwelling, id: /FairRentalValueSelected/)
  checkbox(:coverage_e_dwelling, id: /AdditionalLivingExpenseSelected/)
  checkbox(:coverage_l_dwelling, id: /PersonalLiabilitySelected/)
  checkbox(:coverage_m_dwelling, id: /MedicalPaymentsSelected/)
  text_field(:coverage_d_total_limit, xpath: './/div[contains(@class, "coverage") and .//label[contains(text(), "Coverage D")]]/.//app-currency-input/input')
  text_field(:coverage_e_total_limit, xpath: './/div[contains(@class, "coverage") and .//label[contains(text(), "Coverage E")]]/.//app-currency-input/input')
  text_field(:coverage_a_dwelling_text, xpath: './/div[contains(@class, "coverage") and .//label[contains(text(), "Coverage A")]]/.//app-currency-input/input')
  text_field(:coverage_c_dwelling_text, xpath: './/div[contains(@class, "coverage") and .//label[contains(text(), "Coverage C")]]/.//app-currency-input/input')
  select(:coverage_l_dwelling_limit, id: /PersonalLiability_CoverageLimit/)
  select(:address_residence_premise, xpath: '//div[contains(text(),"Address of Residence")]/../../following-sibling::div[contains(@class,"p-align-start")]//p-dropdown[@placeholder="Select"]')

  # this is to keep the sanctity of the old fixture files.
  def liability_type=(text)
    self.split_combined_single_limit=text
  end

  def enhanced_coverage=(opt)
    send("#{opt.downcase}").select
  end

  def decline_medical_coverage=(bool)
    #this works a bit different than old system - true means turn on the toggle
    # old system, true means decline.
    if bool.to_s == 'true'
      self.medical_payments_coverage=false
    else
      self.medical_payments_coverage=true
    end
  end

  def select_uninsured_motorist(txt)
    uninsured_underinsured_motorist_element.span(text: txt).click
  end

  def select_split_combined_limit(txt)
    split_combined_single_limit_element.span(text: txt).click
  end

  def named_non_owner_coverage=(bool)
    if bool
      self.named_non_owner=true
    else
      self.named_non_owner=false
    end
  end

  def select_uninsured_underinsured_coverage=(txt)
    uninsured_toggle_element.span(text: txt).click
  end
  # def uninsured_motorist=(option)
  #   uninsured_underinsured_type_element.set option
  # end
  #
  # def decline_medical_coverage=(val)
  #   decline_medical_coverage if val
  # end
  #
  # def decline_property_damage_coverage=(val)
  #   decline_property_damage_coverage if val
  # end
end
