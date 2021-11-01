# frozen_string_literal: true

require 'clipboard'

module Watir
  module UserEditable
    #
    # Clear the element, then type in the given value.
    #
    # @param [String, Symbol] args
    #

    def set(*args)
      element_call(:wait_for_writable) do
        @element.clear
        if args.count == 1 && !args.first.to_s.ascii_only?
          Clipboard.copy args.first.to_s
          @element.send_keys([:control, 'v'])
        else
          @element.send_keys(*args)
        end
      end
    end
  end
end
