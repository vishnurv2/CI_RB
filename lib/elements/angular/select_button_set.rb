# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  class SelectButton < ::EDSL::ElementContainer
    def select
      scroll.to
      click
    end

    def selected?
      classes.include?('p-highlight')
    end
  end

  class SelectButtonSet < ::EDSL::ElementContainer
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
      return elements(@item_how).map { |e| SelectButton.new(e, root_element) }
    end

    def select(option)
      option = option_elements.find { |e| e.text == option } if option.is_a?(String)
      option.scroll.to
      option.click
    end

    def initialize(element, container, item_how)
      element = element.parent if element.present? && element.tag_name != 'p-selectbutton'
      super(element, container)
      @item_how = item_how

      option_elements.each do |o|
        (class << self; self; end).class_eval do
          define_method o.text.gsub('/', ' ').snakecase.to_sym do
            return o
          end
        end
      end
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def select_button_set(name, opts = {})
      # now allows specifying parameters of the buttons themselves or of the div containing the buttons
      opts = { xpath: './/p-selectbutton/* | .//p-selectbutton', item: { xpath: './/div[contains(@class, "p-button") and not(contains(@class, "p-buttonset"))]' }, assign_method: :select }.merge(opts)
      item_how = opts.delete(:item) { |_el| { xpath: './/div[contains(@class, "p-button") and not(contains(@class, "p-buttonset"))]' } }

      # if Nenv.test_env == "local"
      #   opts = { xpath: './/p-selectbutton/* | .//p-selectbutton', item: { xpath: './/div[contains(@class, "p-button") and not(contains(@class, "p-buttonset"))]' }, assign_method: :select }.merge(opts)
      #   item_how = opts.delete(:item) { |_el| { xpath: './/div[contains(@class, "p-button") and not(contains(@class, "p-buttonset"))]' } }
      # else
      #   #old
      #   opts = { xpath: './/p-selectbutton/* | .//p-selectbutton', item: { xpath: './/div[contains(@class, "ui-button") and not(contains(@class, "ui-buttonset"))]' }, assign_method: :select }.merge(opts)
      #   item_how = opts.delete(:item) { |_el| { xpath: './/div[contains(@class, "ui-button") and not(contains(@class, "ui-buttonset"))]' } }
      # end

      element(name, { how: :element, wrapper_fn: ->(element, container) { SelectButtonSet.new(element, container, item_how) } }.merge(opts))
    end
  end
end
