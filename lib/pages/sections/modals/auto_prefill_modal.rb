# frozen_string_literal: true

class PrefillVehicleRow < BaseSection
  #checkbox(:select)
  checkbox(:select_checkbox, xpath: './/div[contains(@class,"p-checkbox")]/..')
  #label(:select, for: /VehicleAddedCheckBox/, default_method: :click)
  # td(:year, index: 1)
  # td(:make, index: 2)
  # td(:model, index: 3)
  # td(:vin, index: 4)
  label(:full_name, class: /singleRow headerText/)
  span(:vin, xpath: './/b[text()="VIN"]/parent::span')

  def to_h
    {selected: select_checkbox.input.value.match?('true'), full_name: full_name, vin: vin}
  end
end

class PrefillDriverRow < BaseSection
  #checkbox(:select)
  checkbox(:select_checkbox, xpath: './/div[contains(@class,"p-checkbox")]/..')
  #label(:select, for: /DriverAddedCheckBox/, default_method: :click)
  # td(:full_name, index: 1)
  # td(:date_of_birth, index: 3)
  # td(:license_number, index: 4)
  label(:full_name, class: /singleRow headerText/)
  span(:license_number, xpath: './/b[text()="DLN"]/parent::span')
  select(:reason, xpath: './/label[@for="driverRemovalReason"]/following-sibling::p-dropdown')
  textarea(:other_remarks,id: /driverRemovalReasonRemarks/)
  select(:existing_account_party)

  def to_h
    {selected: select_checkbox.input.value.match?('true'), existing_account_party: existing_account_party.text,
     full_name: full_name, license_number: license_number}
  end
end

class PrefillReasonRow < BaseSection
  select_list(:reason, id: /^DisputeReasonColumnDropdown_/)
  textarea(:other_remarks, id: /^DisputeReasonRemarks_/)
end

class AutoPrefillModal < BaseModal
  sections(:vehicles, PrefillVehicleRow, xpath: '.', item: {xpath: './/input[contains(@id,"vehicle")]/../../../../../parent::div[@class="p-card-content"]'})
  sections(:drivers, PrefillDriverRow, xpath: '.', item: {xpath: './/input[contains(@id,"driver")]/../../../../../parent::div[@class="p-card-content"]'})
  # data_grid(:vehicles, PrefillVehicleRow, xpath: './/table[@id="Vehicles"]/..') # , item: { xpath: './/table/tbody/tr' })
  # data_grid(:drivers, PrefillDriverRow, xpath: './/table[@id="Drivers"]/..', item: { xpath: './/table/tbody/tr[not(@id)]' })
  data_grid(:reasons, PrefillReasonRow, item: {id: /^tr_DisputeReasonRow_/})
  button(:save_and_continue, xpath: '//p-button[@id="SaveAndContinue"]/button')
  button(:save_and_close, xpath: '//p-button[@id="SaveandClose"]/button')
  i(:dismiss, xpath: '//div[@id="modal-header"]//i', default_method: :click!)
  span(:drivers_message, xpath: '//b[contains(text(),"Drivers")]/../../../..//span[contains(@class,"ui-message-text")]')
  span(:vehicles_message, xpath: '//b[contains(text(),"Vehicle")]/../../../..//span[contains(@class,"ui-message-text")]')

  def vehicle_selections=(values)
    grid_select(vehicles, values)
  end

  def driver_selections=(values)
    grid_select(drivers, values)
  end

  def deselect_all
    drivers.each { |d| d.select_checkbox_element.uncheck }
    vehicles.each { |v| v.select_checkbox_element.uncheck }
  end

  def grid_select(grid, values)
    values.each_with_index do |val, index|
      parent_container.send_keys(:tab)
      if !val
        grid[index].select_checkbox_element.uncheck
      else
        grid[index].select_checkbox_element.check
      end
    end
  end

  def next_modal
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
    save_and_continue
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
