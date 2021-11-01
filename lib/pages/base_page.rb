# frozen_string_literal: true

class BasePage < EDSL::PageObject::Page
  include DataMagic

  def initialize(web_browser, visit = false)
    super(web_browser, visit)

    current_url = browser.url
    @@account_number = current_url if current_url.downcase.include?('accountid=') || current_url.downcase.include?('accountnumber=')
    @@policy_number = current_url if current_url.downcase.include?('policyactivityid=')

    raise "Error page encountered: #{web_browser.url}\r\nAccount ID: #{BasePage.account_number}\r\nPolicy Activity ID: #{BasePage.policy_number}\r\n" if browser.url.include?('?ExceptionId') || browser.url.include?('ErrorRecovery')

    raise_page_errors "inital load of #{self.class}"
  end

  def populate
    super
  rescue Exception => ex
    raise_page_errors "Populating #{self.class}"
    raise ex
  end

  def leave_page_using(method, raise_errors = true, expected_url = nil)
    cur_url = browser.url
    _call_or_send(method)
    Watir::Wait.until { (expected_url ? browser.url == expected_url : browser.url != cur_url) || errors? }
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

  def self.form_data_template
    ERB.new(File.open("templates/#{post_key}_form_data.erb", &:read))
  end

  def self.post_key
    to_s.snakecase
  end

  def self.data_for_this_page
    DataMagic.data_for(to_s.snakecase)
  end

  def raise_page_errors(_msg = nil); end

  def self.account_number
    @@account_number
  end

  def self.policy_number
    @@policy_number
  end

  def self.account_number=(new_value)
    @@account_number = new_value
  end

  def self.policy_number=(new_value)
    @@policy_number = new_value
  end
end
