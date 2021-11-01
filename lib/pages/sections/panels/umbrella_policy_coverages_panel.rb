# frozen_string_literal: true

class UmbrellaAutoPolicyCoveragesPanel < BasePanel
  button(:modify, class: /action-icon/, default_method: :click, hooks: WFA_HOOKS)
end
