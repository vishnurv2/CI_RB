# frozen_string_literal: true

class ApplicantSection < EDSL::PageObject::Section
  SHOW_MORE_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:view_more)
    before(:value).call(:view_more)
    before(:click).call(:view_more)
    before(:text).call(:view_more)
  end

  button(:close, class: 'close')
  button(:view_more_button, id: 'applicantPanelViewMore')
  button(:view_less_button, id: 'applicantPanelViewLess')
  toggle_button_list(:party_type) { |cont| cont.div(id: "PartyType[#{cont.index}]") }

  # Fields for type == person
  toggle_button_list(:is_contact) { |cont| cont.div(id: "IsContact[#{cont.index}]") }
  text_field(:first_name, class: 'partyFirstName')
  text_field(:last_name, class: 'partyLastName')
  toggle_button_list(:gender) { |cont| cont.div(id: "Gender[#{cont.index}]") }
  date_field(:date_of_birth) { |cont| cont.text_field(id: "DateOfBirth[#{cont.index}]") }

  # Fields for type == person with view more
  text_field(:name_prefix, hooks: SHOW_MORE_HOOKS) { |cont| cont.text_field(name: "Prefix[#{cont.index}]") }
  text_field(:name_suffix, hooks: SHOW_MORE_HOOKS) { |cont| cont.text_field(name: "Suffix[#{cont.index}]") }
  text_field(:nickname, hooks: SHOW_MORE_HOOKS) { |cont| cont.text_field(name: "NickName[#{cont.index}]") }
  select_list(:preferred_language, hooks: SHOW_MORE_HOOKS) { |cont| cont.select_list(name: "PreferredLanguage[#{cont.index}]") }
  toggle_button_list(:marital_status, hooks: SHOW_MORE_HOOKS) { |cont| cont.div(id: "MaritalStatus[#{cont.index}]") }

  # Fields for type == non-person
  text_field(:org_name, class: 'partyOrganizationName')
  date_field(:start_date) { |cont| cont.text_field(name: "BusinessStartDt[#{cont.index}]") }

  # Fields for type == non-person with view more
  text_field(:aka, hooks: SHOW_MORE_HOOKS) { |cont| cont.text_field(id: "AlsoKnownAs[#{cont.index}]") }

  # Common fields
  sections(:email_addresses, EmailRow, class: 'divEmailPartial', item: { class: 'divEmail' })
  button(:add_email_button, xpath: './/p-button[@id="addEmail"]/button | .//button[@id="addEmail"]')
  button(:add_phone_number_button, xpath: './/p-button[@id="addphone"]/button | .//button[@id="addphone"]')
  sections(:phone_nums, PhoneRow, class: 'divPhonePartial', item: { class: 'divPhone' })

  sections(:address_details, AddressDetailsSection, class: 'divAddress', item: { class: 'divAddressDetails ' })

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
    visible_emails[1..-1].each(&:remove_email)
    addresses = value.is_a?(String) ? [value] : value.dup
    addresses.each_with_index do |addr, index|
      add_email if index.positive?
      visible_emails.last.address = addr
    end
  end

  def visible_phone_numbers
    phone_nums.select(&:visible?)
  end

  def phone_numbers
    visible_phone_numbers.map(&:phone_number)
  end

  def phone_numbers=(value)
    visible_phone_numbers[1..-1].each(&:remove_phone)
    numbers = value.is_a?(String) ? [value] : value.dup
    numbers.each_with_index do |num, index|
      add_phone_number if index.positive?
      visible_phone_numbers.last.phone_number = num['number']
      visible_phone_numbers.last.phone_type = num['type']
    end
  end

  def add_phone_number
    orig_count = phone_nums.count
    add_phone_number_button
    Watir::Wait.until { phone_nums.count > orig_count }
  end

  def index
    attribute_value(:id).split('_').last.to_i
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

  def hidden?
    classes.include?('hidden')
  end

  def address_details=(details)
    address_details.last.populate_with(details)
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end
