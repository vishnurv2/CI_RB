# frozen_string_literal: true

class ScheduledPropertyClassesModal < BaseModal

  SET_SELECT_HOOKS ||= CptHook.define_hooks do
    before(:select).call(->(e) { e.scroll.to }).with(:self)
    before(:select).call(:click)
  end

  # Bicycle
  checkbox(:bicycles, xpath: './/label[text()="Bicycles"]/..')
  radio_set(:blanket_value_coverage, xpath: '.', item: { id: /blanketCoverageProperties/ })
  radio_set(:agreed_value_coverage, xpath: '.', item: { id: /agreedValueCoverageProperties/ })
  text_field(:agreed_total_amount, id: /AgreedValueTotalAmount/)
  select(:agreed_deductible, id: /AgreedDeductible/, hooks: SET_SELECT_HOOKS)
  text_field(:blanket_total_amount, id: /BlanketTotalAmount/)
  select(:blanket_per_item_amount, id: /BlanketPerItemAmount/, hooks: SET_SELECT_HOOKS)
  text_field(:blanket_vault_amount, id: /BlanketVaultAmount/)
  select(:blanket_deductible, id: /BlanketDeductible/, hooks: SET_SELECT_HOOKS)
  checkbox(:cameras_non_professional, xpath: './/label[text()="Cameras (non professional)"]/..')
  checkbox(:coins, xpath: './/label[text()="Coins"]/..')
  checkbox(:electronic_equipment_cellular_phones_other_media_includes_personal_computers, xpath: './/label[text()="Electronic Equipment, Cellular Phones & Other Media (includes personal computers)"]/..')
  checkbox(:fine_arts_with_breakage, xpath: './/label[text()="Fine Arts With Breakage"]/..')
  checkbox(:fine_arts_without_breakage, xpath: './/label[text()="Fine Arts Without Breakage"]/..')
  checkbox(:firearms, xpath: './/label[text()="Firearms"]/..')
  checkbox(:furs, xpath: './/label[text()="Furs"]/..')
  checkbox(:golfers_equipment, xpath: './/label[text()="Golfers Equipment"]/..')
  checkbox(:hearing_aids, xpath: './/label[text()="Hearing Aids"]/..')
  checkbox(:jewelry, xpath: './/label[text()="Jewelry"]/..')
  checkbox(:miscellaneous_collections, xpath: './/label[text()="Miscellaneous Collections"]/..')
  checkbox(:motorized_vehicles_for_handicapped_persons, xpath: './/label[text()="Motorized Vehicles for Handicapped Persons"]/..')
  checkbox(:musical_instruments_non_professional, xpath: './/label[text()="Musical Instruments (non professional)"]/..')
  checkbox(:silverware, xpath: './/label[text()="Silverware"]/..')
  checkbox(:sporting_equipment, xpath: './/label[text()="Sporting Equipment"]/..')
  checkbox(:stamps, xpath: './/label[text()="Stamps"]/..')
  checkbox(:wine_collection, xpath: './/label[text()="Wine Collection"]/..')

  select(:sort_by_filter, xpath: './/p-dropdown[.//input[contains(@role, "listbox")]]', hooks: WFA_HOOKS)


  span(:per_item_limit_value, xpath: './/p-dropdown[@id="Bicycles_0_blanketCoverage_1_BlanketPerItemAmount_1"]/div/span')
  span(:deductible, xpath: './/p-dropdown[@id="Bicycles_0_blanketCoverage_2_BlanketDeductible_2"]/div/span')

  text_field(:bicycles_agreed_amount, xpath: './/input[contains(@id, "currency_Bicycles_agreedCoverage") and contains(@id, "AgreedValueTotalAmount")]')
  select(:bicycles_agreed_deductible, xpath: './/*[contains(@id, "Bicycles_agreedCoverage") and contains(@id, "AgreedValueDeductible")]', hooks: SET_SELECT_HOOKS)
  text_field(:bicycles_item_name, xpath: './/input[contains(@id, "Bicycles") and contains(@id, "ItemName")]')
  textarea(:bicycles_item_description, xpath: './/*[contains(@id, "Bicycles") and contains(@id, "ItemDescription")]')
  text_field(:bicycles_item_amount, xpath: './/input[contains(@id, "Bicycles") and contains(@id, "ItemAmount")]')
  label(:negative_agreed_value, xpath: './/label[contains(@class, "p-text-danger")]')

  #Ground Maintenance Vehicles
  checkbox(:ground_maintenance_vehicles, xpath: './/label[text()="Ground Maintenance Vehicles"]/..')
  text_field(:amount_of_insurance, id: /agreedCoverage_0_VehicleTotalAmount/)
  select(:deductible_vehicles, id: /agreedCoverage_7_AgreedDeductible_7/, hooks: SET_SELECT_HOOKS)
  button(:add_item, xpath: '//button[@label="Add Item"]')
  select(:category, id: /GroundMaintenanceVehicles_0_0/, hooks: SET_SELECT_HOOKS)
  select(:category_second, id: /GroundMaintenanceVehicles_1_0/, hooks: SET_SELECT_HOOKS)
  select(:category_third, id: /GroundMaintenanceVehicles_2_0/, hooks: SET_SELECT_HOOKS)
  label(:identification_number, xpath: './/input[@id="GroundMaintenanceVehicles_0_1_VIN_1"]/ancestor::div/label')
  text_field(:vin_first, id: /GroundMaintenanceVehicles_0_1_VIN/)
  text_field(:vin_second, id: /GroundMaintenanceVehicles_1_1_VIN/)
  text_field(:year_first, id: /GroundMaintenanceVehicles_0_2_Year/)
  text_field(:year_second, id: /GroundMaintenanceVehicles_1_2_Year/)
  text_field(:make_first, id: /GroundMaintenanceVehicles_0_3_Make/)
  text_field(:make_second, id: /GroundMaintenanceVehicles_1_3_Make/)
  text_field(:model_first, id: /GroundMaintenanceVehicles_0_4_Model/)
  text_field(:model_second, id: /GroundMaintenanceVehicles_1_4_Model/)
  text_field(:item_insurance_amount_first, id: /GroundMaintenanceVehicles_0_7_ItemAmount/)
  text_field(:item_insurance_amount_second, id: /GroundMaintenanceVehicles_1_7_ItemAmount/)
  text_field(:item_insurance_amount_third, id: /GroundMaintenanceVehicles_2_7_ItemAmount/)
  text_field(:item_name, id: /ItemName/)
  textarea(:item_description, id: /ItemDescription/)

  #motorized vehicle for handicapped
  select(:category_motorized, id: /VehiclesForHandicappedPersons_0_0/, hooks: SET_SELECT_HOOKS)
  label(:identification_number_motorized, xpath: './/input[@id="VehiclesForHandicappedPersons_0_1_VIN_1"]/ancestor::div/label')
  text_field(:vin_first_motorized, id: /VehiclesForHandicappedPersons_0_1_VIN/)
  text_field(:year_first_motorized, id: /VehiclesForHandicappedPersons_0_2_Year/)
  text_field(:make_first_motorized, id: /VehiclesForHandicappedPersons_0_3_Make/)
  text_field(:model_first_motorized, id: /VehiclesForHandicappedPersons_0_4_Model/)
  text_field(:item_insurance_amount_first_motorized, id: /VehiclesForHandicappedPersons_0_7_ItemAmount/)



  def next_modal
    save_and_continue
  end

end
