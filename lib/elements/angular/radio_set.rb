# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  class RadioSet < ::EDSL::ElementContainer
    def selected_option
      se = selected_element
      return '' if se.nil?
      return se.text
    end

    def selected_element
      return option_elements.find { |o| o.selected? }
    end

    def options
      option_elements.map(&:text)
    end

    def option_elements
      return elements(@item_how).map { |e| Radio.new(e, root_element) }
    end

    def select(option)
      option = option_elements.find { |e| e.text == option } if option.is_a?(String)
      option.select
    end

    def initialize(element, container, item_how)
      element = element.parent if element.present? && element.tag_name == 'p-radiobutton'
      super(element, container)
      @item_how = item_how

      option_elements.each do |o|
        (class << self; self; end).class_eval do
          define_method o.text.snakecase.to_sym do
            return o
          end
        end
      end
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def radio_set(name, opts = {})
      # now allows specifying parameters of the buttons themselves or of the div containing the buttons
      opts = { xpath: './/p-radiobutton/.. | .//p-radiobutton', item: { xpath: './/p-radiobutton' }, assign_method: :select }.merge(opts)
      item_how = opts.delete(:item) { |_el| { xpath: './/p-radiobutton' } }
      element(name, { how: :element, wrapper_fn: ->(element, container) { RadioSet.new(element, container, item_how) } }.merge(opts))
    end
  end
end
