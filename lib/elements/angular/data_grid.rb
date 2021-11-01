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
  class DataGrid < ::EDSL::ElementContainer
    DG_SEARCH_HOOKS ||= CptHook.define_hooks do
      after(:set).call(:send_keys).with(:enter)
                 .call(:wait_for_ajax).using(:parent_container)

      after(:clear).call(:send_keys).with(:enter)
                   .call(:wait_for_ajax).using(:parent_container)
    end

    select(:show_entries, name: /DataTables_.*_length/)
    text_field(:search_text, type: 'search', hooks: DG_SEARCH_HOOKS)
    link(:current_page_no, class: %w[paginate_button current], default_method: :text)
    link(:previous_page, class: %w[paginate_button previous], hooks: WFA_HOOKS)
    link(:next_page, class: %w[paginate_button next], hooks: WFA_HOOKS)
    link(:first_page, data_dt_idx: '1', hooks: WFA_HOOKS)
    link(:first_page_no, data_dt_idx: '1', default_method: :text)
    div(:table_info, class: 'dataTables_info')

    def results_displayed
      return { first_on_page: 0, last_on_page: 0, total: 0 } unless table_info?

      start, finish, max = table_info.gsub(/[a-z]|[A-Z]/, '').split(' ')
      { first_on_page: start.to_i, last_on_page: finish.to_i, total: max.to_i }
    end

    def column_header_elements
      ths
    end

    def search(text)
      self.search_text = text
    end

    def column_headers
      @column_headers ||= column_header_elements.map { |h| DataGridColumnHeader.new(h) }
    end

    def column_names
      column_headers.map(&:text)
    end

    def sort_by(what, direction = :asc)
      column(what).sort_by(direction)
    end

    def column(which)
      return column_headers[which] if which.is_a?(Integer)
      return column_headers.find { |h| which.match(h.text) } if which.is_a?(Regexp)

      column_headers.find { |h| h.text == which.to_s }
    end

    def current_sort_column
      column_headers.find(&:sorted_by?)
    end

    def wait_for_ajax
      parent_container.wait_for_ajax
    end

    def item_elements # this function has been verified for angular
      trs(@item_how)
    end

    def items # this function has been verified for angular
      item_elements.map { |r| @item_class.new(r, self) }
    end

    def find_by(what, value)
      items.find { |app| app.send(what).strip.downcase == value.strip.downcase }
    end

    # all paging will have to be verified, not sure if there will be paging once we move to Angular

    def initialize(item_class, element, container, item_how)
      super(element, container)
      @item_class = item_class
      @item_how = item_how
    end

    def pry
      # rubocop:disable Lint/Debugger
      binding.pry
      puts 'line for pry'
      # rubocop:enable Lint/Debugger
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def data_grid(name, item_class, opts = {})
      opts = { xpath: './/p-table', item: { xpath: './/tbody/tr[not(contains(@class, "ui-widget-header"))]' }, default_method: :items }.merge(opts)
      item_how = opts.delete(:item) { |_el| { xpath: './/tbody/tr[.//td[contains(@class, "action-cell")]]' } }
      element(name, { how: :element, wrapper_fn: ->(element, container) { DataGrid.new(item_class, element, container, item_how) } }.merge(opts))
    end
  end
end
