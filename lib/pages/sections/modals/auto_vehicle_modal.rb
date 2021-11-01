# frozen_string_literal: true


class FullInvalidVINValidationSection < BaseSection
  button(:use_as_entered, text: 'Use As Entered')
  button(:remain_and_correct, text: 'Edit')
  button(:confirm_selection)
end

class AutoVehicleModal < BaseModal
  VIN_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:enter_vehicle_by=).with('Vehicle Identification Number')
    after(:set).call(:get_vehicle_info)
        .call(:wait_for_ajax)
  end

  V_INFO_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:get_vehicle_info)
        .call(:wait_for_ajax)
  end

  SET_TEXT_FIELD_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:click)
  end

  VV_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:get_vehicle_value)
  end

  select_button_set(:enter_by)
  select(:type_of_vehicle, name: 'autosTypes', hooks: WFA_HOOKS)
  text_field(:vehicle_year, name: 'vinModelYear', hooks: WFA_HOOKS.merge(SET_TEXT_FIELD_HOOKS))
  select(:vehicle_make, name: 'vinMake', hooks: WFA_HOOKS)
  select(:vehicle_model, name: 'vinModel', hooks: WFA_HOOKS)
  select(:vehicle_style, name: 'vinStyle', hooks: WFA_HOOKS) # << took off Hooks to reduce wait time!

  # Vehicle info tab fields ( toggle )
  toggle_button_list(:identification_type_list, name: 'vehicleByOptions') # not really working, created enter_vehicle_by
  text_field(:vehicle_identification_number, id: 'vin', hooks: VIN_HOOKS)
  span(:get_vehicle_info, text: 'Vehicle Lookup', default_method: :click!)
  span(:year_result, id: 'vinYearValue')
  span(:make_result, id: 'vinMakeValue')
  span(:model_result, id: 'vinModelValue')
  select(:performance, name: 'performanceTypes', hooks: WFA_HOOKS)
  select(:anti_theft_device, name: 'antiTheftDeviceTypes')
  select(:passive_restraint_device, name: 'passiveRestraintCodes')
  select(:vehicle_use, name: 'vehicleUses', hooks: WFA_HOOKS)
  text_field(:miles_driven_one_way, id: 'milesOneWay')
  text_field(:driven_days_per_week, id: 'daysPerWeek')
  div(:invalid_vin_alert, class: ["ui-message-warn", "ng-star-inserted"])
  checkbox(:agreed_value, name: 'agreedValue')
  select_button_set(:stated_amount, name: 'amountByOptions')
  text_field(:stated_amount_cost, id: /vehicleValue/)

  # Blackbook
  select(:black_book_year, id: 'blackbookYear')
  select(:black_book_make, name: 'blackbookMake')
  select(:black_book_model, name: 'blackbookModel')
  select(:black_book_series, name: 'blackbookSeries')
  select(:black_book_style, name: 'blackbookStyle')
  span(:get_vehicle_value, text: 'Value Lookup', default_method: :click!, hooks: WFA_HOOKS)
  text_field(:vehicle_value, id: /vehicleValue/)
  radio_set(:vehicle_value_type, xpath: '.', item: {name: /vehicleValueOption/}, hooks: VV_HOOKS)

  select(:address_select, ng_reflect_input_id: /addresslist_/)
  select(:garage_address, xpath: './/div[contains(text(),"Address")]/../../following-sibling::div//p-dropdown')
  select_button_set(:address_type, id: /AddressType_/)
  select_button_set(:enter_vehicle_by_text, id: /vehicleByOptions/)
  select(:territory, id: 'territoryList')
  div(:territory_value, xpath: './/p-dropdown[@id="territoryList"]/div')
  div(:vehicle_use_text, xpath: './/p-dropdown[@id="vehicleUses"]/div')

  section(:address_details, AddressDetailsSection, id: /addressFields/)
  button(:edit_address, xpath: './/p-button[contains(@id, "btnEditAddress")]/button')
  button(:save_and_add_another, xpath: './/p-button[@id="SaveAndAddAnother"]/button')
  div(:original_cost_new_currency, xpath: '//p-radiobutton/label[contains(text(), "Original Cost New")]/following::div')
  div(:current_retail_value_currency, xpath: '//p-radiobutton/label[contains(text(), "Current Retail Value")]/following::div')

  # to be checked
  button(:save_and_close, xpath: './/p-button[@id="SaveandClose"]/button | .//button[@id="SaveandClose"]')
  i(:notice_icon, class: 'pi pi-exclamation-triangle p-message-icon')

  text_field(:purchase_date, id: 'purchaseDate')
  text_field(:annual_miles, name: 'annualMiles')
  checkbox(:purchase_date_unknown, name: 'purchaseDateUnknown')
  span(:error_message, xpath:'.//div[contains(@class,"p-message-error")]/span')
  span(:territory_label, xpath: './/app-territory//span[contains(@class,"label light-warning")]')
  span(:warning_message, xpath: './/div[contains(@class,"p-message-warn")]/span')

  def address=(new_address_hash)
    edit_address unless address_details_element.present?
    address_details.populate_with(new_address_hash)
  end

  def enter_vehicle_by=(text)
    span(xpath: ".//p-selectbutton/.//span[contains(text(), '#{text}')]").click!
  end

  def vehicle_value_types=(text)
    get_vehicle_value
    #span(xpath: ".//p-selectbutton/.//span[contains(text(), '#{text}')]").click!
    label(xpath: ".//label[contains(text(), '#{text}')]").click!
  end

  #hack for now until new control is created
  def vehicle_value_button_text(text)
    span(xpath: ".//p-selectbutton/.//span[contains(text(), '#{text}')]")
  end

  def value_type=(value)
    get_vehicle_value
    vehicle_value_type_element.option_elements.each do |o|
      if o.text.snakecase.include?(value.snakecase)
        o.scroll.to
        o.click
        break
      end
    end
  end

  def strip_currency(num)
    num.split('.').first.gsub!(/[^0-9A-Za-z]/, '')
  end

  def next_modal
    save_and_continue

    ### this was in the old next modal - it was selecting the coverages tab?
    # tabs.active_tab = 'Coverage'
  end

  def populate_with(data)
    return super unless data.key? 'vehicles'

    begin
      data['vehicles'].each_with_index do |vehicle, index|
        wait_for_ajax
        populate_with(vehicle)

        save_and_add_another unless index == data['vehicles'].count - 1
      end
    rescue Exception => ex
      parent_container.raise_page_errors 'Populating AUTO VEHICLE modal'
      raise ex
    end
  end

  def save_and_close
    save_and_close_element.click
    wait_for_ajax
    save_and_close_element.click if notice_icon?
    wait_for_ajax
  end

  # ------ Everything below this line is unverified ------------------------------------- #

  YMM_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:identification_type=).with('Year/Make/Model')
    before(:present?).call(:identification_type=).with('Year/Make/Model')
  end

  tab_strip(:tabs, id: 'customTab')
  text_field(:vehicle_identification_number_field, id: 'vin')
  text_field(:vin_get_info, id: 'vehicleInfo') # need this as opposed to above for a test that modifies VIN; when modifying, identification_type cannot be set

  text_field(:cost_new, class: 'costNew')
  hidden(:msrp_value, name: 'hiddenMsrpValue')
  span(:risk_state_validation, text: /at least one vehicle must be garaged in/)
  section(:full_invalid_vin_validation, FullInvalidVINValidationSection, id: 'invalidVinIssuance')

  def identification_type=(new_type)
    wait_for_ajax
    identification_type_list_element.set(new_type) if identification_type_list_element.present?
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    puts ''
    # rubocop:enable Lint/Debugger
  end
end
