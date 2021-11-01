# frozen_string_literal: true

class AutoVehicleInformationPanel < BasePanel
  WFM_HOOKS ||= CptHook.define_hooks do
    after(:click).call(:wait_for_modal_or_error).using(:parent_container)
    after(:click!).call(:wait_for_modal_or_error).using(:parent_container)
  end

  data_grid(:vehicles, VehicleRow) # , xpath: './/div[.//table/thead/tr/th[contains(text(), "Class Code")]]') # was "vehicle_grid" prior to Angular AMN 1-22-2020
  data_grid(:other_vehicles, OtherVehicleRow) # , xpath: './/div[.//table/thead/tr/th[contains(text(), "Type")]]') # was "other_vehicle_grid" prior to Angular AMN 1-22-2020

  span(:add_button, class: /fa-plus/, default_method: :click!, hooks: WFA_HOOKS)
  #button(:add_button, xpath: '//app-auto-vehicle-summary/div/div/div/div/div/button')
  ul(:add_more_button_list, xpath: '//ul[@class="dropdown-menu dropdown-menu-right show"]')

  ## This is for Angular.  The new + button crates a ul dropdown
  #  open_add_more_vehicles_button "Add Camper Motorhome"
  def open_add_more_vehicles_button(which)
    add_button if add_more_button_list? == false

    item = add_more_button_list.find { |item| item.link.text.downcase.snakecase == which.to_s.downcase.snakecase }
    item.click!
  end

  def vehicles?
    vehicles_element.present?
  end

  # ------ Everything below this line is unverified ------------------------------------- #
  #

  ### Need to do something different with adding vehicles and other, its a dropdown list ###
  #link(:add_vehicle, text: 'Add Vehicle', hooks: WFM_HOOKS)
  #link(:add_camper_motorhome, text: 'Add Camper/Motorhome', hooks: WFM_HOOKS)
  #link(:add_trailer, text: 'Add General Use Trailer', hooks: WFM_HOOKS)
  #link(:add_other_vehicle, text: 'Add Other Motorized Vehicle', hooks: WFM_HOOKS)
  ####


  span(:risk_state_validation, text: /Risk State is (.*); at least one vehicle must be garaged in (.*)/)
  link(:paginate_buttons, class: 'paginate_button')
  div(:entries_text, class: 'dataTables_info')

  def other_vehicles?
    other_vehicles_element.present?
  end

  def remove_all_vehicles_but_one
    last_vehicles_count = -1
    vehicles_collection = vehicles
    current_vehicles_count = vehicles_collection.count
    while last_vehicles_count != current_vehicles_count && current_vehicles_count > 1 # keep track of the current/last count so we don't infinitely loop
      v = vehicles_collection.last
      v.scroll.to :bottom
      v.safe_delete
      begin
        Watir::Wait.while(timeout: 10) { vehicles.count == current_vehicles_count }
      rescue
      end
      last_vehicles_count = current_vehicles_count
      vehicles_collection = vehicles # update the list of applicants each loop so that it can find the elements
      current_vehicles_count = vehicles_collection.count
    end
  end

  def remove_extra_vehicles(number_to_keep = 1)
    return unless vehicles?

    vehicles_to_remove = _find_vehicles_to_remove
    return if vehicles_to_remove.count <= number_to_keep

    puts "Removing #{vehicles_to_remove.count - number_to_keep} vehicles"
    api = PolicyAPI::DELETEApi.new
    vehicles_to_remove[number_to_keep..-1].each do |vehicle|
      puts "Removing #{vehicle[:vehicle_id]}"
      api.policies_delete_vehicle vehicle[:act_id], vehicle[:vehicle_id]
    end
  end

  VEHICLE_TYPES_TO_BUTTONS = { camper: 'add_camper_motorhome', motorhome: 'add_camper_motorhome', trailer: 'add_trailer', golf_cart: 'add_other_vehicle', all_terrain_vehicle: 'add_other_vehicle', snowmobile: 'add_other_vehicle' }.freeze
  def add_vehicle_by_type(type)
    send(VEHICLE_TYPES_TO_BUTTONS[type.to_s.snakecase.to_sym])
    parent_container.other_vehicle_modal.populate
    parent_container.other_vehicle_modal.save_and_close
  end

  private

  def _find_vehicles_to_remove
    vehicles_to_remove = []
    vehicles.each do |item|
      vehicle_id, rest = item.link(class: 'VehicleTableEditLink').href.split('/').last.split('?')
      act_id = rest.split('&').first.split('=').last
      vehicles_to_remove << { vehicle_id: vehicle_id, act_id: act_id }
    end

    vehicles_to_remove.uniq
  end
end
