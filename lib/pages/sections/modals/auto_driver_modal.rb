# frozen_string_literal: true

class AccidentViolationPanel < EDSL::PageObject::Section
  h4(:title)

  span(:panel_title, xpath: './/div[@class="panel-title"]/span')
  checkbox(:dispute, id: /Dispute/)
  select(:reason, id: /disputeReason/)
  textarea(:description, id: /description/)
  textarea(:dispute_remarks, id: /Explanation/)

  # date_field(:occurrence_date, id: /^(Accident|Conviction)Date\[/)
  text_field(:occurrence_date, class: 'datePicker', assign_method: :set!)
  select_list(:occurrence_type, id: /^(Accident|Violation)Type_/)
  button(:delete, class: 'close')

  div(:date_validation, class: 'invalid', text: /[Dd]ate is required/)
  div(:type_validation, class: 'invalid', text: /[Tt]ype is required/)
  div(:description_validation, class: 'invalid', text: /[Dd]escription is required/)

  date_field(:accident_date, id: /accidentDate/)
  select(:accident_type, id: /accidentType/)

  def dispute_with_reason(reason_text)
    dispute_element.check
    self.reason = reason_text
  end

  def occurrence_date=(date)
    occurrence_date_element.set! Chronic.parse(date).to_date.strftime('%m/%d/%Y')
  end

  def populate_details(details)
    occurrence_date_element.set details['date'] unless details['date'].nil?
    occurrence_type_element.select details['type'] unless details['type'].nil?
    description_element.set details['description'] unless details['description'].nil?
  end
end

class AutoDriverModal < BaseModal
  select(:existing_party, name: /xistingParty/)
  radio_set(:gender, text: /Male/)
  radio(:gender_male, text: 'Male')
  radio(:gender_female, text: 'Female')

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

  button(:save_and_add_another_driver, xpath: '//p-button[@id="SaveAndAddAnother"]/button')

  checkbox(:good_student, id: 'goodStudent')
  checkbox(:driver_training, id: 'driverTraining')
  checkbox(:teen_smart_participation, id: 'teenSmartParticipation')
  checkbox(:teen_smart_certification_checkbox, id: 'teenSmartCertification')
  checkbox(:student_away_at_school, id: 'studentAwayAtSchool')
  tab_strip(:tab_strip)
  sections(:accidents_and_violations, AccidentViolationPanel, item: { xpath: './/p-panel[contains(@id, "accident") or contains(@id, "violation")]/div' })
  button(:add_accident_button, xpath: './/p-button[@id="addAccident"]/button')
  button(:save_and_close, xpath: './/p-button[@id="SaveandClose"]/button')

  def add_accident
    add_accident_button_element.scroll.to
    add_accident_button_element.click
  end

  button(:add_violation_button, xpath: './/p-button[@id="addViolation"]/button')
  def add_violation
    add_violation_button_element.scroll.to
    add_violation_button_element.click
  end

  def existing_parties_include?(name_parts)
    name_parts = name_parts.map { |p| p.downcase }
    drop_down_options = existing_party_element.options.map { |o| o.downcase }
    drop_down_options.each { |option| return true if name_parts.all? { |part| option.include? part } }
    false
  end

  def populate_with(data)
    return super unless data.key? 'drivers'

    begin
      data['drivers'].each_with_index do |driver, index|
        Watir::Wait.until { existing_party.text == 'Select' }
        sleep 0.3
        existing_party_element.click
        populate_with(driver)
        #dob = date_of_birth
        #self.first_license_date = "#{dob.month}/#{dob.day}/#{dob.year + 16}"


        save_and_add_another_driver unless index == data['drivers'].count - 1
      end
    rescue Exception => ex
      parent_container.raise_page_errors 'Populating AUTO DRIVER modal'
      raise ex
    end
  end

  # ------ Everything below this line is unverified ------------------------------------- #

  h4(:title, class: 'modal-title')

  date_field(:first_license_date, id: 'FirstLicensedDate')
  text_field(:first_license_date_text_field, id: 'FirstLicensedDate')

  toggle_button_list(:trans_network_coverage, id: 'TransNetworkCoverage')
  toggle_button_list(:teen_smart_certification, id: 'TeenSmartCertification')

  # toggle_button_list(:student_away_at_school, id: 'StudentAwayAtSchool')

  label(:remove_button, text: /Remove Driver/)
  select_list(:remove_reason, id: 'DeleteDriverReasons')

  text_field(:other_insurance_carrier, id: 'OtherInsuranceCarrier')
  text_field(:other_carrier_policy_number, id: 'OtherCarrierPolicyNumber')
  toggle_button_list(:other_carrier_limits, id: 'OtherCarrierLimitsQuestion')

end
