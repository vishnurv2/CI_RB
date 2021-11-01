# frozen_string_literal: true

class PolicyDistributionModal < BaseModal

  button(:next, xpath: '//p-button[contains(@id, "Next")]/button', hooks: WFA_HOOKS)

  #### below is un-verified items!!! ######
  toggle_button_list(:e_policy) { |cont| cont.div(id: /EpolicyIndicator/) }
  select_list(:client_email_select_list, id: 'ClientEmailSelectList', hooks: WFA_HOOKS)
  text_field(:client_email_text, id: 'NewClientEmailTextbox', hooks: WFA_HOOKS)
  #button(:submit, id: 'dynamicModalDefaultButton', hooks: WFA_HOOKS)
  ul(:form_errors, xpath: '//*[@class="col-md-6 validation-summary-errors"]/ul')

  def email=(desired_email)
    if client_email_select_list_element.include? desired_email
      client_email_select_list_element.select desired_email
    else
      client_email_select_list_element.select '--Add new--'
      Watir::Wait.until { client_email_text_element.present? }
      client_email_text_element.set desired_email
    end
  end

  def errors?
    form_errors?
  end
end
