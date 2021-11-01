# frozen_string_literal: true

class OccasionalUseDriverRow < EDSL::PageObject::Section
  select(:driver)#, ng_reflect_name: /existingOccasionalDriver/)
  button(:remove, xpath: './/p-button[contains(@id,"removeAnotherDriver")]/button')
end

class AutoDriverAssigmentEditPanel < BasePanel

  # ------ Everything below this line is unverified ------------------------------------- #

  select(:primary_use_driver, xpath: './/label[text()="Primary Driver"]/../.././p-dropdown')#, ng_reflect_input_id: /existingPrimaryDriver/)
  # select_list(:primary_use_driver, class: 'driverAssignmentDriverList', assign_method: :select_by)
  # sections(:occasional_use_drivers, OccasionalUseDriverRow, class: 'driverAssignmentPanel', item: { class: 'divDriverAssignment', visible: true })
  sections(:occasional_use_drivers, OccasionalUseDriverRow, xpath: '.', item: { xpath: './/div[contains(text(),"Occasional Driver(s)")]/following-sibling::div[@class="p-grid ng-star-inserted"]', visible: true })
  # button(:add_occasional_use_driver, id: 'btnAddDriverAssignment', hooks: WFA_HOOKS)
  button(:add_occasional_use_driver, xpath: './/p-button[@label="Add Driver"]/button', hooks: WFA_HOOKS)
  span(:vehicle_header, xpath: './/div[contains(@class,"p-panel-header")]/span')
  def grid_key
    @key ||=  vehicle_header.downcase
  end

  # def vehicle_identification_number
  #   @vin ||=  header.split('-').last.strip
  # end

  def vehicle_year
    @year ||= grid_key.split(' ').first.to_i
  end

  def vehicle_make_model
    @year ||= grid_key.first.split(' ')[1..-1].join(' ')
  end
end

class AutoDriverAssignmentModal < BaseModal


  # ------ Everything below this line is unverified ------------------------------------- #

  sections(:vehicle_panels, AutoDriverAssigmentEditPanel, xpath: '.', item: {xpath: './/p-panel[contains(@id,"Accordian")]/div'})
  li(:all_drivers_assigned_validation, text: /[Nn]ot all drivers were assigned/)
  li(:all_vehicles_assigned_validation, text: /[Nn]ot all vehicles were assigned/)

  def find_panel_by(how, what)
    vehicle_panels.find { |v| v.send(how) == what }
  end

  def populate_with(data)
    return super unless data.key? 'drivers'

    data['drivers'].each_with_index do |driver_list, index|
      panel = vehicle_panels[index]
      panel.primary_use_driver = driver_list.first
      driver_list[1..-1].each do |driver|
        panel.add_occasional_use_driver
        panel.occasional_use_drivers.last.driver = driver
      end
    end
  end

  def primary_use_drivers=(drivers)
    vehicle_panels.each_with_index { |p, i| p.primary_use_driver = drivers[i] }
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
