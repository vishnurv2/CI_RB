# frozen_string_literal: true

class Containers < EDSL::PageObject::Section
  span(:header_text, xpath: './/div[contains(@class,"panel-header")]/span[not(contains(@class,"chevron"))]')
  # VEHICLES
  text_field(:private_passenger, xpath: './/div[contains(text(),"Automobile - Limited Use")]/..//input')
  text_field(:automobile, xpath: './/div[contains(text(),"Automobile")]/..//input')
  text_field(:automobile_classic_antique, xpath: './/div[contains(text(),"Automobile - Classic / Antique")]/..//input')
  text_field(:company_car, xpath: './/div[contains(text(),"Company Car")]/..//input')
  text_field(:camper_motorhome, xpath: './/div[contains(text(),"Camper / Motorhome")]/..//input')
  text_field(:street_motorcycle, xpath: './/div[contains(text(),"Street Motorcycle")]/..//input')
  text_field(:less_than_250cc, xpath: './/div[contains(text(),"Off-Road Motorcycle (less than 250cc)")]/..//input')
  text_field(:more_than_250cc, xpath: './/div[contains(text(),"Off-Road Motorcycle (250cc or greater)")]/..//input')
  text_field(:atv_3_wheel, xpath: './/div[contains(text(),"ATV - 3 - wheel")]/..//input')
  text_field(:atv_4_wheel, xpath: './/div[contains(text(),"ATV - 4 - wheel")]/..//input')
  text_field(:snowmobile, xpath: './/div[contains(text(),"Snowmobile")]/..//input')
  text_field(:golf_cart, xpath: './/div[contains(text(),"Golf Cart")]/..//input')
  text_field(:moped_scooter, xpath: './/div[contains(text(),"Moped / Scooter")]/..//input')
  text_field(:dune_buggy, xpath: './/div[contains(text(),"Dune Buggy")]/..//input')
  text_field(:automobile_limited_use, xpath: './/div[contains(text(),"Automobile - Limited Use")]/..//input')

  #LOCATION/PROPERTY
  text_field(:single_family_homes, xpath: './/div[contains(text(),"Single Family Home")]/..//input')
  text_field(:multi_family_homes, xpath: './/div[contains(text(),"Multi Family Home")]/..//input')
  text_field(:swimming_pools, xpath: './/div[contains(text(),"Swimming Pools - at Owner Occupied Location / Property")]/..//input')
  text_field(:trampoline, xpath: './/div[contains(text(),"Trampoline - at Owner Occupied Location / Property")]/..//input')

  #WATERCRAFT
  text_field(:sailboats, xpath: './/div[contains(text(),"Sailboat")]/..//input')
  text_field(:less_than_150_H_P, xpath: './/div[contains(text(),"Boats with Outboard Motors, 150 H.P or Less")]/..//input')
  text_field(:more_than_150_H_P, xpath: './/div[contains(text(),"Boats with Outboard Motors, more than 150 H.P")]/..//input')
  text_field(:less_than_250_H_P, xpath: './/div[contains(text(),"Boats with Inboard or Inboard / Outboard Motors, 250 H.P or less")]/..//input')
  text_field(:more_than_250_H_P, xpath: './/div[contains(text(),"Boats with Inboard or Inboard / Outboard Motors, more than 250 H.P")]/..//input')
  text_field(:personal_watercraft_jet_ski_waverunner, xpath: './/div[contains(text(),"Personal Watercraft (Jet Ski, Waverunner)")]/..//input')

  #Farm-land
  radio_set(:farming_residence_premises, id: /farmingonresidencepremises/)
  text_field(:farming_away_residence_premises, xpath: './/div[contains(text(),"Farming away from the Residence Premises")]/..//input')
  text_field(:farm_land_rented, xpath: './/div[contains(text(),"Farm Land Rented to Others")]/..//input')

  #Business Property
  text_field(:permitted_incidental_occupancy, xpath: './/div[contains(text(),"Permitted")]/..//input')
  text_field(:home_based_business, xpath: './/div[contains(text(),"Home-Based Business")]/..//input')
  text_field(:business_pursuits, xpath: './/div[contains(text(),"Business Pursuits")]/..//input')
  text_field(:single_family_rental_dwelling, xpath: './/div[contains(text(),"Single Family Rental Dwelling")]/..//input')
  text_field(:multi_family_rental_dwelling, xpath: './/div[contains(text(),"Multi-Family Rental Dwelling")]/..//input')
  text_field(:swimming_pools_rental_dwelling, xpath: './/div[contains(text(),"Swimming Pools at Rental Dwelling")]/..//input')
  text_field(:trampoline_rental_dwelling, xpath: './/div[contains(text(),"Trampoline at Rental Dwelling")]/..//input')


