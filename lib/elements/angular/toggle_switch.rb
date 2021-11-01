# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  # A class to represent the redesigned checkboxes
  class ToggleSwitch < ::EDSL::ElementContainer
    def set(on_or_off)
      tf = on_or_off
      tf = (on_or_off.downcase == 'true') if on_or_off.is_a?(String)
      if (tf == off?)
        scroll.to
        click
      end
    end

    def set_ez(on_or_off)
      tf = on_or_off
      tf = (on_or_off.downcase == 'true') if on_or_off.is_a?(String)
      if (tf != off_ez?)
        scroll.to
        click
      end
    end

    def value
      return div(role: 'checkbox').classes.include?('ui-inputswitch-checked')
    end

    def value_ez
      return input(type: 'checkbox').classes.include?('mat-slide-toggle-input')
    end

    def on?
      return value
    end

    def on_ez?
      return value_ez
    end

    def off?
      return !on?
    end

    def off_ez?
      return !on_ez?
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def toggle_switch(name, opts = {})
      opts = { xpath: './/p-inputswitch', assign_method: :set }.merge(opts)
      element(name, { how: :element, wrapper_fn: ->(element, container) { ToggleSwitch.new(element, container) } }.merge(opts))
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def toggle_switch_ezlynx(name, opts = {})
      opts = { xpath: './/mat-slide-toggle', assign_method: :set_ez }.merge(opts)
      element(name, { how: :element, wrapper_fn: ->(element, container) { ToggleSwitch.new(element, container) } }.merge(opts))
    end
  end
end
