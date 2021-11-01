# frozen_string_literal: true

class WatercraftOperatorsPanel < BasePanel
  button(:add_watercraft_operator, xpath: './/p-button[@icon="fal fa-plus"]/button', default_method: :click, hooks: WFA_HOOKS)
end
