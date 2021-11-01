# frozen_string_literal: true

module Helpers
  # Central Insurance Fake IT module
  # DDL - 2020
  # Simple module to provide random data for tests.
  # This was implemented to bypass Faker gem as it's slow
  #
  module FakeIt
    def self.last_name
      last_names = %w[
        Skywalker Organna Kenobi Solo Banner Parker Fury Stark Barton Romanov Fett
        Rogers Kent Wayne Kyle Allen West Damien Prince Lois Jordan Grey Summers Henry
      ]
      last_names.shuffle.sample
    end

    def self.random_last_name
      range = [*'a'..'z']
      "#{Helpers::FakeIt.last_name}#{Array.new(5) { range.sample }.join}"
    end

    def self.middle_name

    end

    def self.first_name
      first_names = %w[
        Peter Lea Ben Luke Tony Bruce Nick Drew Boba Steve Clint Loki Clark
        Bruce Barry Wally Iris Diana Lane Hal Jean Scott Jubilee John
      ]
      first_names.shuffle.sample
    end

    def self.area_code
      "#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
    end

    def self.exchange_code
      "#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
    end

    def self.subscriber_number
      "#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
    end

    def self.email_address
      range = [*'a'..'z']
      carrier = ['qa.central-insurance.com', 'central-insurance.com']
      mail = Array.new(5) { range.sample }.join
      random_mail_address = "#{mail}@#{carrier.sample}"
      random_mail_address
    end

    def self.suffix
      suffix = ['Jr.', 'Sr.', 'I', 'II', 'MD', 'DDS', 'PhD']
      suffix.shuffle.sample
    end

    def self.prefix
      prefix = ['Mr.', 'Mrs.', 'Ms.', 'Miss', 'Dr']
      prefix.shuffle.sample
    end

    def self.street_address
      random_street_suffix = %w[
        Alley Avenue Branch Bridge Brook Brooks Burg Burgs Bypass Camp Canyon
        Cape Causeway Center Centers Circle Circles Cliff Cliffs Club Common Corner
        Corners Course Court Courts Cove Coves Creek Crescent Crest Crossing Crossroad
        Curve Dale Dam Divide Drive Drive Drives Estate Estates
      ]
      street_number = Array.new(5) { rand(1..9) }.join
      full_address = "#{street_number} #{Helpers::FakeIt.first_name} #{random_street_suffix.sample}"
      full_address
    end

    def self.user_name
      "#{Helpers::FakeIt.first_name}_#{Helpers::FakeIt.last_name}"
    end

  end

end
