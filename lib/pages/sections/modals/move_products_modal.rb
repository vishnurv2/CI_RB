# frozen_string_literal: true

class ProductsRow < BaseSection
  checkbox(:product_checkbox, xpath: '//p-checkbox')
  td(:name, data_label: /Name/)
  td(:status, data_label: /Status/)
end

class NewProductsRow < BaseSection
  td(:name, data_label: /Name/)
  text_field(:account, xpath: './/input[@type= "text"]')
  select(:producer, id: /agencyProducers/)
end

class SelectProductsSection < BaseSection
  data_grid(:products, ProductsRow)
end

class AccountsSearchResults < BaseSection
  div(:product_icon, class: /left-margin fa-address-card fas pl product-icon/)
end

class NewAccountDetailsSection < BaseSection
  checkbox(:same_account_for_all_products, xpath: '//p-checkbox[@label="Same account and producer for all products"]')
  data_grid(:new_products, NewProductsRow)
  sections(:accounts_search_results, AccountsSearchResults, xpath: '.', item: { xpath: './/div[contains(@class,"quick-search-result")]' })
end

class MoveProductsModal < BaseModal
  section(:select_products_section, SelectProductsSection, xpath: '//div[contains(@styleclass,"table-content") and .//strong[contains(text(),"Select product(s) to move to a new account")]]')
  section(:new_account_details_section, NewAccountDetailsSection, xpath: '//div[contains(@styleclass,"table-content") and .//label[contains(text(),"Same account and producer for all products")]]')
  button(:next, xpath: '//p-button[@id="Next"]/button')
  button(:submit, xpath: '//p-button[@id="Submit"]/button')
end