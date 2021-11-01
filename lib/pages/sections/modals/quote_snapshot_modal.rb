# frozen_string_literal: true

class QuoteSnapshotModal < BaseModal
  button(:close, class: /quote-snapshot-closeIconClass/, hooks: WFA_HOOKS)
  button(:go_to_umbrella_summary, xpath: './/p-button[@id="GO_TO_POLICY_SUMMARY"]/button')
  button(:do_next_quote, xpath: './/p-button[@id="DO_NEXT_QUOTE"]/button')
  button(:quote_management, xpath: './/p-button[@id="VIEW_QUOTE"]/button')
  div(:total_premium, xpath: './/div[contains(@class,"totalPremium-text")]/div[contains(@class,"ng-star-inserted")]')
  i(:premium_exclamation_error_icon, xpath: './/i[contains(@class,"fa-exclamation-circle errorIcon")]')
end