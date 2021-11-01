# frozen_string_literal: true

class EIWACProductsRow < ::BaseSection
  td(:category, data_label: 'Category/Type')
  td(:policy, data_label: 'Policy #')
  td(:carrier, data_label: 'Carrier')
  td(:effective_date, data_label: 'Effective Date')
  td(:expiration_date, data_label: 'Expiration Date')
  td(:limits, data_label: 'Limits')
  button(:edit, xpath: './/p-button[@icon="fas fa-pencil"]/button')
  button(:delete, xpath: './/p-button[@icon="fal fa-trash"]/button')
end

class ExposuresInsuredWithAnotherCarrierPanel < BasePanel
  span(:add_new, class: /pi pi-plus/, default_method: :click, hooks: WFA_HOOKS)
  data_grid(:products, EIWACProductsRow)
end