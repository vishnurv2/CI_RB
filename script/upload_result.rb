#!/usr/bin/env ruby
# frozen_string_literal: true

require 'net/http/post/multipart'
require 'trollop'
require 'pry'

puts 'Central test result uploader'

opts = Trollop.options do
  opt :suite, 'Name of the suite to upload', type: :string, default: ENV['SUITE_NAME']
  opt :instance, 'The name for this instance of the suite', type: :string
  opt :env, 'Name of the env the suite was run in', type: :string, default: 'N/A'
  opt :file, 'Name of the file containing results', type: :string
  opt :sprint, 'The name of the sprint i.e. 62', type: :string
end
Trollop.die :file, 'must be specified' unless opts[:file]
Trollop.die :env, 'must be specified' unless opts[:env]
Trollop.die :suite, 'must be specified' unless opts[:suite]

if opts[:file]
  Trollop.die :file, 'must exist' unless File.exist?(opts[:file])
end

p opts # a hash: { :monkey=>false, :name=>nil, :num_limbs=>4, :help=>false }

HOST = ENV.fetch('REPORTING_HOST', 'vsqvwdocker01:8080').freeze
url = URI.parse("http://#{HOST}/raw_results")

instance_name = opts[:sprint].to_s.empty? ? opts[:instance] : "Sprint ##{opts[:sprint]}"
req = Net::HTTP::Post::Multipart.new url.path,
                                     'raw_result[filedata]' => UploadIO.new(File.new(opts[:file]), 'application/octet-stream', File.basename(opts[:file])),
                                     'raw_result[runname]' => opts[:suite],
                                     'raw_result[instance_name]' => instance_name,
                                     'raw_result[test_environment]' => opts[:env]

puts 'Uploading results'
begin
  Net::HTTP.start(url.host, url.port) do |http|
    http.request(req)
  end
rescue Exception => ex
  puts "Upload failed #{ex.message}"
end

puts 'All Done'
