# frozen_string_literal: true

class AddDomesticAbuseFlagModal < BaseModal
  text_field(:reported_by, xpath: '//input[@name="reportedBy"]')
  text_field(:victim, xpath: '//input[@name="victim"]')
  textarea(:notes, xpath: '//textarea[@inputid="notesDescription"]')
  button(:choose_files, xpath: '//span[contains(text(),"Choose Files")]/ancestor::button')
  button(:add_flag, xpath: '//span[contains(text(),"Add Flag")]/ancestor::button')
  div(:attached_document_list, xpath: '//div[contains(@class,"document-list")]')
end