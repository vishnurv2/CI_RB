# frozen_string_literal: true

class UnderwritingQuestionProductRow < BaseSection
  select(:product, id: /Product/)
end

class UnderwritingQuestionPolicyNumberRow < BaseSection
  text_field(:policy_number, id: /Textbox/)
end

class UnderwritingQuestionDescriptionRow < BaseSection
  textarea(:description, id: /Textarea/)
end

class UnderwritingQuestionDateRow < BaseSection
  date_field(:date_of_loss, id: /DateofLoss/)
end

class UnderwritingQuestionSelectRow < BaseSection
  select(:type_of_loss, id: /TypeofLoss/)
end

class UnderwritingQuestionCurrencyRow < BaseSection
  text_field(:loss_amount, id: /LossAmount/)
end

class UnderwritingQuestionRow < BaseSection #Generic - all sub elements possible
  div(:question, class: /required/)
  radio_set(:answer, xpath: './/*')
  span(:flag, class: /color-red/)
  radio_set(:does_nanny_have_auto_insurance, id: /DoesNannyHaveAutoInsurance/)
  radio_set(:does_nanny_operate_insured_vehicle, id: /DoesNannyOperateInsuredVehicle/)
  sections(:products, UnderwritingQuestionProductRow, xpath: '.', item: { xpath: './/p-dropdown[contains(@id,"Product")]/../../..', how: :divs })
  sections(:policy_numbers, UnderwritingQuestionPolicyNumberRow, xpath: '.', item: { xpath: './/input[contains(@id,"Textbox")]/../../..', how: :divs })
  sections(:descriptions, UnderwritingQuestionDescriptionRow, xpath: '.', item: { xpath: './/textarea[contains(@id,"Textarea")]/../../..', how: :divs })

  #UMBRELLA
  radio_set(:dogs_on_premise, id: /Dogsonpremises/)
  radio_set(:dog_breed, id: /Dogbreed/)
  radio_set(:injury_to_person, id: /Injurytoperson/)
  radio_set(:approved_fence, id: /ApprovedFence/)
  radio_set(:diving_board_slide_or_inflatable, id: /DivingboardSlideorInflatable/)
  radio_set(:am_best_rating, id: /AMBestRating/)
  radio_set(:exotic_pets, id: /Exoticpetsonpremise/)
  textarea(:exotic_pets_text, id: /Textarea-Exoticpettype/)
  radio_set(:fuel_storage_tank, id: /FuelStorageTankOnPremises/)
  select(:tank_location, id: /Dropdown-LocationOfTank/)
  text_field(:age_of_tank, id: /Textbox-TankAge/)
  radio_set(:history_of_leaking, id: /HistoryOfLeaking/)
  radio_set(:service_contract, id: /ServiceContract/)
  button(:add_another, xpath: './/p-button[contains(@id,"AddAnother-LiabilityLoss")]/button')
  radio_set(:work_from_home_residents, id: /Residentsworkfromhome/)
  textarea(:type_of_business, id: /Textarea-Expliantypeofbusiness/)
  radio_set(:flooding_fire_landslide, id: /AnyFloodingFireLandslide/)
  textarea(:explanation_for_hazard, id: /Textarea-AnyFloodingFireLandslideExplain/)
  radio_set(:liability_loss, id: /LiabilityLoss/)
  radio_set(:engage_in_regular_activities, id: /HoldPositioninPublicOffice/)
  radio_set(:pending_litigation, id: /PendingLitigation/)
  radio_set(:restrict_coverage, id: /UnderlyingPolicyEliminateorRestrictCoverage/)
  radio_set(:residence_employee, id: /ResidenceEmployee/)
  radio_set(:libel_or_slander, id: /beensuedforlibelorslander/)
  radio_set(:coverage_canceled_or_non, id: /AnyCoverageCanceledOrNonRenewedInPast3Years/)
  sections(:date_section, UnderwritingQuestionDateRow, xpath: '.', item: { xpath: './/p-calendar[contains(@id,"Date")]/../../..', how: :divs })
  sections(:select_type_section, UnderwritingQuestionSelectRow, xpath: '.', item: { xpath: './/p-dropdown[contains(@id,"Dropdown")]/../../..', how: :divs })
  sections(:currency_section, UnderwritingQuestionCurrencyRow, xpath: '.', item: { xpath: './/input[contains(@id,"currency")]/../../..', how: :divs })

  #Watercraft
  radio_set(:chartered_boat, id: /chartered/)
  radio_set(:existing_damage, id: /ExistingDamage/)
  radio_set(:coverage_cancelled, id: /CoverageCancelled/)
  radio_set(:commercial_or_business, id: /CommercialorBusiness/)
  radio_set(:used_as_residence, id: /UsedasResidence/)
  radio_set(:additional_owners, id: /AdditionalOwners/)
  radio_set(:suspended_revoked, id: /SuspendedRevoked/)
  textarea(:explanation_fields, xpath: './/div[contains(@class, "control-label required")]/../../following-sibling::div//textarea')

  #Home
  div(:any_dogs_kept_on_premises, text: /Are any of the dogs, including a mix of one or more of these breeds, kept on premises?/)
  radio_set(:do_customers_come_to_home, id: /DoCustomersComeToHome/)
  select(:how_often, id: /HowOften/)

  select(:driver_with_license_suspended, id: /Dropdown-DriverLicenseRevoked/)
  textarea(:date_and_circumstances_of_suspension_revocation, id: /Textarea-DateSuspensionOrRevocation/)

  #auto
  select(:driver_suspended_revoked, id: /Dropdown-Driver/)
  date_field(:date_of_suspended_revoked, id: /Date-DateSuspensionOrRevoke/)
  text_field(:reason_for_suspension, id: /Textbox-Reason/)

  radio_set(:vehicles_used_for_rural_postal_delivery, id: /VehiclesUsedForRuralPostalDelivery/)
  select(:vehicle_used, id: /Dropdown-VehicleUsed/)

  def answer_selected
    answer.div(class: /p-radiobutton-checked/).parent.label.text
  end

  def does_nanny_have_auto_insurance_text
    does_nanny_have_auto_insurance.div(class: /p-radiobutton-checked/).parent.parent.label.text
  end

