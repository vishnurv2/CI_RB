# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  # A class to represent the redesigned checkboxes
  class CheckBox < ::EDSL::ElementContainer
    span(:state_span)
    div(:clickable, class: 'ui-chkbox')
    div(:clickable_checkbox, class: /p-checkbox/)

    def checked?
      return state_span_element.classes.include? 'pi-check'
    end

    def attempt_click
      clickable_element.present? ? clickable_element.click : clickable_checkbox_element.click
    end

    def attempt_click!
      clickable_element.present? ? clickable_element.click! : click!
    end

    def check
      attempt_click if !checked?
    end

    def check!
      attempt_click! if !checked?
    end

    def uncheck
      attempt_click if checked?
    end

    def uncheck!
      attempt_click! if checked?
    end

    def toggle
      attempt_click
    end

    def toggle!
      attempt_click!
    end

    def set(to_be_checked)
      to_be_checked ? check : uncheck
    end

    def set!(to_be_checked)
      to_be_checked ? check! : uncheck!
    end

    def value
      return checked?
    end

    def disabled?
      div(class: 'p-checkbox').classes.include?('p-checkbox-disabled') #ng11
      ##NG11##
      #if Nenv.test_env == "local"
        #div(class: 'p-checkbox').classes.include?('p-checkbox-disabled') #ng11
      #else
        #div(class: 'ui-chkbox-box').classes.include?('ui-state-disabled')
      #end
    end

    def enabled?
      div(class: 'p-checkbox-box').classes.include?('p-highlight') #ng11
      ##NG11##
      #if Nenv.test_env == "local"
        #div(class: 'p-checkbox-box').classes.include?('p-highlight') #ng11
      #else
        #!disabled?
      #end
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def checkbox(name, opts = {})
      opts = { xpath: './/p-checkbox', assign_method: :set }.merge(opts)
      element(name, { how: :element, wrapper_fn: ->(element, container) { CheckBox.new(element, container) } }.merge(opts))
    end
  end
end
