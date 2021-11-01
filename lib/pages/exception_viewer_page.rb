# frozen_string_literal: true

class ExceptionRow < ::EDSL::ElementContainer
  link(:exception_link, default_method: :href)
  td(:message, index: 6)
  td(:timestamp, index: 1, default_method: ->(name, container) { Chronic.parse(container.send("#{name}_element").text) })

  def to_s
    "#{timestamp.strftime('%m/%d/%Y %H:%M:%S')} - #{message}\n Exception link: #{exception_link}\n\n"
  end
end

class ExceptionViewerPage < BasePage
  TIME_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:send_keys).with(:tab)
  end

  page_url "#{Nenv.base_url}/ExceptionViewer/"

  button(:search, text: 'Search', hooks: WFA_HOOKS)
  text_field(:start_time_field, id: 'FilterModel_RangeTimeStart', hooks: TIME_HOOKS)
  text_field(:end_time_field, id: 'FilterModel_RangeTimeEnd', hooks: TIME_HOOKS)
  div(:time_picker, class: 'ui-timepicker-div')
  sections(:exceptions, ExceptionRow, xpath: '//div[@id = "filterResults"]//tbody', how: :tbody, item: { how: :trs })

  def exceptions_near(timestamp)
    timestamp = Chronic.parse(timestamp) if timestamp.is_a?(String)
    exceptions_by_range(timestamp - 10, timestamp)
  end

  def exceptions_by_range(start_time, end_time)
    start_time = Chronic.parse(start_time) if start_time.is_a?(String)
    end_time = Chronic.parse(end_time) if end_time.is_a?(String)

    search_by_hour_range(start_time - 60, end_time + 60)
    exceptions.select { |e| e.timestamp >= start_time && e.timestamp <= end_time }
  end

  def search_by_hour_range(start_time, end_time)
    self.time_filter = 'HourRange'
    self.start_time_field = start_time.strftime('%H:%M')
    self.end_time_field = end_time.strftime('%H:%M')
    Watir::Wait.until { !time_picker? }
    search
  end

  def time_filter=(value)
    radio_set(id: 'radTime').select value
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
