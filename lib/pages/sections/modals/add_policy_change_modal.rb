# frozen_string_literal: true

class AddPolicyChangeModal < BaseModal
  textarea(:description, id: 'description')
  select_button_set(:date, id: 'type')
  #toggle_button_list(:date) { |cont| cont.label(id: /DateLabel/) }
  text_field(:specific_date, name: 'EffectiveDate')
  date_field(:specific_date_text, name: 'EffectiveDate')
  button(:save_and_continue_button, xpath: '//p-button[@id="SaveAndContinue"]/button')
end