# frozen_string_literal: true

class AccountEntryPage < PolicyManagementPage
  page_url "#{Nenv.base_url}/PolicyManagement/Account/Entry"

  SUG_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:wait_for_agency_suggestions)
  end

  text_field(:agency_typeahead, id: 'typeaheadAgency', hooks: SUG_HOOKS)

  #section(:existing_client_modal, ExistingClientModal, xpath: '//div[@id="divModalContent" and .//div/h4 = "Existing Client Information"]')
  section(:existing_client_modal, ExistingClientModal, xpath: '//div[@role="dialog" and .//div/span = "Existing Account Found"]')
  #moved to policy management page section(:add_applicant_modal, AddApplicantModal, xpath: '//div[@id="divModalContent" and .//div/h4[contains(text(), " - Applicant")]]')
  select_list(:agency_contact, name: 'AgencyContactName', hooks: WFA_HOOKS)
  section(:personal_products, PersonalProductsSelection, id: 'dvProducts')
  sections(:agency_suggestions, AgencySuggestion, class: %w[tt-dataset tt-dataset-states], item: { class: %w[tt-suggestion tt-selectable] })

  sections(:applicants, ApplicantRow, id: 'divApplicantList', item: { xpath: '//tbody/tr[.//td[@class ="action-cell"]]', how: :trs })

  select(:state, id: 'State')
  link(:add_applicant_button, text: 'Add Applicant', hooks: WFA_HOOKS)
  div(:policy_dates_section, id: 'policyDatesSection')
  date_field(:policy_effective_date, id: 'PolicyEffectiveDate')
  date_field(:policy_expiration_date, id: 'PolicyExpirationDate')
  span(:effective_date_validation, for: 'PolicyEffectiveDate')

  button(:save_and_continue_button, name: 'SaveAndContinue', visible: true)

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end

  def save_and_continue
    # TODO: Add code to handle address scrubber being down.
    wait_for_modal_masker
    leave_page_using(:save_and_continue_button)
  rescue Exception => ex
    # rubocop:disable Lint/Debugger
    binding.pry if Nenv.cuke_debug?
    # rubocop:enable Lint/Debugger
    raise ex
  end

  def leave_page_using(method, expected_url = nil)
    cur_url = browser.url
    _call_or_send(method)
    _wait_for_url_change(cur_url, expected_url)
  end

  def _wait_for_url_change(cur_url, expected_url = nil)
    Watir::Wait.until(timeout: 90) { (expected_url ? browser.url == expected_url : browser.url != cur_url) || errors? || existing_client_modal? }

    return handle_existing_client_modal if existing_client_modal?

    wait_for_ajax
    raise_page_errors "navigating from #{cur_url}"
  end

  def handle_existing_client_modal
    return unless existing_client_modal?

    existing_client_modal.delete_all_existing_except_one
    cur_url = browser.url
    populate_existing_client_modal
    Watir::Wait.until { browser.url != cur_url || errors? }
    wait_for_ajax
    raise_page_errors
  end

  def populate_existing_client_modal
    data = fixture_fetch(populate_key)
    existing_client_modal.add_as_new unless data['add_to_existing_account']
    existing_client_modal.save_and_continue
  end

  def add_applicant
    add_applicant_button_element.click!
    Watir::Wait.until(timeout: 60) { add_applicant_modal? }
    wait_for_ajax
  end

  def wait_for_agency_suggestions
    wait_for_ajax
    Watir::Wait.until(timeout: 60) { agency_suggestions.count.positive? }
  end

  def agency_name_text=(value)
    parts = value.split(' ')
    self.agency_typeahead = parts.first.casecmp('the').zero? ? parts[1] : parts.first
    find_agency_suggestion(value).click
  end

  def agency_name=(value)
    self.agency_name_text = value
    override_discontinued_agency
  end

  def find_agency_suggestion(name)
    wait_for_ajax
    item = nil
    Watir::Wait.until(timeout: 60) { !(item = agency_suggestions.find { |div| div.text == name }).nil? }
    item
  end

  def applicants=(value)
    value.each do |applicant|
      add_applicant
      add_applicant_modal.populate_with(applicant)
      add_applicant_modal.save_and_close
      wait_for_modal_masker
    end
  end

  def ready?
    wait_for_ajax
    add_applicant_button? && save_and_continue_button?
  end

  def effective_date_exact_text=(date_text)
    text_field(id: 'PolicyEffectiveDate').set date_text
    send_keys(:tab)
  end

  def effective_date_exact_text
    text_field(id: 'PolicyEffectiveDate').value
  end

  def self.post(client, data = nil)
    data ||= data_for_this_page
    hidden = client.get_account_entry_page
    client.add_product_blob('Automobile')
    agency_info = client.get_agency_info(data['agency_name'])
    data['applicants'].each { |a| AddApplicantModal.post(client, a) }
    client.reload_party_table
    client.post_account_entry_page(form_data(data, agency_info, hidden['__RequestVerificationToken']))
  end

  # rubocop:disable Lint/UnusedMethodArgument
  def self.form_data(data, agency_info, rv_token)
    form_data_template.result(binding).split("\n").reject(&:empty?).join('&')
  end
  # rubocop:enable Lint/UnusedMethodArgument
end
