# frozen_string_literal: true

class AccountProducersPanel < BasePanel
  data_grid(:producers, ProducersRow) # was "producers_grid" prior to Angular AMN 1-22-2020 # , id: 'producerGridContent', item: { xpath: './/tbody/tr' })
  td(:empty_table, class: 'dataTables_empty')
end
