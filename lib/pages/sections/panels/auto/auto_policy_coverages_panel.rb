# frozen_string_literal: true

class AutoPolicyCoveragesPanel < BasePanel
  # DS Note:  These are fragile and will break if the text is not in a strong or the text changes
  div(:bodily_injury_liability, xpath: '//div/label/strong[contains(text(), "Bodily Injury Liability")]/following::div')
  div(:medical_payments, xpath: '//div/label/strong[contains(text(), "Medical Payments")]/following::div')
  div(:property_damage_liability, xpath: '//div/label/strong[contains(text(), "Property Damage Liability")]/following::div')
  div(:enhanced_coverage, xpath: '//div/label/strong[contains(text(), "Enhanced Auto Coverage")]/following::div')
  div(:combined_single_limit, xpath: '//div/label/strong[contains(text(), "Combined Single Limit")]/following::div')
  div(:uninsured_motorist_option, xpath: '//div/label/strong[contains(text(), "Uninsured/Underinsured Motorist Option")]/following::div')
  div(:uninsured_motorist_property_limit, xpath: '//div/label/strong[contains(text(), "Uninsured/Underinsured Motorist Property Damage Limit")]/following::div')
  div(:uninsured_motorist_property_deductible, xpath: '//div/label/strong[contains(text(), "Uninsured/Underinsured Motorist Property Damage Deductible")]/following::div')
  div(:uninsured_motorist_limit, xpath: '//div/label/strong[contains(text(), "Uninsured/Underinsured Motorist Limit")]/following::div')
  button(:modify)

  ## -----HOME ITEMS for the info panel --------------##
  #
  ##div(:home_medical_payments, xpath: '//div/strong[contains(text(), "Medical Payments")]/following::div')
  div(:replacement_cost, xpath: '//div/strong[contains(text(), "Replacement Cost")]/following::div')
  div(:other_structures, xpath: '//div/strong[contains(text(), "Other Structures")]/following::div')
  div(:contents, xpath: '//div/strong[contains(text(), "Contents")]/following::div')
  div(:loss_of_use, xpath: '//div/strong[contains(text(), "Loss of use")]/following::div')
  div(:home_personal_liability, xpath: '//div/strong[contains(text(), "Personal Liability")]/following::div')
  div(:home_deductible, xpath: '//div/strong[contains(text(), "Deductible")]/following::div')
  div(:home_medical_payments, xpath: '//div/strong[contains(text(), "Medical Payments")]/following::div')
  div(:deductible, xpath: '//div/strong[contains(text(), "Deductible")]/following::div')

end
