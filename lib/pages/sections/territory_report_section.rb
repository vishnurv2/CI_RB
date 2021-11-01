# frozen_string_literal: true

class TerritoryReportRow < BaseSection
  span(:edit, class: 'fa-pencil-alt', default_method: :click, hooks: WFA_HOOKS)
end

class TerritoryReportSection < BaseSection
  data_grid(:territory_report, TerritoryReportRow) # was "territory_report_grid" prior to Angular AMN 1-22-2020 # , id: /DataTables_Table_[0-9][0-9]*_wrapper/)
end
