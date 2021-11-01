# frozen_string_literal: true

class ReferralModal < BaseModal
  select_list(:status, id: 'Status')
  textarea(:notes, id: 'Notes')
  button(:save_and_close_button, name: 'SaveAndClose', visible: true, hooks: WFA_HOOKS)
end
