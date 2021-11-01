# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  class Radio < ::EDSL::ElementContainer
    label(:button_label)

    def select
      div().click
    end

    def selected?
      label().classes.include?('ui-label-active')
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def radio(name, opts = {})
      opts = { xpath: './/p-radiobutton' }.merge(opts)
      element(name, { how: :element, wrapper_fn: ->(element, container) { Radio.new(element, container) } }.merge(opts))
    end
  end
end
