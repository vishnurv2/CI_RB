# frozen_string_literal: true

class CancelNonRenewModal < BaseModal
  select_button_set(:policy_transaction_type, id: 'btncancelNonRenew')
  select(:reason_dropdown, name: 'transcationReason')
  button(:save_and_close, xpath: '//p-button[@id="SaveandClose"]/button')
  button(:close, xpath: '//p-button[@id="Close"]/button')
  date_field(:cancel_effective_date, name: 'cancellationEffectiveDate')
  toggle_button_list(:reason_type, id: 'ReasonType')
  textarea(:wording_on_notice, id: 'txtWordingNotice')
  text_field(:notice_date, id: 'sendNoticeDate')
  span(:policy_mailing_address, name: 'PolicyAddress')
  button(:remove_cancellation, xpath: '//p-button[contains(@id, "RemoveCancellation")]/button')
  button(:remove_non_renewal, name: 'RemoveDoNotRenew')
  div(:cancel_effective_date_label, xpath: './/div[contains(text(), "Cancellation Effective Date")]/following::div', hooks: TEXT_WAIT_HOOKS)

  # this isnt actually getting the next div.  there is no next div, only text inside it?
  div(:non_renewal_effective_date_label, xpath: './/div[contains(text(), "Non-Renewal Effective Date")]/..', hooks: TEXT_WAIT_HOOKS)

  select_list(:non_renew_reason_dropdown_list, id: 'SelectedReasonNonRenew')

  select(:non_renew_reason_dropdown, name: 'transcationReason')

  date_field(:non_renew_notice_date, name: 'sendNoticeDate') #drop down date field.

  div(:cancel_non_renew_option, class: /p-selectbutton/)

  def policy_transaction_type=(name)
    policy_transaction_type_element.span(text: name).click
  end

  def expected_mailing_address
    data_used = EDSL::PageObject.fixture_cache['account_entry_page']['applicants'].first['address_details']
    expected_addr = "#{data_used['address_line_1']}, #{data_used['city']}, #{STATE_NAME_TO_ABBR[data_used['state']]} #{data_used['zip_code']}"
    expected_addr
  end

  def populate_cancel_modal(data)
    populate_with(data)
  end

  def effective_date
    Date.strptime(cancel_effective_date_label, '%m/%d/%Y')
  end

  def notice_date_fixed
    Date.strptime(notice_date, '%m/%d/%Y')
  end

  def calculate_notice_effective_day_difference
    DateTime.parse(effective_date.to_s).mjd - DateTime.parse(notice_date_fixed.to_s).mjd
  end

  def non_renewal_effective_date
    ## Need to strip the date from the text!
    Date.strptime(non_renewal_effective_date_label.split("\n").last, '%m/%d/%Y')
  end

  def calculate_notice_non_renewal_effective_day_difference
    DateTime.parse(non_renewal_effective_date.to_s).mjd - DateTime.parse(non_renew_notice_date.to_date.to_s).mjd
  end

  def cancel_effective_date_input=(input_date)
    Chronic.parse(input_date).strftime('%m/%d/%Y')
  end
end
