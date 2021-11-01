# frozen_string_literal: true

class ReadyToBeginIssuanceModal < BaseModal
  button(:got_it, xpath: '//p-button[contains(@id, "okay")]/button',  hooks: WFA_HOOKS)
end
