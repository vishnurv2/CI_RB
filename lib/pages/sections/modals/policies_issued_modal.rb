# frozen_string_literal: true

class PoliciesIssuedModal < BaseModal
  button(:to_account_summary, xpath: '//p-button[contains(@id, "Go To Account Summary")]/button', hooks: WFA_HOOKS)
  button(:resolve_issues, xpath: '//p-button[contains(@id, "ResolveIssues")]/button', hooks: WFA_HOOKS)
end
