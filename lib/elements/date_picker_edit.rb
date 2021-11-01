# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  # @!method date_field(name, opts)
  # Add a date DatePickerEdit to your page object
  # @param name [Symbol] What to call the added element
  # @param opts [Hash] Standard EDSL options
  def date_field(name, opts) end

  # Control class for an edit box with a date picker button
  class DatePickerEdit < SimpleDelegator
    # Click the button to show the calendar
    # @return nil
    def show_calendar
      parent.image(class: 'ui-datepicker-trigger').click
    end

    # Set the value of the edit box
    # @param value [Date, Time, String] - If handed a string it will be parsed with Chronic
    def set(value)
      value = Chronic.parse(value) if value.is_a?(String)
      set!(value.strftime('%m/%d/%Y'))
      send_keys(:tab)
      Watir::Wait.while(timeout: 30) { div(xpath: '.././/div', class: 'ui-datepicker-group').present? }
    end

    def value
      Chronic.parse(super)
    end

    def text
      root_element.value
    end
  end
end

EDSL.define_accessor(:date_field, how: :text_field, assign_method: :set, default_method: :value, wrapper_fn: ->(element, _container) { CentralElements::DatePickerEdit.new(element) })
