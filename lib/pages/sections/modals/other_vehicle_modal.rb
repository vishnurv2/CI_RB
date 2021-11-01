# frozen_string_literal: true

class OtherVehicleModal < BaseModal
  VIN_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:get_vehicle_value)
        .call(:wait_for_ajax)
  end

  SET_TEXT_FIELD_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:click)
  end

  VV_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:get_vehicle_value)
  end

  select_button_set(:enter_by)
  tab_strip(:tabs, id: 'customTab')
  select(:type_of_vehicle, name: 'autosTypes', hooks: WFA_HOOKS)
  #text_field(:vehicle_year, name: 'vinModelYear', hooks: WFA_HOOKS.merge(YMM_HOOKS)) #old
  text_field(:vehicle_year, name: 'vinModelYear', hooks: WFA_HOOKS.merge(SET_TEXT_FIELD_HOOKS))
  select(:vehicle_make, name: 'vinMake', hooks: WFA_HOOKS)
  text_field(:vehicle_make_text_field, id: 'makeInput', hooks: WFA_HOOKS)
  select(:vehicle_model, name: 'vinModel', hooks: WFA_HOOKS)
  text_field(:vehicle_model_text_field, id: 'vinModelInput', hooks: WFA_HOOKS)
  select(:vehicle_style, name: 'vinStyle') # << took off Hooks to reduce wait time!

  # Vehicle info tab fields ( toggle )
  toggle_button_list(:identification_type_list, name: 'vehicleByOptions') # not really working, created enter_vehicle_by
  text_field(:vehicle_identification_number, id: 'vin')

  span(:get_vehicle_value, text: 'Value Lookup', default_method: :click!, hooks: WFA_HOOKS)

  text_field(:vehicle_value, id: 'vehicleValue')

  text_field(:coverage_limit, id: 'vehicleValue')
  #radio_set(:vehicle_value_type, xpath: '.', item: { name: /vehicleValueOption/ }, hooks: VV_HOOKS)

  def vehicle_value_type=(vvt)
    vvt = vvt.downcase
    if vvt.include?('original')
      vehicle_value_element.set(span(text: /(O|o)riginal/).text.split(':')[1].gsub('$', '').gsub(',', '').gsub('.00', ''))
    elsif vvt.include?('current')
      vehicle_value_element.set(span(text: /(C|c)urrent/).text.split(':')[1].gsub('$', '').gsub(',', '').gsub('.00', ''))
    end
  end

  select(:address_select, ng_reflect_input_id: /addresslist_/)
  select_button_set(:address_type, id: /AddressType_/)
  select(:territory, id: 'territoryList')

  section(:address_details, AddressDetailsSection, id: /addressFields/)
  button(:edit_address, xpath: './/p-button[contains(@id, "btnEditAddress")]/button')
  button(:save_and_add_another, text: /Save & Add Another Vehicle/)

  button(:save_and_continue, name: 'SaveAndContinue', hooks: WFA_HOOKS)

  div(:original_cost_new_currency, xpath: '//p-radiobutton/label[contains(text(), "Original Cost New")]/following::div')
  div(:current_retail_value_currency, xpath: '//p-radiobutton/label[contains(text(), "Current Retail Value")]/following::div')

  # tab_strip(:tabs, class: 'cmi-tabstrip-sm-md-lg')
  #
  # # Vehicle info tab fields
  # select_list(:type_of_vehicle, id: 'TypeOfVehicle', hooks: WFA_HOOKS)
  # text_field(:vehicle_year, class: 'vehicleYear', hooks: WFA_HOOKS)
  # select_list(:vehicle_make_drop_down, class: 'vehicleMake', hooks: WFA_HOOKS)
  # text_field(:vehicle_make_text_field, id: 'MakeTextBox')
  # select_list(:vehicle_model_drop_down, class: 'vehicleModel', hooks: WFA_HOOKS)
  # text_field(:vehicle_model_text_field, id: 'ModelTextBox')
  # select_list(:vehicle_style, class: 'vehicleStyle', hooks: WFA_HOOKS)
  # text_field(:id_number, id: 'IdentificationNumber')
  #
  # button(:get_vehicle_value, id: 'btnOtherVehicleValueButton', hooks: WFA_HOOKS)
  # text_field(:vehicle_value, class: 'vehicleValue')
  #
  # span(:original_cost_label, class: 'vehicleValueMsrpLabel')
  # span(:current_retail_label, class: 'vehicleValueRetailLabel')
  #
  # button(:save_and_add_another, text: 'Save and Add Another Vehicle')

  def value_type=(value)
    get_vehicle_value
    vehicle_value_element.set! value.casecmp('original cost').zero? ? original_cost : current_retail
  end

  def original_cost
    original_cost_label.split('$').last.split('.').first.delete(',')
  end

  def current_retail
    current_retail_label.split('$').last.split('.').first.delete(',')
  end

  def next_modal
    tabs.active_tab = 'Coverage'
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    puts ''
    # rubocop:enable Lint/Debugger
  end

  def populate_with(data)
    return super unless data.key? 'vehicles'

    begin
      data['vehicles'].each_with_index do |vehicle, index|
        populate_with(vehicle)

        save_and_add_another unless index == data['vehicles'].count - 1
      end
    rescue Exception => ex
      parent_container.raise_page_errors 'Populating auto driver modal'
      raise ex
    end
  end

  def vehicle_make=(make)
    vehicle_make_element.present? ? vehicle_make_element.select(make) : vehicle_make_text_field_element.set(make)
  end

  def vehicle_model=(model)
    vehicle_model_element.present? ? vehicle_model_element.select(model) : vehicle_model_text_field_element.set(model)
  end

  def wait_for_loading_to_disappear
    #Watir::Wait.until { territory? && territory.text != 'select' } Was waiting on territory?
    Watir::Wait.until(timeout: 10) { type_of_vehicle? && territory? && territory.text != 'select'}
    sleep 0.6
  end
end
