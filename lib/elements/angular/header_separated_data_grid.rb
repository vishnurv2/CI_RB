# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  class DataGridColumnHeader < ::EDSL::ElementContainer
    def sorted_by?
      class_name.include? 'sorting_'
    end

    def sort_order
      return :asc if class_name.include? 'sorting_asc'

      :desc
    end

    def sort_by(direction = :asc)
      return if sort_order == direction

      click
      parent_container.wait_for_ajax
      direction
    end
  end

  # A class to represent a data table wit pagination.
  class HeaderSeparatedDataGrid < ::EDSL::ElementContainer

    def initialize(item_class, element, container, item_how)
      super(element, container)
      @item_class = item_class
      @item_how = item_how
    end

    def expand
      if has_items && !expanded?
        tr(class: 'ui-widget-header').link.click
        Watir::Wait.until(timeout: 10) { expanded? }
      end
    end

    def collapse
      if expanded?
        tr(class: 'ui-widget-header').link.click
        Watir::Wait.while(timeout: 10) { expanded? }
      end
    end

    def expanded?
      tr(@item_how).present?
    end

    def items
      expand
      trs(@item_how).map { |r| @item_class.new(r, self) }
    end

    def headers
      return trs(xpath: './/tbody/tr', class: 'ui-widget-header')
    end

    def has_items(header_text = nil)
      if header_text.nil?
        has = !(spans(class: /ount/).find { |s| s.text != '0' }).nil?
      else
        s = span(xpath: ".//tbody/tr/td/a/span[contains(text(), \"#{header_text}\")]/../../span")
        has = s.present? && (s.text != '0')
      end
      return has
    end

    def item_count(header_text = nil)
      if header_text.nil?
        sum = 0
        spans(class: /ount/).each { |s| sum += s.text.to_i }
        return sum
      else
        s = span(xpath: ".//tbody/tr/td/a/span[contains(text(), \"#{header_text}\")]/../../span")
        return s.text.to_i if s.present?
        return 0
      end
    end

    def item_count_from_header(header_text)
      a = header_text.match /\w+(\d+)/
      return a[1]
    end

    def headers_with_count
      arr = headers
      results = []
      arr.each do |x|
        results << {header: x.text.gsub!(/\d+/, ''), count: item_count_from_header(x.text)} unless x.text.empty?
      end
      results
    end

    def wait_for_ajax
      parent_container.wait_for_ajax
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def header_separated_data_grid(name, item_class, opts = {})
      opts = {xpath: './/p-table', item: {xpath: './/tbody/tr[not(contains(@class, "ui-widget-header"))]'}}.merge(opts)
      item_how = opts.delete(:item) { |_el| {xpath: './/tbody/tr[not(contains(@class, "ui-widget-header"))]'} }
      element(name, {how: :element, wrapper_fn: ->(element, container) { HeaderSeparatedDataGrid.new(item_class, element, container, item_how) }}.merge(opts))
    end
  end
end