end

class QuestionsPanel < BasePanel
  #data_grid(:questions_grid, UnderwritingQuestionRow)# was "questions_grid" prior to Angular AMN 1-22-2020 # , item: { xpath: '//*[@id="DataTables_Table_0"]/tbody/tr' })
  sections(:questions_grid, UnderwritingQuestionRow, xpath: '.', item: { xpath: './/div[contains(@class,"p-panel-content")]//form/div', how: :divs })
end

class AllProductsQuestionsPanel < QuestionsPanel
  #link(:edit, id: 'lnkOpenModalAllProducts', default_method: :click, hooks: WFA_HOOKS)
  button(:save_and_edit, xpath: '//p-button[contains(@id, "Save_Account")]/button')
  checkbox(:acknowledge, id: /acknowledge/)
  label(:acknowledge_text, class: /lbl/)
  div(:disabled, class: /ui-state-disabled/)
  textarea(:explanation_field, xpath: './/div[contains(@class, "control-label required")]/../../following-sibling::div//textarea')
end

class AutoQuestionsPanel < QuestionsPanel
  #link(:edit, id: /lnkOpenModalProduct_/, default_method: :click, hooks: WFA_HOOKS)
  button(:save_and_edit, xpath: './/p-button[contains(@id, "Save_Policy")]/button')
  span(:save, text: 'Save')
  checkbox(:acknowledge, id: /acknowledge/)
  label(:acknowledge_text, class: /lbl/)
  div(:disabled, class: /ui-state-disabled/)
  span(:header_text, class: /header-text/)
  textarea(:explanation_field, xpath: './/div[contains(@class, "control-label required")]/../../following-sibling::div//textarea')
end

class HomeOwnersQuestionsPanel < QuestionsPanel
  button(:save_and_edit, xpath: '//p-button[contains(@id, "Save_Policy")]/button')
  checkbox(:acknowledge, id: /acknowledge/)
  span(:save, text: 'Save')
  label(:acknowledge_text, class: /lbl/)
  div(:disabled, class: /ui-state-disabled/)
  span(:header_text, class: /header-text/)
end

class ScheduledPropertyQuestionsPanel < QuestionsPanel
  #link(:edit, id: /lnkOpenModalProduct_/, default_method: :click, hooks: WFA_HOOKS)
  button(:save_and_edit, xpath: '//p-button[contains(@id, "Save_Policy")]/button')
  span(:save, text: 'Save')
  checkbox(:acknowledge, id: /acknowledge/)
  label(:acknowledge_text, class: /lbl/)
  div(:disabled, class: /ui-state-disabled/)
  span(:header_text, class: /header-text/)
end

class WatercraftQuestionsPanel < QuestionsPanel
  button(:save_and_edit, xpath: '//p-button[contains(@id, "Save_Policy")]/button')
  span(:save, text: 'Save')
  checkbox(:acknowledge, id: /acknowledge/)
  label(:acknowledge_text, class: /lbl/)
  div(:disabled, class: /ui-state-disabled/)
  span(:header_text, class: /header-text/)
end

