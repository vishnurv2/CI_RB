# frozen_string_literal: true

module CentralElements
  # Element class for a single toggle button.
  class ToggleButton < SimpleDelegator
    # Is the control disabled?
    # @return [True, False]
    def disabled?
      parent.classes.include?('disabled') || parent.attribute_list.include?(:disabled)
    end

    # Is the control enabled?
    # @return [True, False]
    def enabled?
      !disabled?
    end

    # Is the control active?
    # @return [True, False]
    def active?
      parent.classes.include?('active')
    end

    # Set the toggle to true
    # @return nil
    def set(value)
      parent.click if value != active?
    end

    # Is the control active?
    # @return [True, False]
    def value
      active?
    end

    # Get the text of the toggle
    # @return [String]
    def text
      parent.text.strip
    end
  end

  # Add a ToggleButtonList to your page object
  # @param name [Symbol] What to call the added element
  # @param opts [Hash] Standard EDSL options
  def toggle_button(name, opts) end

  EDSL.define_accessor(:toggle_button, how: :checkbox, assign_method: :set, default_method: :value,
                                       wrapper_fn: ->(element, _container) { ToggleButton.new(element) })

  # Element class for a collection of toggle buttons.
  class ToggleButtonList < SimpleDelegator
    # Get all the toggles contained in the list
    # @return [Array] an array of ToggleButtons
    def toggles
      radios.map { |r| ToggleButton.new(r) }
    end

    # Given a string, set the toggle that matches it
    # @param value [String]
    def set(value)
      toggles_for(value).first&.set(true)
    end

    def toggle_for(value)
      toggles.find { |t| t.text.strip == value.strip }
    end

    def toggles_for(value)
      values = value.split('|')
      toggles.select { |t| values.include?(t.text.strip) && t.enabled? }
    end

    # Return the currently selected toggle
    # @return [ToggleButton]
    def selected_toggle
      toggles.find(&:active?)
    end

    # Return the text of the currently selected toggle
    # @return [String, Nil]
    def value
      selected_toggle&.text
    end
  end

  # Add a ToggleButtonList to your page object
  # @param name [Symbol] What to call the added element
  # @param opts [Hash] Standard EDSL options
  def toggle_button_list(name, opts) end

  EDSL.define_accessor(:toggle_button_list, how: :div, assign_method: :set, default_method: :value,
                                            wrapper_fn: ->(element, _container) { ToggleButtonList.new(element) })

  class ToggleButtonCheckList < ToggleButtonList
    # Get all the toggles contained in the list
    # @return [Array] an array of ToggleButtons
    def toggles
      @toggles ||= checkboxes.map { |r| ToggleButton.new(r) }
    end

    # Return the currently selected toggle
    # @return [ToggleButton]
    def selected_toggles
      toggles.select(&:active?)
    end

    # This is defined in the base class but not relevant for this subclass
    def selected_toggle
      raise NotImplementedError
    end

    # Return the text of the currently selected toggle
    # @return [String, Nil]
    def value
      selected_toggles.map(&:text)
    end

    # Given a hash, find each toggle listed and set it's value.
    # Given an array, set each toggle value by index.
    # @param value [String]
    def set(value)
      return _set_via_hash(value) if value.is_a?(Hash)
      return _set_via_array(value) if value.is_a?(Array)

      raise 'ToggleButtonCheckLists must be set using a hash or an array'
    end

    private

    # Loop through a hash where the keys are toggle labels and the value is obvious
    def _set_via_hash(value)
      value.each do |k, v|
        toggles_for(k).first&.set(v)
      end
    end

    # Set each toggle to the value of the value array matching its index.
    def _set_via_array(value)
      all_toggles = toggles
      value.each_with_index do |val, index|
        all_toggles[index].set(val)
      end
    end
  end

  # Add a ToggleButtonCheckList to your page object.
  # These are similar to ToggleButtonLists except they use checkboxes.
  # @param name [Symbol] What to call the added element
  # @param opts [Hash] Standard EDSL options
  def toggle_button_checklist(name, opts) end

  EDSL.define_accessor(:toggle_button_checklist, how: :div, assign_method: :set, default_method: :value,
                                                 wrapper_fn: ->(element, _container) { ToggleButtonCheckList.new(element) })
end
