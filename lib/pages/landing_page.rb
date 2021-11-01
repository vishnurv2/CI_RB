# frozen_string_literal: true
#
class LandingPage < PolicyManagementPage


  # ------ Everything below this line is unverified ------------------------------------- #
  #
  #
  link(:billing_payments_button, text: 'Billing/Payments')
  link(:view_policies_button, text: 'View Policies')
  link(:work_with_quotes_button, text: 'Work w/Quotes')
  link(:add_products_button, text: 'Add Products')
  link(:text_eoptions_button, text: 'Manage Text & E-options')
  link(:policy_change_button, text: 'Policy Change')
  link(:claims_button, xpath: '//div[@id="divMainContent"] and ..//a[contains(text(), "Claims")]')


  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end
