# frozen_string_literal: true

class BillingAccountManagementPage < BasePage
  page_url "https://saturn.central-insurance.com/OnlineBilling"

  span(:account_number, class: 'lkNorm')
  span(:bill_plan, id: /BillPlan/)
  span(:client_name, id: /lblName/)
  span(:client_address, id: /lblAddress/)
  link(:auto_card_pay, xpath: './/td[contains(@id,"PayPlan")]/a')
  td(:first_col, xpath: '//tr[@class="tblContent"]//td[@class="firstCol"]')
  td(:card_ending_in, xpath: '//tr[@class="tblContent"]//td[@class="midCol"]')
  td(:type, xpath: '//tr[@class="tblContent"]//td[3]')
  td(:expiration_date, xpath: '//div[@id="divCreditCardList"]//tr[@class="tblContent"]//td[4]')
  td(:routing, xpath: '//tr[@class="tblContent"]//td[4]')
  td(:cardholder_name, xpath: '//tr[@class="tblContent"]//td[5]')
end