class DwellingQuestionsPanel < QuestionsPanel
  button(:save_and_edit, xpath: '//p-button[contains(@id, "Save_Policy")]/button')
  span(:save, text: 'Save')
  checkbox(:acknowledge, id: /acknowledge/)
  label(:acknowledge_text, class: /lbl/)
  div(:disabled, class: /ui-state-disabled/)
  span(:header_text, class: /header-text/)
end

class UnderwritingQuestionsSummaryPage < PolicyManagementPage
  section(:all_products_questions, AllProductsQuestionsPanel, id: /accountUWqestion/)
  section(:auto_questions, AutoQuestionsPanel, xpath: '//div[@id="policyUWQuestions"]/div/div[.//span[contains(text(),"IN - Auto Plus") or contains(text(),"IN - Auto") or contains(text(),"IN - Summit Auto") or contains(text(),"IN - Signature Auto")]]')
  section(:umbrella_questions, AutoQuestionsPanel, xpath: '//div[@id="policyUWQuestions"]/div/div[.//span[contains(text(),"IN - Personal Umbrella") or contains(text(),"IN - Umbrella")]]')
  section(:home_questions, HomeOwnersQuestionsPanel, xpath: '//div[@id="policyUWQuestions"]/div/div[.//span[contains(text(),"Homeowners")]]')
  sections(:auto_questions_panels, AutoQuestionsPanel, xpath: './/div[@id="policyUWQuestions"]', item: { xpath: './div/div[.//span[contains(text(),"IN - Auto Plus") or contains(text(),"IN - Auto")]]/p-panel/div', how: :divs })
  section(:scheduled_property_questions, ScheduledPropertyQuestionsPanel, xpath: '//div[@id="policyUWQuestions"]/div/div[.//span[contains(text(),"IN - Scheduled Property")]]')
  section(:watercraft_questions, WatercraftQuestionsPanel, xpath: '//div[@id="policyUWQuestions"]/div/div[.//span[contains(text(),"Watercraft")]]')
  section(:auto_summit_questions, AutoQuestionsPanel, xpath: '//div[@id="policyUWQuestions"]/div/div[.//span[contains(text(),"IN - Summit Auto")]]')
  section(:auto_signature_questions, AutoQuestionsPanel, xpath: '//div[@id="policyUWQuestions"]/div/div[.//span[contains(text(),"IN - Signature Auto")]]')
  section(:dwelling_questions, DwellingQuestionsPanel, xpath: '//div[@id="policyUWQuestions"]/div/div[.//span[contains(text(),"Special Dwelling")]]')

  def displayed?
    browser.url.include?('PolicyAdminWeb/underwritingquestion')
  end

  def resolve_issues_to_resolve
    if all_products_questions.present?
      all_products_questions.acknowledge = true
      all_products_questions.save_and_edit
      wait_for_ajax
    end
    auto_questions.acknowledge = true
    auto_questions.save_and_edit_element.double_click
    wait_for_ajax
  end

  def all_products_issues_to_resolve
    if all_products_questions.present?
      all_products_questions.acknowledge = true
      all_products_questions.save_and_edit
      wait_for_ajax
    end
  end

  def issues_to_resolve_umbrella
    if umbrella_questions.present?
      umbrella_questions.acknowledge = true
      sleep(0.5)
      umbrella_questions.save_element.click
      wait_for_ajax
      scroll.to :top
    end
  end

  def issues_to_resolve_scheduled_property
    if scheduled_property_questions.present?
      scheduled_property_questions.acknowledge = true
      sleep(0.5)
      scheduled_property_questions.save_element.click
      wait_for_ajax
      scroll.to :top
    end
  end

  def issues_to_resolve_home
    if home_questions.present?
      home_questions.acknowledge = true
      sleep(0.5)
      home_questions.save_element.click
      wait_for_ajax
      scroll.to :top
    end
  end

  def issues_to_resolve_dwelling
    if dwelling_questions.present?
      dwelling_questions.acknowledge = true
      sleep(0.5)
      dwelling_questions.save_element.click
      wait_for_ajax
      scroll.to :top
    end
  end

  def issues_to_resolve_summit_auto
    if auto_summit_questions.present?
      auto_summit_questions.acknowledge = true
      sleep(0.5)
      auto_summit_questions.save_element.click
      wait_for_ajax
      scroll.to :top
    end
  end

  def issues_to_resolve_signature_auto
    if auto_signature_questions.present?
      auto_signature_questions.acknowledge = true
      sleep(0.5)
      auto_signature_questions.save_element.click
      wait_for_ajax
      scroll.to :top
    end
  end

  def issues_to_resolve_watercraft
    if watercraft_questions.present?
      watercraft_questions.acknowledge = true
      sleep(0.5)
      watercraft_questions.save_element.click
      wait_for_ajax
      scroll.to :top
    end
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end

end
