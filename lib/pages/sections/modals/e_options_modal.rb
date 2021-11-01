# frozen_string_literal: true
# this entire file has been verified for Angular

class TextPhoneCard < BaseSection
  text_field(:number, id: /PhoneNumber/)
  toggle_switch(:auto_enroll, id: /newTextMessage/)
  toggle_switch(:billing_statement_available, id: /billingStatement/)
  toggle_switch(:due_date_reminder, id: /dueDateReminder/)
  toggle_switch(:payment_confirmation, id: /paymentConfirmation/)
  toggle_switch(:claims_rep_assigned, id: /claimAssigned/)
  toggle_switch(:payment_issued, id: /paymentIssued/)
  button(:delete, id: /btnDeletePhone/)
end

class EOptionsModal < BaseModal
  toggle_switch(:e_billing, id: 'eBilling')
  select(:e_billing_email, id: 'ddlEBilling')
  # text_field(:new_e_billing_email, id: 'newBillingEmail') # this text field is not yet complete

  toggle_switch(:e_policy, id: 'ePolicy')
  select(:e_policy_email, id: 'ddlEPolicy')
  text_field(:new_e_policy_email, id: 'txtNewPolicyEmail')

  toggle_switch(:e_signature, id: 'eSignature')
  select(:e_signature_email, id: 'ddlESignature')
  text_field(:new_e_signature_email, id: 'newSignatureEmail')

  toggle_switch(:my_central_security, id: 'centralSecurity')
  toggle_switch(:text_notifications, id: 'txtNotification')
  sections(:text_notification_phones, TextPhoneCard, xpath: './/*[app-add-phone]', item: { class: 'card-body' })
  button(:new_phone, id: 'btnAddNewPhone')
end
