# frozen_string_literal: true

# monkey patch DataMagic
module DataMagic
  def data_for(key, additional = {})
    record = load_file_for_key(key)
    data = DataMagic.yml["#{record}_#{Nenv.test_env.downcase}"] || DataMagic.yml[record]
    return {} unless data

    prep_data(data.merge(additional.key?(record) ? additional[record] : additional).deep_copy)
  end

  def self.prep_data(data)
    case data
    when Hash
      data.each { |key, value| data[key] = prep_data(value) }
    when Array
      data.each_with_index { |value, i| data[i] = prep_data(value) }
    when String
      return translate(data[1..-1]) if data[0, 1] == '~'
    end
    data
  end

  def self.translate(value)
    translation.send :process, value
  rescue StandardError => error
    raise "Failed to translate: #{value}\n Reason: #{error.message}\n"
  end

  def self.translation
    @translation ||= Translation.new nil
  end

  def self.data_for(key, additional = {})
    record = load_file_for_key(key)
    data = DataMagic.yml["#{record}_#{Nenv.test_env.downcase}"] || DataMagic.yml[record]
    return {} unless data

    prep_data(data.merge(additional.key?(record) ? additional[record] : additional).deep_copy)
  end

  def self.load_file_for_key(key)
    if key.is_a?(String) && key.match(%r{/})
      filename, record = key.split('/')
      DataMagic.load("#{filename}.yml")
    else
      record = key.to_s
      DataMagic.load(the_file) unless DataMagic.yml
    end
    record
  end

  def load_file_for_key(key)
    if key.is_a?(String) && key.match(%r{/})
      filename, record = key.split('/')
      DataMagic.load("#{filename}.yml")
    else
      record = key.to_s
      DataMagic.load(the_file) unless DataMagic.yml
    end
    record
  end

  # monkey patch StandardTranslation
  module StandardTranslation
    # Customized ~email macro to provide shorter email addresses
    def email_address
      Helpers::FakeIt.email_address
    end

    def street_address
      Helpers::FakeIt.street_address
    end

    # customized ~phone_number macro to fit our mask
    def phone_number
      "(#{Helpers::FakeIt.area_code}) #{Helpers::FakeIt.exchange_code}-#{Helpers::FakeIt.subscriber_number}"
    end

    # customized ~phone_number_with_ext macro to fit our mask
    def phone_number_with_ext
      "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number} Ext:1234"
    end

    # customized ~last_name to append random characters to make it unique
    def last_name
      range = [*'a'..'z']
      "#{Helpers::FakeIt.last_name}#{Array.new(5) { range.sample }.join}"
    end

    def first_name
      Helpers::FakeIt.first_name
    end

    def name_suffix
      Helpers::FakeIt.suffix
    end

    def name_prefix
      Helpers::FakeIt.prefix
    end

    def user_name
      Helpers::FakeIt.user_name
    end

    # This is OLD method
    #def last_name
     # "#{Faker::Name.last_name}#{Time.now.strftime('%m%d%y%H%M%S%L')}"
    #end

    # customized ~last_name to append a timestamp to make it unique
    def last_name_no_timestamp
      range = [*'a'..'z']
      "#{Faker::Name.last_name}#{Array.new(10) { range.sample }.join}"
    end

    # ~full_adult_birth_date macro for over 21
    def full_adult_birth_date
      Chronic.parse("#{rand(21..63)} years ago").strftime('%m/%d/%Y')
    end

    # ~adult_birth_date macro for over 12-20 year olds
    def adult_birth_date
      Chronic.parse("#{rand(18..19)} years ago").strftime('%m/%d/%Y')
    end

    # ~teen_driver_birth_date macro for over 16 - 17
    def teen_driver_birth_date
      Chronic.parse('16 years ago').strftime('%m/%d/%Y')
    end

    # ~elderly_driver_birth_date macro for over 65
    def elderly_driver_birth_date
      Chronic.parse("#{rand(65..94)} years ago").strftime('%m/%d/%Y')
    end

    # ~elderly_driver_birth_date macro for over 94 and over
    def non_target_elderly_driver_birth_date
      Chronic.parse("#{rand(94..100)} years ago").strftime('%m/%d/%Y')
    end

    # ~good_student_birth_date macro for over 16 - 25
    def good_student_birth_date
      Chronic.parse("#{rand(16..24)} years ago").strftime('%m/%d/%Y')
    end

    # ~good_student_birth_date macro for over 16 - 20
    def teen_smart_birth_date
      Chronic.parse("#{rand(16..20)} years ago").strftime('%m/%d/%Y')
    end

    # ~good_student_birth_date macro for over 16 - 20
    def new_driver_date
      Chronic.parse('16 years ago').strftime('%m/%d/%Y')
    end

    def date_years_ago(years_ago)
      Chronic.parse("#{years_ago} years ago").strftime('%m/%d/%Y')
    end

    def date_days_ago(days_ago)
      Chronic.parse("#{days_ago} days ago").strftime('%m/%d/%Y')
    end

    def this_year
      Chronic.parse('today').year.to_s
    end

    def year_now
      Chronic.parse("Today")
    end

    def year_from_today
      Chronic.parse("A year from now")
    end

    def job_title
      Faker::Job.title
    end

    def time_name(prefix)
      "#{prefix}#{Time.now.strftime '%Y%m%d%H%M%S%L'}"
    end

    def random_number_of_length(digits)
      Array.new(digits) { rand(10) }.join
    end
  end
end

# monkey patch YmlReader
module YmlReader
  # Customized yml include that uses MagicPath for resolving file names
  def include_yml(filename)
    file_to_load = actual_fixture_path(filename)
    ERB.new(IO.read("#{yml_directory}/#{file_to_load}")).result(binding)
  end

  # Helper function for #include_yml
  def actual_fixture_path(base_name)
    data = { filename: File.basename(base_name, '.yml'), ext: '.yml' }
    FIXTURE_FILE_PATTERNS.each do |type|
      path = MagicPath.send(type).resolve(data)
      return path if File.exist? "#{MagicPath.fixture_path}/#{path}"
    end
    raise "Could not find fixture to match #{base_name}"
  end
end
