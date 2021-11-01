# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  class DateOfBirthField < ::EDSL::ElementContainer

    def initialize(element, container)
      if element.present?
        if element.parent.text_field.present?
          element = element.parent.text_field
        else
          element = element.text_field
        end
      end
      super(element, container)
    end

    def set(new_value)
      super('')
      sleep(0.050)
      new_value = Chronic.parse(new_value) if new_value.is_a?(String)
      send_keys(new_value.strftime('%m%d%Y'))
    end

    def value
      Chronic.parse(super)
    end

    def text
      root_element.value
    end
  end

  EDSL.extend_dsl do
    def date_of_birth_field(name, opts = {})
      opts = { xpath: './/input', assign_method: :set, default_method: :value }.merge(opts)
      element(name, { how: :element, wrapper_fn: ->(element, container) { DateOfBirthField.new(element, container) } }.merge(opts))
    end
  end
end

