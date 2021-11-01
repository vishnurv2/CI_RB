# frozen_string_literal: true

# We monkey patch Hash to provide helper methods for formatting fields
class Hash
  ONE_YEAR_IN_SECONDS ||= 31_536_000

  # Convert an applicant fixture hash to an int with their age
  # @return [String]
  def applicant_age
    # Difference in years, less one if you have not had a birthday this year.
    birth_date = Chronic.parse(self['date_of_birth'] || self[:date_of_birth]).to_date
    a = Date.today.year - birth_date.year
    a -= 1 if birth_date.month > Date.today.month || (birth_date.month >= Date.today.month && birth_date.day > Date.today.day)
    a
  end

  # Convert an applicant fixture hash to a string with their full name suitable for comparing against the page
  # @return [String]
  def applicant_full_name
    [self['name_prefix'], self['first_name'], self['middle_name'], self['last_name'], self['name_suffix'], "(#{applicant_age})", self['org_name']].join(' ').gsub('  ', ' ').strip
  end

  def applicant_name
    [self['first_name'], self['middle_name'], self['last_name']].join(' ').gsub('  ', ' ').strip
  end

  def vehicle_modal
    [self['xxblack_book_year'], self['xxblack_book_make'], self['xxblack_book_model'].upcase].join( ' ').gsub('  ', '  ').strip
  end

  def driver_name
    [self['name_prefix'], self['first_name'], self['middle_name'], self['last_name'], self['name_suffix']].join(' ').gsub('  ', '  ').strip
  end

  def driver_dropdown_name_with_age
    "#{self[:existing_account_party]} (#{applicant_age})"
  end

  # Convert an applicant fixture hash to a string with their first phone number suitable for comparing against the page
  # @return [String]
  def applicant_phone_with_type
    "#{self['phone_numbers'].first['number']} (#{self['phone_numbers'].first['type']})"
  end

  # Convert an applicant fixture hash to a string with their address suitable for comparing against the page regardless of address type
  # @return [String]
  def applicant_display_address
    dets = self['address_details']
    return applicant_display_address_street unless dets['description']

    "#{dets['description']}"

    ## Took this out as it was adding address and description --  not what we need in Angular
    #"#{applicant_display_address_description}, #{dets['city']}, #{dets['state'][0..1].upcase} #{dets['zip_code']}"
  end

  def applicant_display_address_comma
    details = self['address_details']
    return applicant_display_address_street_comma unless details['description']

    "#{dets['description']}"
  end

  # Convert an applicant fixture hash to a string with their address suitable for comparing against the page when they have a street address
  # @return [String]
  def applicant_display_address_street
    dets = self['address_details']
    "#{dets['address_line_1']}, #{dets['city']}, #{dets['state'][0..1]} #{dets['zip_code']}".upcase
  end

  # I made this to keep moving since the address displays differently from Policy or Account page.
  # @return [String]
  def applicant_display_address_street_comma
    dets = self['address_details']
    "#{dets['address_line_1']}, #{dets['city']} #{dets['state'][0..1]} #{dets['zip_code']}".upcase
  end

  # For comparing City State Zip under Applicant name on Auto summary page
  def applicant_display_address_city
    dets = self['address_details']
    "#{dets['city']}, #{dets['state'][0..1]} #{dets['zip_code']}".upcase
  end

  # Convert an applicant fixture hash to a string with their address suitable for comparing against the page when they have a description address
  # @return [String]
  def applicant_display_address_description
    self['address_details']['description'].length < 50 ? self['address_details']['description'] : "#{self['address_details']['description'][0..49]}..."
  end
end
