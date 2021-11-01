# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  # A class to represent a tab strip control
  class TabStrip < ::EDSL::ElementContainer
    ul(:nav_tabs)

    def tabs
      @tabs ||= nav_tabs.list_items
    end

    def tab_names
      tabs.map(&:text)
    end

    def active_tab
      tabs.find { |t| t.class_name.include?('active') }
    end

    def active_tab_name
      active_tab&.text
    end

    def find_tab(name)
      tabs.find { |t| t.text == name }
    end

    def active_tab=(name)
      find_tab(name)&.click
    end

    def pry
      # rubocop:disable Lint/Debugger
      binding.pry
      puts 'line for pry'
      # rubocop:enable Lint/Debugger
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def tab_strip(name, opts = {})
      opts = { xpath: './/p-tabview | .//p-tabmenu | .//c-tabview', assign_method: :active_tab= }.merge(opts)
      element(name, { how: :element, wrapper_fn: ->(element, container) { TabStrip.new(element, container) } }.merge(opts))
    end
  end
end
