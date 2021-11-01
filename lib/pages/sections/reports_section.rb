# frozen_string_literal: true

class ReportRow < BaseSection


  # ------ Everything below this line is unverified ------------------------------------- #
  #------- Paste your verified items above this line so we know whats been fixed!!
  #
  #
  #
  td(:type, data_label: /Report/)
  checkbox(:order, xpath: './/span[contains(@class,"p-checkbox-icon")]/../../..')
  #checkbox(:order, data_label: /Order/)
  td(:date, data_label: /Date Received/)
  td(:status, data_label: /Status/)
  text_field(:search, placeholder: 'Search...')
  label(:number_of_orders_selected, xpath: './/button[@label="Order Reports"]/preceding-sibling::label')
  span(:eye_icon, xpath: './/span[contains(@class,"fa fa-eye")]')

  i(:chevron_right, class: /pi-chevron-right/)
  i(:chevron_down, class: /pi-chevron-down/)

  button(:order_reports, xpath: './/td[contains(@class,"table-cell")]//button[@label="Order Reports"]')
  button(:order_btn_disabled, class: /disabled-order-btn/)

  button(:edit_report, xpath: './/p-button[@icon="fa fa-pencil"]/button')
  #span(:edit, class: 'fa-pencil-alt', default_method: :click)
  # td(:product, data_label: /Product/)

end

class ReportsSection < BaseSection

  tab_strip(:tabs, xpath: '//div[contains(@class,"p-tabview") or contains(@class,"ui-tabview")]/parent::p-tabview')
  #tab_strip(:tabs, xpath: '//div[contains(@class,"ui-tabview")]/parent::p-tabview')

  button(:order_reports, xpath: './/span[contains(text(),"Order") and contains(text(),"Report")]/..')
  data_grid(:reports_grid, ReportRow) # was "report_grid" prior to Angular AMN 1-22-2020 # , id: /DataTables_Table_[0-9][0-9]*_wrapper/)
  section(:reports, ReportRow, xpath: '//div[@class="ui-table ui-widget"]')
  sections(:order_reports_rows, ReportRow, xpath: '.', item: {xpath: './/tr[.//button[@label="Order Reports"]]', how: :trs})
  sections(:products_row, ReportRow, xpath:'.', item: {xpath: './/tr[.//i[contains(@class,"pi-chevron")]]', how: :trs})
  button(:order_btn_disabled, class: /disabled-order-btn/)

  def find_report_by_type(type)
    reports_grid.find_all { |x| x.type.include? type if x.type?}
  end

  def expand_each_policy_reports
    products_row.each do |row|
      row.chevron_right_element.click if row.chevron_right?
    end
  end

  # ------ Everything below this line is unverified ------------------------------------- #
  #------- Paste your verified items above this line so we know whats been fixed!!
  #
  #
  


  def clear_order_statuses
    reports_grid.each { |i| i.order = false if i.order? }
  end

  def order_reports_by_type(reports_to_order, clear_first = true)
    clear_order_statuses if clear_first
    reports_to_order = [reports_to_order] if reports_to_order.is_a?(String)
    reports_to_order.each do |report_type|
      reports_by_type = find_report_by_type(report_type)
      reports_by_type.each do |item|
        item.order = true
      end
    end
    order_reports
  end

  def order_all_reports
    reports_ordered = false
    reports_grid.each do |item|
      if item.order?
        item.order.check
        reports_ordered = true
      end
    end
    order_reports
    return reports_ordered
  end
end
