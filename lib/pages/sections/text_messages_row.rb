# frozen_string_literal: true

class TextMessageRow < EDSL::PageObject::Section
  link(:edit_message, class: 'TextMessagesTableEditLink', default_method: :click, hooks: WFA_HOOKS)
  span(:delete_message, title: 'Delete Product', default_method: :click, hooks: WFA_HOOKS)

  td(:phone_number, data_label: /Phone Number/)
  td(:notifications, data_label: /Notifications/)

end
