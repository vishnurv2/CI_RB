# frozen_string_literal: true

class AgencyOfRecordChangeModal < BaseModal
  SUG_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:wait_for_agency_suggestions)
  end

  SHOW_MORE_HOOKS ||= CptHook.define_hooks do
    before(:set).call(:view_more)
    before(:value).call(:view_more)
    before(:click).call(:view_more)
    before(:text).call(:view_more)
  end

  text_field(:agency_typeahead, name: 'agency', hooks: SUG_HOOKS)
  li(:agency_suggestions, xpath: '//li[contains(@class,"p-autocomplete-item")]')
  #sections(:agency_suggestions, AgencySuggestion, class: /ng-trigger ng-trigger-overlayAnimation/ ,item: { class: 'ng-star-inserted' })
  file_field(:file_to_upload, xpath: '//div[contains(@class,"drop-control")]/input')
  text_field(:agency, id: 'agency')

  select(:agency_contact, id: 'agencyContact')
  select(:underwriter, id: 'underwriter')
  select(:agency_producer, id: /agencyProducers/)

  date_field(:effective_date_of_change, id: 'effectivDate')

  button(:save_and_close, xpath: '//p-button[@id="SaveandClose"]/button')

  def agency_name=(value)
    parts = value.split ' '
    entered_text = (parts.first.casecmp('the').zero? ? parts[1] : parts[0])[0..4]
    self.agency_typeahead = entered_text
    find_agency_suggestions(value).click
  end


  def find_agency_suggestions(name)
    wait_for_ajax
    item = nil
    Watir::Wait.until(timeout: 60) { !(item = agency_suggestions_element.parent.children.find { |div| div.text == name }).nil? }
    item
    #wait_for_ajax
    #item = nil
    #Watir::Wait.until(timeout: 60) { !(item = agency_suggestions.find { |div| div.text == name }).nil? }
    #Watir::Wait.until(timeout: 60) { (item = agency_suggestions.find { |x| x.text == name }) }
    #item
  end

  def wait_for_agency_suggestions
    wait_for_ajax
    Watir::Wait.until(timeout: 60) { agency_suggestions_element.parent.children.count.positive? }
  end
end
