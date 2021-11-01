# frozen_string_literal: true

module Watir
  class Select
    def select_index(index)
      select(options[index].text)
    end

    def select_by(str_or_rx)
      found = find_options(:value, str_or_rx) unless str_or_rx.is_a?(Integer)
      found = [options[str_or_rx]] if str_or_rx.is_a?(Integer)

      if found.size > 1
        Watir.logger.deprecate 'Selecting Multiple Options with #select', '#select_all',
                               ids: [:select_by]
      end
      select_matching(found)
    end
  end

  module UserEditable
    def set!(*args)
      msg = '#set! does not support special keys, use #set instead'
      raise ArgumentError, msg if args.any? { |v| v.is_a?(::Symbol) }

      input_value = args.join
      set input_value[0]
      return content_editable_set!(*args) if @content_editable

      element_call { execute_js(:setValue, @element, input_value[0..-2]) }
      append(input_value[-1])
      return if value == input_value
    end
  end
end
