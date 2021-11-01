# frozen_string_literal: true

class LogActivityModal < BaseModal
  select(:related_to, id: /relatedTo/)
  checkbox(:priority_restrictive, id: /priorityRestrictiveInd/)
  select(:send_to, id: 'sendToDropdown')
  li(:send_to_email_option, xpath: './/div[contains(@class,"p-autocomplete-panel")]/ul/li')
  div(:description, class: /ql-editor/)
  button(:log_activity_button, xpath: './/p-button[@id="logActivity"]/button')
  select(:activity_type, xpath: './/p-dropdown[@id="activityType"]')
  checkbox(:create_task, id: /createTask/)
  button(:bold, xpath: '//button[@class="ql-bold"]')
  button(:italic, xpath: '//button[@class="ql-italic"]')
  button(:underline, xpath: '//button[@class="ql-underline"]')
  span(:pickerlabel_color, xpath: '//span[@class="ql-color ql-picker ql-color-picker"]')
  span(:pickerlabel_background, xpath: '//span[@class="ql-background ql-picker ql-color-picker"]')
  button(:ql_links, xpath: '//button[@class="ql-link"]')
  button(:attach_file, xpath: '//p-button[contains(@id,"attachFile")]/button')

#  send email modal
  select(:email_from, id: /emailFrom/)
  text_field(:email_to, xpath: './/p-autocomplete[contains(@id, "contacts")]//input')
  text_field(:subject, id: /subject/)
  button(:close, xpath: './/p-button[@ptooltip="Close"]/button')

end
