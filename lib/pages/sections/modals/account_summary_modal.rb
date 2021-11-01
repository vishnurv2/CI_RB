# frozen_string_literal: true

class AccountSummaryModal < BaseModal
  SUG_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:wait_for_agency_suggestions)
  end
  text_field(:agency_typeahead, id: 'typeaheadAgency', hooks: SUG_HOOKS)

  section(:existing_client_modal, ExistingClientModal, xpath: '//div[@id="divModalContent" and .//div/h4 = "Existing Client Information"]')

  select_list(:agency_contact, name: 'AgencyContactName')
  sections(:agency_suggestions, AgencySuggestion, class: %w[tt-dataset tt-dataset-states], item: { class: %w[tt-suggestion tt-selectable] })
  sections(:applicants, ApplicantSection, id: 'divApplicantList', item: { class: 'hideOnDelete' })
  button(:add_applicant_button, id: 'btnAddApplicant')

  def add_applicant
    original_panel_count = applicants.count
    add_applicant_button
    begin
      Watir::Wait.until { applicants.count > original_panel_count }
    rescue Exception => ex
      puts ex.message
      raise ex
    end
  end

  def wait_for_agency_suggestions
    wait_for_ajax
    Watir::Wait.until(timeout: 60) { agency_suggestions.count.positive? }
  end

  def agency_name=(value)
    self.agency_typeahead = value.split(' ').first
    find_agency_suggestion(value).click
  end

  def find_agency_suggestion(name)
    wait_for_ajax
    item = nil
    Watir::Wait.until(timeout: 60) { !(item = agency_suggestions.find { |div| div.text == name }).nil? }
    item
  end
end
