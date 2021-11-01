# frozen_string_literal: true

require 'rspec/expectations'

# Custom matchers for RSpec to make working with web elements easier.
# This is to match if element is/not visible! - DDL

module RSpec
  RSpec::Matchers.define :be_visible do |expected|
    match do |actual|
      actual.present? == expected
    end

    failure_message do |_actual|
      'expected element to be visible but it is not'
    end
  end

  RSpec::Matchers.define :not_be_visible do |expected|
    match do |actual|
      actual.present? != expected
    end

    failure_message do |_actual|
      'expected element to NOT be visible but it is.'
    end
  end
end
