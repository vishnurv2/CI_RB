# frozen_string_literal: true

class TestDataImportHelper
  def self.mvr_csv_to_yml(file_name)
    lines = File.readlines(file_name).map { |l| l.delete('"').split(',') }
    col_names = %w[first_name	middle_name	last_name	suffix ssn date_of_birth gender	license_number dl_state	address_line_1 address_line_2	city state zip_code ncf adpf rating_pack	mvr_processing_status mvr_num_entries_on_driving_record clue_auto_num_claims clue_auto_num_claim_types clue_property_num_claims	clue_property_num_claim_types	discovered_driver vin cca ccp saq instant_id	insurview_attributes vehicle_history]
    data = lines[1..-1].map { |l| col_names.zip(l).to_h }
    File.open("fixtures/#{File.basename(file_name).downcase}.yml", 'wb') { |f| f.write(YAML.dump(data)) }
  end

  def self.applicant_to_api_data(expected_applicant_data)
    api_data = {}
    api_data['partytype'] = 'Person'
    api_data['roles'] = ['Applicant']
    api_data['partyName'] = {}
    expected_applicant_data.each do |k, v|
      api_data['roles'] = ['Applicant', 'Contact'] if k == 'is_contact' && v == 'Yes'
      api_data['partyName']['titlePrefix'] = v if k == 'name_prefix'
      api_data['partyName']['givenName'] = v if k == 'first_name'
      api_data['partyName']['otherGivenName'] = v if k == 'middle_name'
      api_data['partyName']['surname'] = v if k == 'last_name'
      api_data['partyName']['nameSuffix'] = v if k == 'name_suffix'
      api_data['partyName']['nickName'] = v if k == 'nickname'
      api_data['birthDt'] = v if k == 'date_of_birth'
      api_data['gender'] = v if k == 'gender'
      api_data['maritalStatus'] = v if k == 'marital_status'
      api_data['emails'] = v if k == 'emails'
      if k == 'phones'
        api_data['phones'] = []
        v.each do |p|
          phone = {}
          n = p['number']
          t = p['type']
          phone['phoneNumber'] = "(#{n[0..2]}) #{n[3..5]}-#{n[6..9]}"
          phone['phoneTypeCode'] = t
          phone['phoneTypeDescription'] = t
          api_data['phones'] << phone
        end
      end
      if k == 'address'
        api_data['address'] = {}
        parts = v.split(', ')
        api_data['address']['addr1'] = parts[0]
        api_data['address']['city'] = parts[1]
        parts = parts[2].split(' ')
        api_data['address']['state'] = parts[0]
        api_data['address']['postalCode'] = parts[1].gsub('-', '')
        api_data['address']['country'] = 'US'
      end
    end
    return api_data
  end
end
