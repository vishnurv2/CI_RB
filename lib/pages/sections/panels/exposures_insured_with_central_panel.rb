# frozen_string_literal: true
#
class EIWCProductRow < ::BaseSection
  td(:category, data_label: 'Category')
end

class ExposuresInsuredWithCentralPanel < BasePanel
  data_grid(:products, EIWCProductRow)
  span(:add_new, class: /fal fa-plus/, default_method: :click, hooks: WFA_HOOKS)
end

