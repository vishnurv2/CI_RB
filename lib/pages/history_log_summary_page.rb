# frozen_string_literal: true

class HistoryLogEntry < BaseSection

  # ------ Everything below this line is unverified ------------------------------------- #

  def get_column_value(column_name)
    return td(data_label: column_name).text
  end
end

class HistoryLogSummaryPage < PolicyManagementPage

  # ------ Everything below this line is unverified ------------------------------------- #

  select_list(:history_view_dropdown, id: 'HistoryViewDropdown')
  data_grid(:entries, HistoryLogEntry) # was "entries_grid" prior to Angular AMN 1-22-2020 # , id: /DataTables_Table_[0-9][0-9]*_wrapper/)

  def displayed?
    browser.url.include?('PolicyManagement/HistoryLog/Summary?accountNumber=')
  end
end
