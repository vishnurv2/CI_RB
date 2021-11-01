# frozen_string_literal: true

class VehiclesAndDriversFoundModal < BaseModal
  checkbox(:vehicle_and_driver, xpath: './/p-checkbox[contains(@class, "ng-valid")]')
end