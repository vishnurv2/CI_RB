# frozen_string_literal: true

class Product < ::BaseSection
  span(:product_name, class: /bold-text/)
  p(:new_annual_premium, xpath: './/div[text()="New Annual Premium"]/./following-sibling::div/span')
  p(:effective_date, xpath: './/div[text()="Effective Date"]/./following-sibling::div/span')
  button(:make_a_payment, xpath: './/span[(@class="p-button-label") and (text()="Make a Payment")]')
end

class PolicyChangeIssuedModal < BaseModal
  span(:policy_issued_sub_header, class: 'policy-issued-sub-header')
  span(:policy_issued_title, class: 'modal-title-medium')

  data_grid(:policy_product, Product)
  th(:product_header, xpath: './/th[contains(.,"Product")]')
  th(:new_annual_header, xpath: './/th[contains(.,"New Annual Premium")]')
  th(:effective_date_header, xpath: './/th[contains(.,"Effective Date")]')

  button(:go_to_account_summary, xpath: './/p-button[@id="Go To Account Summary"]/button')
  button(:view_policy_documents, xpath: './/p-button[@id="View Policy Documents"]/button')
  i(:close_button, class: /pi pi-times cursor-pointer/)

  span(:product_name, class: /bold-text/)
  p(:new_annual_premium, xpath: './/div[text()="New Annual Premium"]/./following-sibling::div/span')
  p(:effective_date, xpath: './/div[text()="Effective Date"]/./following-sibling::div/span')
  button(:make_a_payment, xpath: './/span[(@class="p-button-label") and (text()="Make a Payment")]')
end
