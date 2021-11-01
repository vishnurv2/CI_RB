# frozen_string_literal: true

class WatercraftOperatorModal < BaseModal
  select(:existing_party, name: /xistingParty/)
  radio_set(:gender, name: 'gender')
  text_field(:first_name, id: /irstName/)
  text_field(:middle_name, id: /iddleName/)
  text_field(:last_name, id: /astName/)
  text_field(:name_prefix, id: /refix/)
  text_field(:name_suffix, id: /uffix/)

  date_of_birth_field(:date_of_birth, name: 'dateOfBirth')
  select(:marital_status, id: 'maritalStatus')
  select(:relationship_to_applicant, id: 'relationshipToApplicant')
  select(:license_state, id: 'licenseState')
  text_field(:license_number, id: 'licenseNo')
  select(:years_of_boating_experience, id: /yearsOfBoatingExperience/)
  radio_set(:safety_course, name: /safetyCourse/)

end