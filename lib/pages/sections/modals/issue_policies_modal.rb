# frozen_string_literal: true

class IssuePoliciesModal < BaseModal
  button(:next, xpath: '//p-button[contains(@id, "Next")]/button', hooks: WFA_HOOKS)
  button(:submit, xpath: '//p-button[contains(@id, "Submit")]/button', hooks: WFA_HOOKS)
  checkbox(:check_all_products, id: 'allProductsSelected')
  div(:total_premium_amount, xpath: '//div[contains(text(), "Total Account Premium")]/following::div')
end
