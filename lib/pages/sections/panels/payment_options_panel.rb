# frozen_string_literal: true

class PaymentOptionsPanelRow < ::BaseSection
  td(:actions, index: 0)
  td(:billing_account, index: 1)
  td(:payment_plan, index: 2)
  td(:last_payment, index: 3)
  td(:balance, index: 4)
  td(:current_date, index: 5)
end

class PaymentOptionsPanel < BasePanel
  data_grid(:billing_acct, PaymentOptionsPanelRow) # was "billing_acct_grid" prior to Angular AMN 1-22-2020 #, id: 'BillingGridContent', item: { xpath: './/tbody/tr' })
end
