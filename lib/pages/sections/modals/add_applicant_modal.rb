# frozen_string_literal: true

class ProductsDisplayName < ::BaseSection
  i(:chevron_down, class: /pi-chevron-down/)
  i(:chevron_right, class: /pi-chevron-right/)
  td(:name, data_label: 'Name')
  td(:loan_number, data_label: 'LoanNumber')
  text_field(:description, xpath: './/td[@data-label="LoanNumber"]//input')
  checkbox(:product_checkbox, xpath: './/div[contains(@class,"p-checkbox")]/..')
  checkbox(:account_checkbox, xpath: './/p-table[@id="tblContactApplies"]/div[contains(@class,"ui-table")]//tbody/tr[1]//div[contains(@class,"ui-chkbox")]/div[2]')
end

class AddApplicantModal < BaseModal
  SHOW_MORE_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:view_more)
    before(:value).call(:view_more)
    before(:click).call(:view_more)
    before(:text).call(:view_more)
  end

  select(:existing_party, name: 'existingParty')
  radio_set(:is_contact, text: /pplicant/)
  radio(:is_contact_yes, name: 'isApplicantContactYes')
  radio(:is_contact_no, name: 'isApplicantContactNo')
  radio_set(:gender, text: /gender/)
  radio(:gender_male, xpath: '//p-radiobutton[@value="Male"]')
  radio(:gender_female, text: 'Female')

  text_field(:first_name, id: 'givenName')
  text_field(:last_name, id: 'surname')
  text_field(:middle_name, id: 'otherGivenName')
  text_field(:name_prefix, id: 'titlePrefix', hooks: SHOW_MORE_HOOKS)
  text_field(:name_suffix, id: 'nameSuffix', hooks: SHOW_MORE_HOOKS)
  text_field(:nickname, id: 'nickName', hooks: SHOW_MORE_HOOKS)
  button(:delete_party, xpath: './/p-button[@id="DeleteParty"]/button')
  button(:confirm_delete_role, xpath: './/div[contains(@class,"deleteConfirmationModal")]//p-button[@id="delete"]/button')
  button(:cancel_delete, xpath: './/p-button[contains(@label, "Cancel")]/button')

  #date_of_birth_field(:date_of_birth, name: 'birthDt')
  text_field(:date_of_birth, name: 'birthDt')

  select(:marital_status, name: 'maritalStatus')

  # select(:address_index_select, ng_reflect_name: /selectedAddress/, hooks: WFA_HOOKS)
  select(:address_index, xpath: './/app-address/.//p-dropdown', hooks: WFA_HOOKS)
  
  ##-- Sections to add other fields --##
  section(:address_details, AddressDetailSection, id: /addressFields/)
  sections(:email_addresses, EmailRow, item: { id: /emailSection/ })
  sections(:phone_nums, PhoneRow, item: { id: /phoneSection/ })
  section(:address_scrubber_alert, AddressScrubbingAlertSection, xpath: './/p-panel/div[.//*[contains(text(), "Address Verification")]]')#class: 'addressScrubbingAlert')


  #--Other buttons--#
  button(:add_email_button, xpath: './/p-button[@id="addEmail"]/button | .//button[@id="addEmail"]')
  button(:add_phone_number_button, xpath: './/p-button[@id="addphone"]/button | .//button[@id="addphone"]')
  button(:view_more_button, text: 'View More')
  button(:view_less_button, text: 'View Less')

  #--Edit address details--#
  button(:edit_wrench, xpath: './/p-button[contains(@id, "btnEditAddress")]/button')

  #--Other fields that show up after quoting--#
  text_field(:occupation, id: 'Occupation')
  text_field(:occupation_title, id: 'BusinessTitle')
  # text_field(:org_name, class: 'partyOrganizationName')   ## Not sure if this was used in Old suite
  text_field(:employer, id: 'Employer')

  button(:save_changes_button, xpath: './/button[contains(text(), "Save") or span[contains(text(), "Save")]]')

  toggle_button_list(:party_gender, xpath: '//p-selectbutton[@id="partyGender"]/div')

  #New party - Loss payee
  text_field(:organization_name, id: 'organizationName')
  tab_strip(:tabs, id: 'customTab')
  data_grid(:products_display_name, ProductsDisplayName)
  button(:add_role, xpath: './/p-button[@icon="fal fa-plus" and not(contains(@label,"Add"))]/button')
  link(:additional_insured, xpath: '//span[text()="Additional Insured"]/..')
  link(:trust, xpath: '//span[text()="Trust"]/..')
  link(:loss_payee, xpath: '//span[text()="Loss Payee"]/..')
  button(:delete_role, xpath: './/p-button[@label="Delete Role"]/button')
  div(:message_error, class: /p-message-error/)

  #New Party - Contact
  div(:content, xpath: './/div[@id="role-content"]/app-contact-role/div/div[1]/div')
  div(:first_name_warning, xpath: './/div[contains(@class,"invalid ng-star-inserted")]')
  button(:save_and_add_another_party, xpath:'.//p-button[@id="Save and add another"]/button')
  link(:applicant, xpath: '//span[text()="Applicant"]/..')


  span(:driver_tab, xpath: './/div[@id="customTabMenu"]//span[contains(text(),"Driver")]')
  span(:warning_message, xpath: './/div[contains(@class,"p-message-warn")]//span')
  b(:auto_product_link, xpath: './/tbody//div/b[contains(text(),"Auto")]')
  b(:watercraft_product_link, xpath: './/tbody//div/b[contains(text(),"Watercraft")]')
  span(:edit, class: /fa-pencil/)

  def select_gender=(txt)
    party_gender_element.span(text: txt).click
  end

  def view_more
    view_more_button if view_more_button?
  end

  def view_less
    view_less_button if view_less_button?
  end

  def showing_more?
    view_less_button?
  end

  def showing_less?
    view_more_button?
  end

  def add_email
    orig_count = email_addresses.count
    add_email_button
    Watir::Wait.until { email_addresses.count > orig_count }
  end

  def emails
    visible_emails.map(&:address)
  end

  def visible_emails
    email_addresses.select(&:visible?)
  end

  def emails=(value)
    visible_emails[1..-1].each(&:remove)
    addresses = value.is_a?(String) ? [value] : value.dup
    addresses.each_with_index do |addr, index|
      add_email_button_element.scroll.to
      add_email if index.positive?
      visible_emails.last.address = addr
    end
  end

  def hidden?
    classes.include?('hidden')
  end

  def add_phone_number
    orig_count = phone_nums.count
    add_phone_number_button
    Watir::Wait.until { phone_nums.count > orig_count }
  end

  def visible_phone_numbers
    phone_nums.select(&:visible?)
  end

  def phone_numbers
    visible_phone_numbers.map(&:phone_number)
  end

  def phone_numbers=(value)
    visible_phone_numbers[1..-1].each(&:remove)
    numbers = value.is_a?(String) ? [value] : value.dup
    numbers.each_with_index do |num, index|
      sleep(0.5)
      add_phone_number_button_element.scroll.to
      add_phone_number if index.positive?
      visible_phone_numbers.last.type = num['type']
      visible_phone_numbers.last.number = num['number']
    end
  end

  def address_details=(details)
    self.address_index = 'New Address'
    address_details.populate_with(details)
    handle_address_scrubber
  end

  def address_details_no_scrub=(details)
    self.address_index = 'New Address'
    address_details.populate_with(details)
  end

  def save_and_close
    return unless save_changes_button?

    save_changes_button
    Watir::Wait.until { address_scrubber_alert? || !first_name? || parent_container.error_modal? }
    #parent_container.raise_page_errors 'attempting to save and close an applicant'
    handle_address_scrubber
  end

  def save_and_close_ignore_validation
    return unless save_changes_button?

    save_changes_button
    #Watir::Wait.until { address_scrubber_alert? || !first_name? || parent_container.error_modal? }
    #parent_container.raise_page_errors 'attempting to save and close an applicant'
    handle_address_scrubber
  end


  def handle_address_scrubber
    return unless address_scrubber_alert?

    #Hack for now. for some reason the use_entered on address_scrubber_alert_section could not be found!?
    address_scrubber_alert.button(text: 'Use As Entered').click!
    #address_scrubber_alert.confirm_selection
    save_changes_button

    Watir::Wait.until { !first_name? || parent_container.error_modal? }
    parent_container.raise_page_errors 'attempting to save and close an applicant'
  end

  def edit_wrench=(click)
    edit_wrench if click == "true"
  end

  ADDITIONAL_FIELDS = { 'Non-Person Entity' => [:aka],
                        'Person' => %i[name_prefix name_suffix nickname] }.freeze

  # This will need removed once we have party types again e.g. Non Person stuff
  def party_type
    'Person'
  end

  def showing_more_fields?
    return false unless showing_more?

    ADDITIONAL_FIELDS[party_type].map { |p| send("#{p}?") }.all? { |p| p == true }
  end

  def showing_less_fields?
    return false unless showing_less?

    ADDITIONAL_FIELDS[party_type].map { |p| send("#{p}?") }.none? { |p| p == true }
  end

  # ------ Everything below this line is unverified for angular ------------------------------------- #

  select_list(:preferred_language, hooks: SHOW_MORE_HOOKS) { |cont| cont.select_list(name: /PreferredLanguage/) }
  div(:party_ui, class: 'divParty', default_method: nil)
  button(:save_and_continue, name: 'SaveAndAddApplicant', visible: true, hooks: WFA_HOOKS)
  button(:save_and_close_button, text: 'Save and Close', visible: true, hooks: WFA_HOOKS)

  def index
    party_ui.id.split('_').last.to_i
  end

  def existing_parties_include?(name_parts)
    existing_party.options.each { |option| return true if name_parts.all? { |part| option.downcase.include? part.downcase } }
    false
  end

  # rubocop:disable Lint/UnusedMethodArgument
  def self.form_data(applicant, rv_token)
    form_data_template.result(binding).split("\n").reject(&:empty?).join('&')
  end
  # rubocop:enable Lint/UnusedMethodArgument

  def self.post(client, data)
    page_data = client.get_add_applicant_modal
    form_data = form_data(data, page_data['__RequestVerificationToken'])
    client.post_add_applicant_modal(form_data)
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end

