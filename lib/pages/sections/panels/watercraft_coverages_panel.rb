# frozen_string_literal: true

class WatercraftCoveragesPanel < BasePanel
  button(:modify, class: /action-icon/, default_method: :click, hooks: WFA_HOOKS)
end
