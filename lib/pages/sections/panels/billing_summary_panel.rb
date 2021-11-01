# frozen_string_literal: true

class AccountsRow < EDSL::PageObject::Section
  td(:billing_account, data_label: /Billing Account/)
  td(:payment_plan, data_label: /Payment Plan/)
  td(:last_payment, data_label: /Last Payment/)
  td(:balance, data_label: /Balance/)
  td(:current_due, data_label: /Current Due/)
  td(:actions, data_label: /Actions/)

  button(:action_icon, xpath: './/p-button[contains(@icon,"fa fa-ellipsis")]/button')
  link(:view_billing_statement, xpath: '//a[contains(@class,"p-menuitem-link") and .//span[text() = "View Billing Statement"]]')

end

class BillingSummaryPanel < BasePanel
  data_grid(:accounts, AccountsRow)
end
