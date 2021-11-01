
class Product < ::BaseSection
  span(:product_name, class: /bold-text/)
  p(:current_annual_premium, xpath: './/div[text()="Current Annual Premium"]/../p')
  p(:new_annual_premium, xpath: './/div[text()="New Annual Premium"]/../p')
  p(:difference, xpath: './/div[text()="Difference"]/../p')
  p(:effective_date, xpath: './/div[text()="Effective Date"]/../p')
  a(:pdf, id: /viewQuote/)
end

class ReviewAndSubmitPolicyChange < BaseModal
  data_grid(:policy_change_product, Product)
  th(:product_header, xpath: './/th[contains(.,"Product")]')
  th(:current_annual_header, xpath: './/th[contains(.,"Current Annual Premium")]')
  th(:new_annual_header, xpath: './/th[contains(.,"New Annual Premium")]')
  th(:difference_header, xpath: './/th[contains(.,"Difference")]')
  th(:effective_date_header, xpath: './/th[contains(.,"Effective Date")]')

  button(:submit, xpath: './/p-button[@id="Submit"]/button')
  checkbox(:product_checkbox, xpath: './/p-checkbox[contains(@id, "product_0")]/div/div[2]')
  button(:go_to_account_summary, xpath: './/p-button[@id="Go To Account Summary"]/button')

  i(:info_icon, xpath: './/i[contains(@id,"overlayPanel_0")]')
end