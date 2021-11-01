# frozen_string_literal: true

class AutoGeneralInfoLossPanel < BaseSection

  button(:delete, xpath: './/p-button[contains(@id, "removeLoss")]/button')
  text_field(:date, id: /LossDate/)
  select(:type)
  # Everything below this line is unverified
  span(:validation_message, class: 'field-validation-error')

  div(:date_validation, class: 'invalid', text: /ate/)
  div(:type_validation, class: 'invalid', text: /ype/)

  def has_validation_message?
    div(class: 'invalid').present?
  end
end

class AutoGeneralInfoModal < BaseModal
  TRIGGER_ADDRESS_SCRUBBER ||= CptHook.define_hooks do
    after(:set).call(:send_keys).with(:tab)
  end

  EDIT_ADDRESS ||= CptHook.define_hooks do
    before(:set).call(:make_address_editable)
  end

  SCROLL_HOOKS ||= CptHook.define_hooks do
    before(:click).call(->(e) { e.scroll.to }).with(:self)
    before(:set).call(->(e) { e.scroll.to }).with(:self)
  end

  select(:rating_state, id: 'RatingState')
  date_field(:effective_date, id: 'EffectiveDate')
  date_field(:expiration_date, id: 'ExpirationDate')
  select(:mailing_address, ng_reflect_name: /selectedAddress/, hooks: WFA_HOOKS)
  select(:policy_mailing_address, xpath: './/div[contains(@ngmodelgroup, "address")]/following-sibling::div/div/p-dropdown')
  text_field(:address_line_1, id: /addr1/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:address_line_2, id: /addr2/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:address_line_3, id: /addr3/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:city, id: /city/, hooks: TRIGGER_ADDRESS_SCRUBBER)
  select(:address_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown')
  text_field(:zip_code, xpath: './/input[contains(@name,"postalCode") or contains(@id,"postalCode")]')#, hooks: TRIGGER_ADDRESS_SCRUBBER)
  text_field(:county, id: /county/, hooks: EDIT_ADDRESS)#, hooks: TRIGGER_ADDRESS_SCRUBBER)
  select(:country, ng_reflect_input_id: 'country', hooks: TRIGGER_ADDRESS_SCRUBBER)
  textarea(:description, id: /addressDescription/)

  def make_address_editable
    edit_button = button(text: 'Edit')
    wait_for_ajax
    edit_button.click if edit_button.present?
  end

  select(:care_of, id: 'CareOf')
  select(:affiliate_discount, id: 'AffiliateDiscount')
  select(:producer, id: 'agencyProducers')
  radio_set(:transfer_question, id: /Trbook/)
  radio_set(:remarket_question, id: /Remarket/)
  text_field(:prior_carrier, name: 'priorCarrier')
  text_field(:prior_premium, name: 'PriorAnnualPremium')
  radio_set(:named_non_owner, id: /NonOwner/)
  select(:territory, id: 'Territory')
  sections(:manual_losses, AutoGeneralInfoLossPanel, item: { id: /lossBlock/ })
  button(:add_manual_loss, xpath: './/p-button[@id="ManualLoss"]/button', hooks: SCROLL_HOOKS)
  button(:save_and_close, xpath: './/span[contains(text(),"Save and close")]/..')
  i(:cross_button, class: /cursor-pointer/)
  text_field(:effective_date_text_field, xpath: './/*[@id="EffectiveDate"]/span/input')

  # This modal has a unique save and continue - in BASE
  # button(:save_and_continue, name: 'SaveAndContinue', hooks: WFA_HOOKS)

  #WATERCRAFT
  label(:question_attach_policy, text: /Attach Watercraft to Home Policy/)
  checkbox(:attach_policy_option, id: /AttachToPolicy/)

  def attach_policy_options_disabled?
    attach_policy_option.label.classes.include? 'ui-label-disabled'
  end

  def default_attach_policy_option(txt)
    if txt == "Yes"
      attach_policy_option.div(class: /p-checkbox-box/).attributes[:aria_checked] == 'true'
    else
      if txt == "No"
        attach_policy_option.div(class: /p-checkbox-box/).attributes[:aria_checked] == 'false'
      end
    end
  end

  def next_modal
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
    save_and_continue
  end

  # Everything below this line is unverified
  #
  #
  date_field(:policy_effective_date, id: 'PolicyEffectiveDate')
  date_field(:policy_expiration_date, id: 'PolicyExpirationDate')

  text_field(:policy_effective_date_text_field, id: 'PolicyEffectiveDate')

  select(:policy_address_index, xpath: './/app-address/.//p-dropdown', hooks: WFA_HOOKS) # , assign_method: :select)
  sections(:applicants, ApplicantSection, id: 'divApplicantList', item: { class: 'hideOnDelete' })
  button(:add_applicant_button, id: 'btnAddApplicant')

  div(:address_scrubbing_alert, class: 'addressScrubbingAlert')
  radio(:scrubbed_address_selection, name: 'ScrubbedAddressSelection')
  button(:confirm_scrub, text: 'Confirm Selection')

  link(:correct_address, data_url: /EditAddress/)

  def add_applicant
    original_panel_count = applicants.count
    add_applicant_button
    Watir::Wait.until { applicants.count > original_panel_count }
  end

  def producer_index=(index)
    producer.select_index index
  end

  def manual_losses=(losses)
    losses.each do |loss|
      add_manual_loss
      Watir::Wait.until { last_manual_loss_empty? }
      loss.each { |k, v| manual_losses.last.send("#{k}=", v.to_s) }
    end
  end

  def last_manual_loss_empty?
    l = manual_losses.last
    !l.nil? && l.date_box? && l.date_box_element.value.empty? && l.type? && l.type == '--Select--'
  end

  def use_entered_address
    scrubbed_address_selection_element.click
    confirm_scrub
  end

  ## Old way of using API for posting data
  def self.post(client, data = nil, activity_id = nil)
    activity_id ||= client.last_activity_id
    data ||= data_for_this_page
    fields = client.get_auto_general_info_modal(activity_id)

    # Turn _1_ into [1]
    fields.keys.each { |f| fields[f.gsub(/_(\d)_/, '[\1]')] = fields.delete(f) }

    fields['PreviousModal'] = fields.delete('hiddenScreenName')
    fields['PolicyActivityId'] = fields.delete('hiddenPolicyActivityId')

    fields.merge!(data).merge!('PackageState' => 'IN', 'CareOf' => 'None', 'SaveAndContinue' => nil, 'X-Requested-With' => 'XMLHttpRequest')

    client.post_auto_general_info_modal(fields)
  end
end
