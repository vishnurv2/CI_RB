# frozen_string_literal: true

class NewPersonalAccountModal < BaseModal
  SUG_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:wait_for_agency_suggestions)
  end

  SHOW_MORE_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:view_more)
    before(:value).call(:view_more)
    before(:click).call(:view_more)
    before(:text).call(:view_more)
  end

  text_field(:agency_typeahead_name, name: 'agency', hooks: SUG_HOOKS)
  span(:heading_name, text: 'Log New Personal Account')
  li(:agency_suggestions, xpath: '//li[contains(@class,"p-autocomplete-item")]') # NG11
  select(:agency_contact_select, id: 'agencyContact', hooks: WFA_HOOKS)
  button(:add_another_applicant_button, xpath: './/p-button[@id="addmoreApplicant"]/button')
  button(:save_and_close_button, name: 'SaveandClose')

  radio_set(:gender, text: /ender/)
  radio(:gender_male, text: 'Male')
  radio(:gender_female, text: 'Female')
  radio(:is_contact_yes, text: 'Yes')
  radio(:is_contact_no, text: 'No')

  #Way out for the changes happening in dev env
  # if Nenv.test_env == 'dev'
  #   text_field(:first_name, id: /givenName/)
  #   text_field(:last_name, id: /surname/)
  # end

  text_field(:first_name, id: /givenName/)
  text_field(:last_name, id: /surname/)
  text_field(:middle_name, id: /otherGivenName/)
  text_field(:email, id: /email/)
  text_field(:phone, name: /phone/)
  text_field(:date_of_birth, id: /birthDt/)
  select(:marital_status, id: /maritalStatus/)
  select(:address_index, ng_reflect_name: /selectedAddress/, hooks: WFA_HOOKS)
  span(:user_entered, text: "Use the address exactly as I've entered it.")

  ##-- Sections to add other fields --##
  section(:address_details, AddressDetailSection, id: /addressFields/)
  section(:address_scrubber_alert, AddressScrubbingAlertSection, id: /addressScrubbingAlert/)
  button(:create_account, xpath: './/p-button[@id="SaveAndContinue"]/button')
  i(:close_icon, class: /pi-times cursor-pointer/)
  select(:select_address, xpath: './/app-address//p-dropdown[.//span[text()="New Address"]]')

  def wait_for_agency_suggestions
    wait_for_ajax
    Watir::Wait.until(timeout: 60) { agency_suggestions_element.parent.children.count.positive? }
  end

  # DDL - added some extra wait time for the agency contact to see if it clears up the delay?
  def agency_contact=(contact)
    wait_for_ajax
    sleep(0.5)
    agency_contact_select_element.set(contact)
  end

  def find_agency_suggestion(name)
    wait_for_ajax
    item = nil
    Watir::Wait.until(timeout: 60) { !(item = agency_suggestions_element.parent.children.find { |div| div.text == name }).nil? }
    item
  end

  def select_agency=(text)
    parts = text.split ' '
    entered_text = (parts.first.casecmp('the').zero? ? parts[1] : parts[0])[0..4]
    self.agency_typeahead_name = entered_text
    find_agency_suggestion(text).click
  end

  def address_details=(details)
    address_details.populate_with(details)
    handle_address_scrubber
  end

  def handle_address_scrubber
    return unless address_scrubber_alert?

    address_scrubber_alert.scroll.to
    address_scrubber_alert.button(text: 'Use As Entered').click!

    #Watir::Wait.until { !first_name? || parent_container.error_modal? }
    #parent_container.raise_page_errors 'attempting to save and close an applicant'
  end

  def next_modal
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
    save_and_continue
  end

end
