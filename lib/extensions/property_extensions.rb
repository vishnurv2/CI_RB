# frozen_string_literal: true

# We monkey patch Hash to provide helper methods for formatting fields
class Hash


  def property_display_address_comma_with_county
    details = self['address_details']
    return property_display_address_street_comma_with_county unless details['description']

    "#{dets['description']}"
  end

  # I made this to keep moving since the address displays differently from Policy or Account page.
  # @return [String]
  def property_display_address_street_comma_with_county
    dets = self['address_details']
    "#{dets['address_line_1']}, #{dets['city']}, #{dets['county']} COUNTY, #{dets['state'][0..1]}, #{dets['zip_code']}".upcase
  end
end
