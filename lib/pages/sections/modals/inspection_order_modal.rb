# frozen_string_literal: true
class InspectionOrderModal < BaseModal
  radio(:exterior, id: 'exterior')
  button(:submit_order, xpath: '//p-button[@id="SubmitOrder"]/button')
  section(:address_details, AddressDetailsSection, id: /addressFields/)

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end