# frozen_string_literal: true
class ExposuresRow < BaseSection
  td(:category, data_label: /Category/)
  td(:exposure, data_label: /Exposure/)
  td(:policy, data_label: /Policy/)
  td(:status, data_label: /Status/)
end

class ExposuresInsuredModal < BaseModal
  button(:add_miscellaneous_vehicles, xpath: '//p-button[contains(@id, "AddMiscellaneousVehicles")]/button')
  button(:add_parcels_of_vacant_land, xpath: '//p-button[contains(@id, "AddParcelsofVacantLand")]/button')
  button(:close, xpath: '//p-button[contains(@id, "Close")]/button')
  button(:save_and_close, xpath: '//p-button[contains(@id, "Close")]/button')
  data_grid(:exposures_grid, ExposuresRow)
  p(:no_exposures_msg, text: /No exposure exist/)

  def add_vehicles=(opt)
    add_miscellaneous_vehicles if opt
  end

  def add_land=(opt)
    add_parcels_of_vacant_land if opt
  end

  def next_modal
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
    #save_and_continue ## Need to skip save and continue here
  end
end
