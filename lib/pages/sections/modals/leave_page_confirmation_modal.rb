# frozen_string_literal: true

class LeavePageConfirmationModal < BaseModal
  button(:accept_button, class: /p-confirm-dialog-accept/)
  button(:reject_button, class: /p-confirm-dialog-reject/)
  span(:dialog_message, class: /p-confirm-dialog-message/)
  span(:dialog_title, class: /p-dialog-title/)
end