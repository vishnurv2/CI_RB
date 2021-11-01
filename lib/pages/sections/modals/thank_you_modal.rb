# frozen_string_literal: true

class ThankYouModal < BaseModal
  button(:close, xpath: './/p-button[@id="Close"]/button', hooks: WFA_HOOKS)
  link(:go_to_documents, text: 'Go to Documents')
  link(:add_a_party, text: 'Add a party')
  link(:view_and_resolve_issues, text: 'View and Resolve Issues')
end
