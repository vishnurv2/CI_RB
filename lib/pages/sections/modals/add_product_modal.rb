# frozen_string_literal: true
class StateEffDateSection < EDSL::PageObject::Section
  select(:state, id: /state/)
end

class AddProductModal < BaseModal
  section(:personal_products, PersonalProductsSelection, xpath: './/form/div')
  select(:state, id: /tate/)
  date_field(:policy_effective_date, id: /effectiveDate/)
  date_field(:policy_expiration_date, id: /expirationDate/)
  #button(:save_and_begin_quote, xpath: './/p-button[@id = "SaveProduct"]/button')
  #button(:save_and_begin_quote, name: 'SaveAndContinue')
  span(:save_and_begin_quote, text: /Begin Quote/, default_method: :click!)
  div(:all_products_state, xpath: '//*[contains(@id,"state")]/div')
  checkbox(:attach_product, xpath: './/p-checkbox[@label="Attach to home product"]/div')

  i(:auto_select, xpath: './/div[@class="ng-star-inserted"][1]//div[@class="productCardContainer"]//i[contains(@class,"fa-car")]')
  i(:home_select, xpath: './/div[@class="ng-star-inserted"][2]//div[@class="productCardContainer"]//i[contains(@class,"fa-home-alt")]')
  i(:dwelling_select, xpath: './/div[@class="ng-star-inserted"][3]//div[@class="productCardContainer"]//i[contains(@class,"fa-store-alt")]')
  i(:umbrella_select, xpath: './/div[@class="ng-star-inserted"][4]//div[@class="productCardContainer"]//i[contains(@class,"fa-umbrella")]')
  i(:spp_select, xpath: './/div[@class="ng-star-inserted"][5]//div[@class="productCardContainer"]//i[contains(@class,"fa-gem")]')
  i(:watercraft_select, xpath: './/div[@class="ng-star-inserted"][6]//div[@class="productCardContainer"]//i[contains(@class,"fa-ship")]')

  # ------ Everything below this line is unverified ------------------------------------- #

  div(:discontinued_agency_alert, class: 'alert-title', text: 'Discontinued Agency Notification')
  span(:effective_date_validation, for: 'PolicyEffectiveDate')
  sections(:state_eff_date_section, StateEffDateSection, xpath: '.', item: { xpath: './/form//div[contains(@class,"p-card-shadow p-card")]' })




end