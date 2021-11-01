# frozen_string_literal: true

class Toaster
  include Singleton

  def self.method_missing(message, *args, &block)
    Toaster.instance.send(message, *args, &block)
  end

  # Errors
  # array to store toaster error messages
  def errors
    @error_toasts ||= []
  end

  # detects error toasts and returns error
  # @return string
  def toasters
    toast_container = div(xpath: '//div[@id="toast-container"]')
    errors = toast_container.divs(class: 'toast-error').to_a.map(&:text)
    errors
  end

end
