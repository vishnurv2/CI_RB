# frozen_string_literal: true

require 'forwardable'

# Module containing custom elements for Central insurance
module CentralElements
  # A class to represent a coverage list
  class CoverageListNG < ::EDSL::ElementContainer

    def wait_for_ajax
      parent_container.wait_for_ajax
    end

    def item_elements # this function has been verified for angular
      elements(xpath: './/div[contains(@class,"coveragePanel")]')
    end

    def find_coverage(coverage)
      item_elements.find { |ele| ele.label(class: /p-checkbox-label/).text.casecmp(coverage).zero? }
    end

    def select_coverage(coverage)
      res = find_coverage(coverage).element(xpath: './/p-checkbox')
      res.click unless coverage_selected?(coverage)
      res
    end

    def coverage_deductible(coverage)
      find_coverage(coverage).element(xpath: './/p-dropdown')
    end

    def remove_coverage(coverage)
      res = find_coverage(coverage).element(xpath: './/p-checkbox')
      res.click if coverage_selected?(coverage)
      res
    end

    def deselect_all_coverages
      item_elements.each do |cov|
        cov.element(xpath: './/p-checkbox').click if coverage_selected?(cov)
      end
    end

    def coverage_selected?(coverage)
      res = find_coverage(coverage)
      res.classes.include? 'selectedCoverage'
    end

    def items
      item_elements.map { |i| i.label(class: /p-checkbox-label/).text }
    end

    def initialize(element, container)
      super(element, container)
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def coverage_list_ng(name, opts = {})
      opts = {xpath: './/*[name(parent::*)="app-dynamic-coverage" or local-name()="app-dynamic-coverage"]'}.merge(opts)
      element(name, {how: :element, wrapper_fn: ->(element, container) { CoverageListNG.new(element, container) }}.merge(opts))
    end
  end
end
