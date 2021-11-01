# frozen_string_literal: true

class AccountGeneralInfoModal < BaseModal
  select(:agency, id: 'agency')
  select(:agency_contact, id: 'agencyContact')
  select(:underwriter, id: 'underwriter')
  button(:change_agent_of_record, xpath: '//p-button[contains(@id, "ChangeAgentOfRecord")]/button', hooks: WFA_HOOKS)

  # ------ Everything below this line is unverified ------------------------------------- #


  select(:rating_state, id: 'PackageState')
  date_field(:policy_effective_date, id: 'PolicyEffectiveDate')
  date_field(:policy_expiration_date, id: 'PolicyExpirationDate')

  select(:policy_address_index, id: 'PolicyMailingAddressIndex_0_', hooks: WFA_HOOKS) # , assign_method: :select)
  section(:policy_mailing_address, AddressDetailsSection, id: 'divAddressDetailsContainer')
  select(:care_of, id: 'CareOf')
  select(:affiliate_discount, id: 'AffiliateDiscount')
  toggle_button_list(:named_non_owner, id: 'NamedNonOwner')
  sections(:applicants, ApplicantSection, id: 'divApplicantList', item: { class: 'hideOnDelete' })
  button(:add_applicant_button, id: 'btnAddApplicant')

  sections(:manual_losses, AutoGeneralInfoLossPanel, id: 'PolicyLevelLossesContainer', item: { class: 'policyLossPanel' })

  button(:add_manual_loss, class: 'btnAddAnotherPolicyLoss')

  div(:address_scrubbing_alert, class: 'addressScrubbingAlert')
  radio(:scrubbed_address_selection, name: 'ScrubbedAddressSelection')
  button(:confirm_scrub, text: 'Confirm Selection')

  link(:correct_address, data_url: /EditAddress/)

  SUG_HOOKS ||= CptHook.define_hooks { after(:set).call(:wait_for_agency_suggestions) }
  text_field(:agency_typeahead, id: 'typeaheadAgency', hooks: SUG_HOOKS)

  file_field(:file_to_upload, id: 'AgentOfRecordChangeModalDocumentsFileDropBox')
  date_field(:effective_date_of_change, id: 'EffectiveDateOfChange')
  sections(:agency_suggestions, AgencySuggestion, class: %w[tt-dataset tt-dataset-states], item: { class: %w[tt-suggestion tt-selectable] })
  select_list(:agency_producer, id: /AgencyProducerDropdown/)
  section(:new_personal_account_modal, NewPersonalAccountModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Log New Personal Account")]]')

  def agency_name_text=(value)
    parts = value.split(' ')
    self.agency_typeahead = parts.first.casecmp('the').zero? ? parts[1] : parts.first
    find_agency_suggestion(value).click
  end

  def find_agency_suggestion(name)
    wait_for_ajax
    item = nil
    Watir::Wait.until(timeout: 60) { !(item = agency_suggestions.find { |div| div.text == name }).nil? }
    item
  end

  def wait_for_agency_suggestions
    wait_for_ajax
    Watir::Wait.until(timeout: 60) { agency_suggestions.count.positive? }
  end

  def add_applicant
    original_panel_count = applicants.count
    add_applicant_button
    Watir::Wait.until { applicants.count > original_panel_count }
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
