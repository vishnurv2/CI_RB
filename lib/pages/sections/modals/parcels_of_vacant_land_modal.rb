# frozen_string_literal: true

class VacantLandAddress < BaseSection
  span(:expand_or_collapse, xpath: './/div[contains(@class,"ui-accordion-header")]//span[contains(@class,"bold-text")]')
  span(:chevron, xpath: './/div[contains(@class,"ui-accordion-header")]/a/span')
  button(:remove_address, xpath: './/p-button[contains(@id,"removeAddress")]/button')
  select(:select_address, xpath: './/input[contains(@id,"addresslist")]/../../..')
  button(:add_address, xpath: './/p-button[contains(@id,"addAddres_0")]/button')
  section(:address_details, AddressDetailSection, id: /addressFields/)

  def chevron_down?
    chevron_element.classes.include? 'pi-chevron-down'
  end
end

class ParcelsOfVacantLandModal < BaseModal
  button(:add_miscellaneous_vehicles, xpath: '//p-button[contains(@id, "AddMiscellaneousVehicles")]/button')
  button(:add_address, xpath: '//p-button[@id="addAddress"]/button')
  sections(:vacant_land_address, VacantLandAddress, xpath: '.', item: {xpath: './/p-accordiontab', how: :elements})
  link(:parcel_of_vacant_land, id: /p-accordiontab/)
end
