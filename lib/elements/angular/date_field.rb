# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  class DateField < ::EDSL::ElementContainer

    def initialize(element, container)
      element = element.text_field() if element.present?
      super(element, container)
    end

    def show_calendar
      parent.button(class: 'ui-datepicker-trigger').click
    end

    def set(new_value)
      new_value = Chronic.parse(new_value) if new_value.is_a?(String)
      set!(new_value.strftime('%m/%d/%Y'))

      #ng11
      calendar = element(xpath: '//div[contains(@class,"p-datepicker-group-container")]') if element(xpath: '//div[contains(@class,"p-datepicker-group-container")]').present?
      # #old
      # calendar = div(xpath: '.././/div', class: 'ui-datepicker-group') if div(xpath: '.././/div', class: 'ui-datepicker-group').present?

      if calendar.present?
        selected_day = calendar.td(class: 'ui-datepicker-current-day') if calendar.td(class: 'ui-datepicker-current-day').present? # Old
        selected_day = calendar.span(class: 'p-highlight') if calendar.span(class: 'p-highlight').present? # NG-11
        selected_day.click
        Watir::Wait.while(timeout:30){ calendar.present? }
      end
    end

    def value
      Chronic.parse(super)
    end

    def text
      root_element.value
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def date_field(name, opts = {})
      opts = { xpath: './/p-calendar', assign_method: :set, default_method: :value }.merge(opts) # this allows the user to specify controls for the p-dropdown element or the p-dropdown/div element AMN 1-27-2020
      element(name, { how: :element, wrapper_fn: ->(element, container) { DateField.new(element, container) } }.merge(opts))
    end
  end
end

