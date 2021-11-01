# frozen_string_literal: true

class AssignedDriverRow < EDSL::PageObject::Section
  td(:vehicle, index: 0)
  td(:driver, index: 1)
  td(:use, index: 2)

  def vehicle_key
    vehicle.strip.downcase
  end
end

class AutoDriverAssignmentPanel < BasePanel
  button(:modify)
  data_grid(:assigned_drivers, AssignedDriverRow) # was "assigned_drivers_grid" prior to Angular AMN 1-22-2020 # , id: 'driverAssignmentGridContent', item: { xpath: './/tbody/tr' })
end
