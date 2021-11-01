class InsertFileModal < BaseModal
  link(:browse_your_files, xpath: '//a[contains(text(), "browse your files")]')
  link(:upload_new, xpath: '//span[contains(text(),"Upload New")]/..')
  file_field(:file_to_upload, xpath: '//div[contains(@class,"drop-region")]/input')
  span(:applies_to_account_level,xpath: '//li/span[text()="Account Level"]')
  button(:insert_button, xpath: './/p-button[@id="SaveandClose" or @id="SaveAndAddAnother"]/button')
  div(:related_to, text: /Related To/)
  span(:applies_to_policy, xpath: '//li/span[contains(text(),"IN - ")]')

  def account_level=(value)
    div(class: /p-multiselect/).click
    if value == true
      applies_to_account_level_element.click unless applies_to_account_level_element.parent.classes.include?('p-highlight')
    else
      # return applies_to_account_level_element.click if value == 'Account Level'
      applies_to_policy_element.click unless applies_to_policy_element.parent.classes.include?('p-highlight')
    end
  end
end