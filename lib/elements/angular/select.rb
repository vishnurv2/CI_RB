# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements
  # A class to represent the redesigned checkboxes
  class Select < ::EDSL::ElementContainer

    def initialize(element, container)
      element = element.parent if  element.present? && element.tag_name.include?('div')
      super(element, container)
    end

    def options_xpath # when a dropdown is inside a small modal the developers put the dropdownitems at the end of the body element and give the dropdown a appendto='body' attribute to allow them to appear unconstrained by the modal bounds
      @options_xpath ||= (attributes[:appendto] == 'body') ? '//body/div[contains(@class, "p-dropdown-panel")]/.//p-dropdownitem' : './/p-dropdownitem'
      return @options_xpath
    end

    def options_xpath_ezlynx # when a dropdown is inside a small modal the developers put the dropdownitems at the end of the body element and give the dropdown a appendto='body' attribute to allow them to appear unconstrained by the modal bounds
      @options_xpath_ezlynx = '//body//div[contains(@class, "mat-select-panel")]/mat-option'
      return @options_xpath_ezlynx
    end

    def options_xpath_plrating # when a dropdown is inside a small modal the developers put the dropdownitems at the end of the body element and give the dropdown a appendto='body' attribute to allow them to appear unconstrained by the modal bounds
      @options_xpath_plrating = '//span/following-sibling::select/option'
      return @options_xpath_plrating
    end

    def expanded?
      div.classes.include?('ui-dropdown-open') || div.classes.include?('p-dropdown-open')
    end

    def expanded_ezlynx?
      div.classes.include?('mat-select-panel')
    end

    def options_visible?
      element(xpath: options_xpath).present?
    end

    def ezlynx_options_visible?
      element(xpath: options_xpath_ezlynx).present?
    end

    def expand_ezlynx
      toggle_expansion_ezlynx
    end

    def expand
      toggle_expansion unless expanded?

    end

    def collapse
      toggle_expansion if expanded?
    end

    def collapse_ezlynx
      toggle_expansion_ezlynx if expanded_ezlynx?
    end

    def wait_for_loading_overlay_to_disappear
      Watir::Wait.while { div(class: 'loading-indicator').present? }
    end

    def toggle_expansion
      attempt = 0
      max_attempts = 3
      expanded_at_start = expanded?
      while attempt < max_attempts && expanded? == expanded_at_start
        wait_for_loading_overlay_to_disappear
        begin
          div.scroll.to
          div.click
        rescue
          div.scroll.to :center
          div.click
        end

        begin
          Watir::Wait.while(timeout: 1) { expanded? == expanded_at_start }
        rescue
        end
        attempt += 1
      end
    end

    def toggle_expansion_ezlynx
      wait_for_loading_overlay_to_disappear
      div.click
    end

    def option_elements
      expand
      elements(xpath: options_xpath)
    end

    def option_elements_ezlynx
      #expand_ezlynx
      elements(xpath: options_xpath_ezlynx)
    end

    def option_elements_plrating
      #expand_ezlynx
      elements(xpath: options_xpath_plrating)
    end

    def options(collapse_when_done = false)
      option_texts = option_elements.map(&:text)
      collapse if collapse_when_done
      return option_texts
    end

    def options_ezlynx(collapse_when_done = false)
      option_texts = option_elements_ezlynx.map(&:text)
      collapse_ezlynx if collapse_when_done
      return option_texts
    end

    def options_plrating(collapse_when_done = false)
      option_texts = option_elements_plrating.map(&:text)
      return option_texts
    end

    def set(option_to_select)
      select(option_to_select)
    end

    def set_ezlynx(option_to_select)
      select_ezlynx(option_to_select)
    end

    def select(option_to_select, wait_for_options_to_close = true)
      expand
      option_to_select = option_to_select.split('|') if option_to_select.is_a?(String) && option_to_select.include?('|')
      if option_to_select.is_a?(String) || option_to_select.is_a?(Regexp)
        o = element(xpath: options_xpath, text: option_to_select)
        Watir::Wait.until(timeout: 10) { o.present? }
        if o.present?
          select(o)
        else
          raise "Invalid Selection Text, \"#{option_to_select},\" Available Options: #{option_elements.map(&:text)}"
        end
      elsif option_to_select.is_a?(Integer)
        oes = option_elements
        Watir::Wait.until(timeout: 10) { oes = option_elements; oes.length > 0}
        if option_to_select > -1 && option_to_select < oes.count
          select(oes[option_to_select])
        else
          raise "Invalid Selection Index, #{option_to_select}, Not Within [0..#{oes.count - 1}]"
        end
      elsif option_to_select.is_a?(Watir::Element)
        wait_for_loading_overlay_to_disappear
        option_to_select = option_to_select.li if option_to_select.li.present?
        begin
          option_to_select.click!
        rescue
          option_to_select.scroll.to
          option_to_select.click!
        end
        Watir::Wait.while { options_visible? } if wait_for_options_to_close
      elsif option_to_select.is_a?(Array)
        selected = false
        option_to_select.each do |op|
          o = element(xpath: options_xpath, text: op)
          if o.present?
            select(o)
            selected = true
            break
          end
        end
        raise "Selection Options not Found: #{option_to_select}. Available Options: #{option_elements.map(&:text)}" unless selected
      end
    end

    def select_ezlynx(option_to_select, wait_for_options_to_close = true)
      expand_ezlynx
      option_to_select = option_to_select.split('|') if option_to_select.is_a?(String) && option_to_select.include?('|')
      if option_to_select.is_a?(String) || option_to_select.is_a?(Regexp)
        o = element(xpath: options_xpath_ezlynx, text: option_to_select)
        Watir::Wait.until(timeout: 10) { o.present? }
        if o.present?
          o.scroll.to
          o.click
        else
          raise "Invalid Selection Text, \"#{option_to_select},\" Available Options: #{option_elements_ezlynx.map(&:text)}"
        end
      elsif option_to_select.is_a?(Integer)
        oes = option_elements_ezlynx
        Watir::Wait.until(timeout: 10) { oes = option_elements_ezlynx; oes.length > 0}
        if option_to_select > -1 && option_to_select < oes.count
          oes[option_to_select+1].scroll.to
          oes[option_to_select+1].click
        else
          raise "Invalid Selection Index, #{option_to_select}, Not Within [0..#{oes.count - 1}]"
        end
      elsif option_to_select.is_a?(Watir::Element)
        wait_for_loading_overlay_to_disappear
        option_to_select = option_to_select.span if option_to_select.span.present?
        begin
          option_to_select.click!
        rescue
          option_to_select.scroll.to
          option_to_select.click!
        end
        Watir::Wait.while { options_visible? } if wait_for_options_to_close
      elsif option_to_select.is_a?(Array)
        selected = false
        option_to_select.each do |op|
          o = element(xpath: options_xpath_ezlynx, text: op)
          if o.present?
            select_ezlynx(o)
            selected = true
            break
          end
        end
        raise "Selection Options not Found: #{option_to_select}. Available Options: #{option_elements_ezlynx.map(&:text)}" unless selected
      end
    end

    def select_plrating(option_to_select, wait_for_options_to_close = true)
      option_to_select = option_to_select.split('|') if option_to_select.is_a?(String)
      if option_to_select.is_a?(String) || option_to_select.is_a?(Regexp)
      o = element(xpath: options_xpath_plrating)
      end
      if option_to_select.is_a?(Array)
        selected = false
        option_to_select.each do |op|
          o = element(xpath: options_xpath_plrating, text: op)
          if o.present?
            o.click
            selected = true
            break
          end
        end
        raise "Selection Options not Found: #{option_to_select}. Available Options: #{option_elements_plrating.map(&:text)}" unless selected
      end
    end

    def select_index(index)
      index = Integer(index)
      select(index)
    end

    def select_index_ezlynx(index)
      index = Integer(index)
      select_ezlynx(index)
    end

    def selected_index
      o = option_elements.find_index { |o| o.li(class: 'ui-state-highlight').present? }
      return o unless o.nil?
      return -1
    end

    def selected_index_ezlynx
      o = option_elements_ezlynx.find_index { |o| o.span(class: 'mat-option-text').present? }
      return o unless o.nil?
      return -1
    end

    def include?(option_looking_for)
      return options.include?(option_looking_for)
    end

    def include_ezlynx?(option_looking_for)
      return options_ezlynx.include?(option_looking_for)
    end

    def text
      return div.label().text if div.label.present?
      return div.span().text if div.span.present?
    end

    def disabled?
      div(class: 'p-dropdown').classes.include? 'p-disabled'
      ##NG11##
      #if Nenv.test_env == "local"
        #div(class: 'p-dropdown').classes.include? 'p-disabled' #ng 11
      #else
        #div(class: 'ui-dropdown').classes.include? 'ui-state-disabled' #old
      #end
    end

    def enabled?
      !disabled?
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def select(name, opts = {})
      opts = { xpath: './/*[name(parent::*)="p-dropdown" or local-name()="p-dropdown"]', assign_method: :select }.merge(opts) # this allows the user to specify controls for the p-dropdown element or the p-dropdown/div element AMN 1-27-2020
      element(name, { how: :element, wrapper_fn: ->(element, container) { Select.new(element, container) } }.merge(opts))
    end

    def select_ezlynx(name, opts = {})
      opts = { xpath: './/*[contains(@class, "mat-form-field-type-mat-select") or local-name()="mat-select"]', assign_method: :select_ezlynx }.merge(opts) # this allows the user to specify controls for the p-dropdown element or the p-dropdown/div element AMN 1-27-2020
      element(name, { how: :element, wrapper_fn: ->(element, container) { Select.new(element, container) } }.merge(opts))
    end

    def select_plrating(name, opts = {})
      opts = { xpath: './/span/following-sibling::select', assign_method: :select_plrating }.merge(opts) # this allows the user to specify controls for the p-dropdown element or the p-dropdown/div element AMN 1-27-2020
      element(name, { how: :element, wrapper_fn: ->(element, container) { Select.new(element, container) } }.merge(opts))
    end

  end
end

