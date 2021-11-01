# frozen_string_literal: true
class PPCInformationSection < BaseSection
  span(:title, text: 'Protection Class')
end

class GeocodingInformationSection < BaseSection
  span(:title, text: 'Geocoding Information')
  span(:auto_territories, xpath: '//strong[text()="Auto Territories"]/../..//span')
  span(:home_territories, xpath: '//strong[text()="Home Territories"]/../..//span')
  div(:dwelling_territories, xpath: '//strong[text()="Dwelling Territories"]/../following-sibling::div')
  div(:geocoded_address, xpath: './/strong[text()="Geocoded Address"]/../following-sibling::div')
  div(:distance_to_coast, xpath: './/strong[text()="Distance To Coast"]/../following-sibling::div')
  div(:description, xpath: './/strong[text()="Description"]/../following-sibling::div')
end

class LocationInformationSection < BaseSection
  span(:title, text: 'Location Information')
  div(:address, xpath: './/strong[text()="Address"]/../following-sibling::div')
end

class TerritoryReportModal < BaseModal
  section(:ppc_information_section, PPCInformationSection, xpath: '//p-panel[@id="ppcInformation"]/div')
  section(:geocoding_information_section, GeocodingInformationSection, xpath: '//p-panel[@id="geocodingInformation"]/div')
  section(:location_information_section, LocationInformationSection, xpath: '//p-panel[@id="locationInformation"]/div')

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
