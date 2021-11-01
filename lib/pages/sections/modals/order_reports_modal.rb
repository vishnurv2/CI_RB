# frozen_string_literal: true

class OrderReportsModal < BaseModal
  button(:order_reports, xpath: './/span[contains(text(),"Order") and contains(text(),"Report")]/..')
  button(:close, xpath: './/p-button[@id="Close"]/button')
end