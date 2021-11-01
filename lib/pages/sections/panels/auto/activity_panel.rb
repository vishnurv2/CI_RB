
class ActivityPanel < BasePanel

  button(:edit_note_arrow, xpath: './/p-button[@id="activityAction"]/button')
  link(:edit_note, xpath: '//span[text()="Edit"]/..')

  span(:header_text, class: /bold-text searchable/)
  button(:ellipsis_icon, xpath: './/p-button[@icon="far fa-ellipsis-h"]/button')
end
