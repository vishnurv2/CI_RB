# frozen_string_literal: true

class PremiumChamgeModal < BaseModal
  span(:close, text: 'Close', default_method: :click!, hooks: WFA_HOOKS)
  button(:ok, xpath: './/p-button[@id="Close"]/button')
end