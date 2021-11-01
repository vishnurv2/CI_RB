# frozen_string_literal: true

class BaseSection < EDSL::PageObject::Section
  include DataMagic
  def leave_page_using(method, raise_errors = true, expected_url = nil)
    cur_url = browser.url
    _call_or_send(method)
    Watir::Wait.until(timeout: 45) { (expected_url ? browser.url == expected_url : browser.url != cur_url) || errors? }
    wait_for_ajax
    raise_page_errors "leaving #{self.class} using #{method}" if raise_errors
  end

  def _call_or_send(method)
    method.call if method.is_a?(Proc)
    send(method) unless method.is_a?(Proc)
  end

  def errors?
    false
  end

  def populate_with(data)
    data = data.fetch(populate_key, data)
    data = data.fetch(populate_key.to_sym, data)
    data.each do |k, v|
      send("#{k}=", v) if respond_to?("#{k}=")
    rescue Exception => ex
      raise_page_errors
      raise "#{ex.message} raised while setting #{k}"
    end
  end

  def raise_page_errors(_msg = nil)
    parent_container.raise_page_errors
  end
end
