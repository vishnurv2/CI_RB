# frozen_string_literal: true

class OtherDocumentsModal < BaseModal
  file_field(:file_to_upload, xpath: '//div[contains(@class,"drop-region")]/input')
  text_field(:document_title, name: 'DocumentsOtherModalTitle')
  span(:document_status, name: 'DocumentsOtherModalStatus')
  span(:applies_to_account_level, xpath: '//li/span[text()="Account Level"]')
  span(:applies_to_policy, xpath: '//li/span[contains(text(),"IN - ")]')
  button(:upload, xpath: './/p-button[@id="SaveandClose" or @id="SaveAndAddAnother"]/button')
  div(:related_to, text: /Related To/)

  def applies_to=(value)
    if value == 'Account Level'
      if !div(text: 'Account Level').present?
        div(class: /p-multiselect/).click
        applies_to_account_level_element.click unless applies_to_account_level_element.parent.classes.include?('p-highlight')
      end
    else
      # return applies_to_account_level_element.click if value == 'Account Level'
      div(class: /p-multiselect/).click
      applies_to_policy_element.click unless applies_to_policy_element.parent.classes.include?('p-highlight')
    end
  end
end
