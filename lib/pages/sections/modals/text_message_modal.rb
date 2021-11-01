# frozen_string_literal: true

class TextMessageModal < BaseModal
  select_list(:existing_add_new_phone_dropdown, id: 'PhoneNumbers')
  text_field(:add_new_phone_number, id: 'PhoneNumber')
  checkbox_cmi(:select_all_notifications, id: 'NotificationsCheckbox')
  button(:save_and_close, name: 'SaveTextMessageOptions', hooks: WFA_HOOKS)

end
