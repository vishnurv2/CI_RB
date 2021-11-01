#frozen_string_literal: true

class PaymentOptionsPageRow < BaseSection
  td(:actions, index: 5)
  td(:billing_account, index: 0)
  td(:product, index: 1)
  td(:payor, index: 2)
  td(:bill_plan, index: 4)
  td(:payment_method, index: 3)
  td(:recommended_down_payment, index: 6)
  td(:received_down_payment, index: 6)
  span(:edit_billing_acct, class: /fa-pencil/, default_method: :click, hooks: WFA_HOOKS)
end

class PaymentOptionsPage < PolicyManagementPage
  page_url "#{Nenv.base_url}/PolicyAdminWeb/billing"

  def displayed?
    browser.url.include?("PolicyAdminWeb/billing")
  end

  button(:add_product_to_billing_act, text: 'Add Billing Account', hooks: WFA_HOOKS)
  span(:account_number_message, class: 'ui-messages-summary')

  # ------ Everything below this line is unverified ------------------------------------- #
  span(:client_name, name: 'ClientName')
  span(:client_address, name: 'ClientAddress')

  link(:add_product_to_billing_act_disabled, class: %w[btn btn-default disabled])
  data_grid(:billing_accounts, PaymentOptionsPageRow) # was "billing_accounts_grid" prior to Angular AMN 1-22-2020 # , id: 'billingAccountPanel', item: { xpath: './/tbody/tr' })
  # span(:edit_billing_acct, class: 'fa-pencil-alt', default_method: :click, hooks: WFA_HOOKS)

  def resolve_issues_to_resolve(fixture_file = 'billing_modal_defaults')
    #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
    RubyExcelHelper.safe_load_fixture_file(fixture_file)
    data_from_fixture = data_for('billing_account_add_product_modal')
    add_product_to_billing_act
    modal = billing_account_add_product_modal
    modal.populate_billing_modal(data_from_fixture)
    modal.next_modal
    return billing_accounts.first.billing_account # get account number for comparision later
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end
