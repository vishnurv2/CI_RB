# frozen_string_literal: true

class RemoveDomesticAbuseFlagModal < BaseModal

  textarea(:notes, xpath: '//textarea[@inputid="notesDescription"]')
  button(:choose_files, xpath: '//span[contains(text(),"Choose Files")]/ancestor::button')
  button(:remove_flag, xpath: '//span[contains(text(),"Remove Flag")]/ancestor::button')
  div(:attached_document_list, xpath: '//div[contains(@class,"document-list")]')
end