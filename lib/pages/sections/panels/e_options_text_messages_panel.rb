# frozen_string_literal: true

class TextMessagesPanel < BaseSection
  data_grid(:messages, TextMessageRow) # was "messages_grid" prior to Angular AMN 1-22-2020 # , xpath: '//*[contains(@class,"cmiDataTable")]', item: { xpath: './/tbody/tr' })
  td(:empty_table, class: 'dataTables_empty')

  link(:add_phone, class: 'btn btn-default', default_method: :click, hooks: WFA_HOOKS)

end