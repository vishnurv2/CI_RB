# frozen_string_literal: true

class TextNotificationSections < BaseSection
  text_field(:mobile_phone, id: /PhoneNumber/)
  button(:trash_icon, xpath: './/span[contains(@class,"fa-trash")]/..')
  checkbox(:statement_available, xpath: './/label[contains(text(),"Statement Available")]/..')
  checkbox(:due_date_reminder, xpath: './/label[contains(text(),"Due Date Reminder")]/..')
  checkbox(:payment_confirmation, xpath: './/label[contains(text(),"Payment Confirmation")]/..')
  checkbox(:automatic_credit_card_about_to_expire, xpath: './/label[contains(text(),"Automatic Credit Card - Card About to Expire")]/..')
  checkbox(:automatic_credit_card_declined, xpath: './/label[contains(text(),"Automatic Credit Card Declined")]/..')
  checkbox(:reinstatement_notice, xpath: './/label[contains(text(),"Reinstatement Notice")]/..')
  checkbox(:clain_reported, xpath: './/label[contains(text(),"Claim Reported")]/..')
  checkbox(:claim_representative_assigned_to_claim, xpath: './/label[contains(text(),"Claim Representative Assigned to Claim")]/..')
  checkbox(:payment_issued, xpath: './/label[contains(text(),"Payment Issued")]/..')
  checkbox(:rental_car_reserved, xpath: './/label[contains(text(),"Rental Car Reserved")]/..')
  checkbox(:representative_appointment, xpath: './/label[contains(text(),"Representative Appointment")]/..')
  checkbox(:representative_appointment_reminder, xpath: './/label[contains(text(),"Representative Appointment Reminder")]/..')
  checkbox(:automatically_enroll, xpath: './/label[contains(text(),"Automatically enroll")]/..')
end

class PolicyDistributionRows < ::BaseSection
  div(:product, xpath: '//span[contains(@class,"product-icon")]/../..')
  span(:e_policy, class: /pi pi-check-circle/)
  link(:notices_sent_to, xpath: './/div[contains(@class,"hide-on-sm")]//a[contains(@href,"mailto")]')
  button(:action_icon, class: /action-icon/)
end

class AddEmailsModal < BaseModal
  text_field(:email, id: /email/)
  button(:save_email_button, xpath: './/p-button[@id="saveEmail"]/button')
  button(:cancel_button, xpath: './/p-button[@id="cancel"]/button')
end

class CommunicationPreferencePage < PolicyManagementPage

  def displayed?
    browser.url.include?('PolicyAdminWeb/communicationpreference')
  end

  page_url "#{Nenv.base_url}/PolicyAdminWeb/communicationpreference/"

  tab_strip(:tabs, id: 'customTab')

  link(:policy_distribution_tab, xpath: '//span[contains(text(),"Policy Distribution")]/..')
  link(:e_billing_tab, xpath: '//span[contains(text(),"E-Billing")]/..')
  link(:e_signature_tab, xpath: '//span[contains(text(),"E-Signature")]/..')
  link(:text_notification_tab, xpath: '//span[contains(text(),"Text Notification")]/..')

  data_grid(:policy_distribution_rows, PolicyDistributionRows)
  sections(:text_notification_sections, TextNotificationSections, id: 'MainContentRouterOutlet', item: { xpath: './/app-text-notification//form//p-panel/div', how: :divs})
  button(:save_text_preferences, xpath: '//button[@label="Save text preferences"]')

  select(:email, id: /email/)
  checkbox(:select_all_products, name: /allChk/)
  section(:add_emails_modal, AddEmailsModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Add Emails")]]')

end
