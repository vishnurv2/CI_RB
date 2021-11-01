# frozen_string_literal: true

class ContactInfoRow < EDSL::PageObject::Section
  button(:remove)

  # ------ Everything below this line is unverified ------------------------------------- #

  def hidden?
    classes.include?('hidden')
  end

  def visible?
    present? && !hidden?
  end
end

class EmailRow < ContactInfoRow # this class is verified
  text_field(:address)
end

class PhoneRow < ContactInfoRow # this class is verified
  select(:type) # support for type within the application has not been implemented yet

  def number
    input(xpath: './/p-inputmask/input').value
  end

  def number=(new_number)
    number_input = input(xpath: './/p-inputmask/input')
    number_input.execute_script("arguments[0].value = \"#{new_number}\"", number_input)
  end
end

class AddressDetailSection < EDSL::PageObject::Section

  TRIGGER_ADDRESS_SCRUBBER ||= CptHook.define_hooks do
    after(:set).call(:send_keys).with(:tab)
  end

  EDIT_ADDRESS ||= CptHook.define_hooks do
    before(:set).call(:make_address_editable)
  end

  text_field(:address_line_1, id: /addr1/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:address_line_2, id: /addr2/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:address_line_3, id: /addr3/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:city, id: /city/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  select(:state, xpath: './/div[text()="State"]//following-sibling::p-dropdown')
  ## page.add_applicant_modal.address_details.state?
  #select(:state, ng_reflect_input_id: /state/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:zip_code, xpath: './/input[contains(@name,"postalCode") or contains(@id,"postalCode")]')#, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:county, id: /county/, hooks: EDIT_ADDRESS)#, hooks: TRIGGER_ADDRESS_SCRUBBER)
  select(:country, ng_reflect_input_id: 'country', hooks: TRIGGER_ADDRESS_SCRUBBER)
  textarea(:description, id: /addressDescription/)
  text_field(:zip_code_ohio, name: 'postalCode_0', hooks: TRIGGER_ADDRESS_SCRUBBER)

  def address_detail_toggle=(text)
    span(xpath: "//p-selectbutton/.//span[contains(text(), '#{text}')]").click!
  end

  def make_address_editable
    edit_button = button(text: 'Edit')
    wait_for_ajax
    edit_button.click if edit_button.present?
  end

  # ------ Everything below this line is unverified ------------------------------------- #

   def index
     attribute_value(:id).split('_').last.to_i
   end

   def use_entered_address
     scrubbed_address_selection_element.click
     confirm_scrub
   end
end

class AddressDetailsSection < EDSL::PageObject::Section
  PRIMARY_ADDRESS_HOOKS ||= CptHook.define_hooks do
    before(:click).call(:address_type=).with('Primary Address')
    before(:set).call(:address_type=).with('Primary Address')
  end

  DESCRIPTION_HOOKS ||= CptHook.define_hooks do
    before(:click).call(:address_type=).with('Description')
    before(:set).call(:address_type=).with('Description')
  end

  select_button_set(:address_type)
  text_field(:address_line_1, id: /addr1/, hooks: PRIMARY_ADDRESS_HOOKS)
  text_field(:address_line_2, id: /addr2/, hooks: PRIMARY_ADDRESS_HOOKS)
  textarea(:description, hooks: DESCRIPTION_HOOKS)
  text_field(:city, id: /city/)
  select(:state, xpath: './/p-dropdown[.././/*[contains(text(), "State")]]')
  text_field(:zip, xpath: './/input[contains(@id,"postalCode") or contains(@name,"postalCode")]')
  text_field(:county, id: /county/)
  select(:country, ng_reflect_name: /country/)
  text_field(:zip_code_ohio, name: 'postalCode_0', hooks: PRIMARY_ADDRESS_HOOKS)
  text_field(:postal_code, name: 'postalCode_PersonalUmbrella_InitialResidenceAddress_1')

  # ------ Everything below this line is unverified ------------------------------------- #
  #  This is also on the Add applicant, don't belive it was being used.
  #
  # hidden(:bypass_address_scrubber) { |cont| cont.hidden(id: /AddressBypassScrubbingIndicator/) }
  #
  # toggle_button_list(:address_detail_type) { |cont| cont.div(id: /AddressDetailType/) }
  #
  # div(:address_scrubbing_alert, class: 'addressScrubbingAlert')
  # radio(:scrubbed_address_selection, name: 'ScrubbedAddressSelection')
  # button(:confirm_scrub, text: 'Confirm Selection')
  #
  # span(:edit_wrench, class: 'fa-wrench')
  #
  # def index
  #   attribute_value(:id).split('_').last.to_i
  # end
  #
  # def use_entered_address
  #   scrubbed_address_selection_element.click
  #   confirm_scrub
  # end
end