end

class ExposuresInsuredWithAnotherCarrierModal < BaseModal

  V_INFO_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:get_vehicle_info)
        .call(:wait_for_ajax)
  end

  WFA_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:wait_for_ajax)
    after(:click).call(:wait_for_ajax)
    after(:click!).call(:wait_for_ajax)
    after(:select).call(:wait_for_ajax)
  end

  button(:save_and_close, xpath: '//p-button[contains(@id, "Close")]/button')
  sections(:containers, Containers, xpath: '.', item: {xpath: './/p-panel/div[contains(@class,"p-component p-panel")]'})

  select(:carrier, id: 'Carrier')
  text_field(:policy_number, id: 'policyNumber')
  date_field(:effective_date, name: 'EffectiveDate')
  date_field(:expiration_date, name: 'ExpirationDate')

  #Location/Property Modal
  select(:location_property_address, xpath: '//app-address/div/div/p-dropdown')
  section(:address_details, AddressDetailsSection, id: /addressFields/)
  select(:limit, id: 'limit')
  select(:location_of_incidental_occupancy, id: 'incidentalOccupancy')

  #Vehicles
  select_button_set(:identification_type_list, xpath: '//p-selectbutton[contains(@id,"vehicleByOptions")]/div')
  select_button_set(:split_combined_single_limit, xpath: '//p-selectbutton[contains(@id,"btnselectLimitType")]/div')
  text_field(:vehicle_identification_number, id: 'vin')
  span(:get_vehicle_info, text: 'Vehicle Lookup', default_method: :click!)
  text_field(:vin_model_year, name: 'vinModelYear', hooks: WFA_HOOKS)
  text_field(:make_input, id: 'makeInput')
  text_field(:model_input, id: 'vinModelInput')
  select(:make, id: 'vinMake')
  select(:model, id: 'vinModel')
  select(:style, id: 'vinStyle')
  select(:limits, id: 'limits')
  select(:make_umbrella, id: 'vinMake', hooks: WFA_HOOKS)
  select(:model_umbrella, id: 'vinModel', hooks: WFA_HOOKS)

  #Watercraft
  text_field(:serial_number, id: 'vin')
  text_field(:year, id: 'year')
  text_field(:make, id: 'make')
  text_field(:model, id: 'model')
  select(:carrier, id: 'Carrier')
  text_field(:make_umbrella_input, id: 'makeInput', hooks: WFA_HOOKS)
  text_field(:model_umbrella_input, id: 'vinModelInput', hooks: WFA_HOOKS)

  #Business Property
  text_field(:number_of_units, id: /txtNumberOfAcres/)
  div(:no_of_acres_error_message, xpath: '//input[@id="txtNumberOfAcres"]/following-sibling::div')
  i(:dismiss, xpath: './/div[@id="modal-header"]//i')

  #Buttons
  button(:business_property, xpath: './/span[contains(text(), "Business Property")]/../../../following-sibling::div/button')
  button(:vehicles, xpath: './/span[contains(text(), "Vehicles")]/../../../following-sibling::div/button')
  button(:location_property, xpath: './/span[contains(text(), "Location / Property")]/../../../following-sibling::div/button')
  button(:watercraft, xpath: './/span[contains(text(), "Watercraft")]/../../../following-sibling::div/button')
  button(:farm_land, xpath: './/span[contains(text(), "Farm Land")]/../../../following-sibling::div/button')
  button(:student_away_from_home, xpath: './/span[contains(text(), "Student Away From Home")]/../../../following-sibling::div/button')

  def year=(year)
    # This is a hack for now, somethings is off with this input field.....
    2.times do
      vin_model_year_element.click
      vin_model_year_element.set('')
      vin_model_year_element.send_keys("#{year}")
    end
  end
end