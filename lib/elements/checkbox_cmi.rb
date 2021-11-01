# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  # A class to represent the redesigned checkboxes
  class CheckboxCMI < ::EDSL::ElementContainer
    label(:clickable)

    def checked?
      js = "return window.getComputedStyle(arguments[0], ':after')['content'].length > 2" # the content in the :after style changes between 2 and 3 characters long for unchecked and checked
      return clickable_element.execute_script(js, clickable_element)
    end

    def check
      clickable_element.click if !checked?
    end

    def check!
      clickable_element.click! if !checked?
    end

    def uncheck
      clickable_element.click if checked?
    end

    def uncheck!
      clickable_element.click! if checked?
    end

    def toggle
      clickable_element.click
    end

    def toggle!
      clickable_element.click!
    end

    def set(whether_checked)
      whether_checked ? check : uncheck
    end

    def set!(whether_checked)
      whether_checked ? check! : uncheck!
    end
  end

  EDSL.define_accessor(:checkbox_cmi, how: :div, wrapper_fn: ->(element, container) { CheckboxCMI.new(element, container) }, assign_method: :set)
end
