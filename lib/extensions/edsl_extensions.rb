# frozen_string_literal: true

# HACK!  Temporary fix for wait_for_ajax Donavan needs to fix EDSL
module EDSL
  module PageObject
    module AJAX
      def wait_for_ajax(timeout = Nenv.wait_for_ajax_time, message = nil)
        return if _wait_for_pending_ajax(timeout)

        raise "Full page exception encountered while waiting for AJAX\r\nAccount ID: #{BasePage.account_number}\r\nPolicy Activity ID: #{BasePage.policy_number}\r\n" if browser.url.include?('ErrorRecovery')

        raise_page_errors "Waiting for AJAX in #{self.class}"
        message ||= "Timed out waiting for ajax requests to complete - Timed out at #{timeout} seconds"
        raise message
      end

      # rubocop:disable Lint/HandleExceptions
      def _wait_for_pending_ajax(timeout)
        end_time = ::Time.now + timeout
        until ::Time.now > end_time
          begin
            t = detect_error_toasts
            # a FALSE return continues the loop until it times out.
            return true if browser.execute_script(::EDSL::PageObject::Javascript::AngularJS.pending_requests) == true
          rescue Selenium::WebDriver::Error::UnknownError, Selenium::WebDriver::Error::JavascriptError
          end
          sleep 0.5
        end
        false
      end
      # rubocop:enable Lint/HandleExceptions
    end
    module Visitable
      def on_page(page_class, params = { using_params: {} }, visit = false, &block)
        page_class = class_from_string(page_class) if page_class.is_a? String
        return super(page_class, params, visit, &block) unless page_class.ancestors.include? Page

        merged = page_class.params.merge(params[:using_params])
        page_class.instance_variable_set('@merged_params', merged) unless merged.empty?
        @@current_page = page_class.new(@browser, visit)
        yield @@current_page if block
        @@current_page.respond_to?(:when_ready) ? @@current_page.when_ready : @@current_page
      end
    end
  end

  class ElementContainer
    def clear_all_toasts
      toasts_to_clear = 5
      toasts_to_clear.times do
        toast_message = div(xpath: '//div[contains(@class, "toast-message") or contains(@class, "toast-error")]')
        toast_message.click! if toast_message.present?
        Watir::Wait.while(timeout: 1) { toast_message.present? }
      end
    end

    def detect_error_toasts
      begin
        begin
          toast_container = div(xpath: '//div[@id="toast-container"]')
        rescue Exception => ex
          STDOUT.puts "Unable to locate Toast Container - #{ex}"
        end

        return if !toast_container.present?

        errors = toast_container.divs(class: 'toast-error').to_a.map(&:text)
        unless errors.include?(Toaster.errors)
          errors.each do |err|
            Toaster.errors << err
          end
        end
      rescue
      end
    end
  end
end
