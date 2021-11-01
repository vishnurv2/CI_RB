# frozen_string_literal: true

require 'forwardable'

# Module containing custom elements for Central insurance
module CentralElements
  # A checkbox that's not a checkbox, inside of a CoverageListItem
  class CoverageItemCheckbox < ::EDSL::ElementContainer
    def set(new_val)
      return if checked? == new_val

      click
    end

    def check
      set(true)
    end

    def uncheck
      set(false)
    end

    def checked?
      class_name.include? 'coverage-item-checked'
    end

    def selected?
      class_name.include? 'radio-button-selected'
    end
  end

  EDSL.define_accessor(:coverage_checkbox, how: :span,
                                           wrapper_fn: ->(element, container) { CoverageItemCheckbox.new(element, container) },
                                           default_method: :checked?, assign_method: :set)

  # A Single item in a coverage list
  class CoverageListItem < ::EDSL::ElementContainer
    coverage_checkbox(:active_ind, class: 'coverage-item-checkbox')
    button(:label, class: 'coverage-item-link', default_method: :text)

    def select
      label_element.click
    end

    def checked?
      active_ind_element.checked?
    end

    def check
      select
      sleep 0.25
      active_ind_element.check
    end

    def uncheck
      active_ind_element.uncheck
    end

    def set(new_val)
      active_ind_element.set(new_val)
    end

    def selected?
      active_ind_element.selected?
    end

    def to_a
      [label.snakecase, checked?]
    end
  end

  # A class to represent a coverage list
  class CoverageList < ::EDSL::ElementContainer
    sections(:coverages, CoverageListItem, xpath: '.', item: { class: 'list-group-item', visible: true })

    def find_coverage(name)
      return find_coverage_by_symbol(name) if name.is_a?(Symbol)
      return find_coverage_by_regex(name) if name.is_a?(Regexp)

      coverages.find { |c| c.label.start_with?(name) }
    end

    def find_coverage_by_regex(name)
      coverages.find { |c| name.match(c.label) }
    end

    def find_coverage_by_symbol(name)
      coverages.find { |c| c.label.snakecase.to_sym == name }
    end

    def select_coverage(name)
      coverage = find_coverage(name)
      coverage&.select

      parent_container.wait_for_ajax
      coverage
    end

    def to_a
      coverages.map { |c| [c.label.snakecase, c.checked?] }.sort
    end

    def to_h
      to_a.to_h
    end

    def add_coverage(name)
      find_coverage(name)&.check
    end

    def remove_coverage(name)
      find_coverage(name)&.uncheck
    end

    def pry
      # rubocop:disable Lint/Debugger
      binding.pry
      puts 'line for pry'
      # rubocop:enable Lint/Debugger
    end
  end

  EDSL.define_accessor(:coverage_list, how: :div, wrapper_fn: ->(element, container) { CoverageList.new(element, container) })
end
