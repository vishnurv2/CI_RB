# frozen_string_literal: true

class PremiumModal < BaseModal
  button(:go_to_auto_summary, xpath: '//p-button[contains(@id, "GO_TO_POLICY_SUMMARY")]/button', hooks: WFA_HOOKS)
  button(:close, xpath: '//p-button[contains(@id, "Close")]/button', hooks: WFA_HOOKS)
end
