# frozen_string_literal: true

require 'mail'

TEAMS_CHANNELS = { dev: 'a7609854.cmivw.onmicrosoft.com@amer.teams.ms',
                   test: '747cd6a2.cmivw.onmicrosoft.com@amer.teams.ms',
                   default: '35be84d4.cmivw.onmicrosoft.com@amer.teams.ms' }.freeze

# Helper class for reporting application error details
class AppErrorHelper
  include Singleton
  include EDSL::PageObject::Visitation

  attr_writer :browser

  def self.new_scenario
    @@screenshot_filename = nil
  end

  def self.method_missing(message, *args, &block)
    AppErrorHelper.instance.send(message, *args, &block)
  end

  def self.record_error_details(browser)
    _record_error_url(browser) if browser.url.include?('?ExceptionId') || browser.url.include?('ErrorRecovery')
  end

  def self.record_url_details(browser)
    _record_error_url(browser)
  end

  def self._record_error_url(browser)
    msg = "\n********\nURL: #{browser.url}\n********\n"
    STDOUT.puts msg # This one goes to the console
    STDERR.puts msg
    raise msg # This one is embedded into the results
  end

  def self.screenshot_error(scenario = nil, current_page = nil)
    return @@screenshot_filename if @@screenshot_filename

    time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    @@screenshot_filename = "#{Nenv.screenshot_dir}/#{Nenv.test_env}-#{time}-#{scenario&.feature&.name&.snakecase}-#{scenario&.name&.snakecase}-#{current_page&.class}.png".delete('"')
    @@screenshot_filename = @@screenshot_filename.delete('#') ## remove the # character from filename
    $browser&.wd&.save_screenshot(@@screenshot_filename)
    @@screenshot_filename
  end

  def lookup_exception_details
    results = []
    begin
      visit(ExceptionViewerPage) do |page|
        results = page.exceptions_near(Time.now).map(&:to_s)
      end
      notify_deadlock_users(results || [])
    rescue Exception => ex
      STDERR.puts "#{ex.message} received attempting to get the exceptions from the exception viewer."
    end

    results
  end

  def notify_deadlock_users(results)
    return unless results.any? { |r| /deadlock/.match?(r) }

    msg_body = results.select { |r| /deadlock/.match?(r) }.join("\n")

    begin
      # TODO: If this list changes, move it to config.
      [TEAMS_CHANNELS.fetch(Nenv.test_env.to_sym, TEAMS_CHANNELS[:default]), 'tking@central-insurance.com', 'ddavis@central-insurance.com', 'pcrummey@central-insurance.com', 'ekosch@central-insurance.com'].each do |addr|
        _send_notification_email("Deadlocks detected on #{Nenv.base_url}", msg_body, addr)
      end
    rescue Exception => ex
      STDERR.puts "#{ex.message} received attempting to send deadlock reports."
    end
  end

  def _send_notification_email(subject, msg_body, addr)
    STDOUT.puts "***\nSending mail to #{addr}\n***"

    mail = Mail.new do
      from     'JENKINS@central-insurance.com'
      to       addr
      subject  subject
      body     msg_body
    end

    mail.deliver
  end
end
