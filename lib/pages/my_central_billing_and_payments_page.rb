# frozen_string_literal: true

class MyCentralBillingAndPaymentsPage < BasePage
  page_url "https://saturn.central-insurance.com/BillingWeb/MyCentral/Pages/BillingAndPayments.aspx"
  div(:back_button, id: /back_contentContainer/)
  h6(:card_name, class: 'card-title')
  link(:policy, id: /lnkPolicy/)
  link(:term, id: /lnkTerm/)
  td(:balance, class: 'text-right')
  td(:current_due, xpath: '//td[@class = "text-right"]/following-sibling::td')
  div(:current_amount_due, xpath: '//div[contains(@id,"CurrentAmountDue")]//div[contains(@style,"right")]')
end
