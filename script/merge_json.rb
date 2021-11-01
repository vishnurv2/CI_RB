#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'yaml'
require 'pry'
require 'cgi'

def html_safe_error(scenario)
  scenario['steps'].each do |step|
    next unless step['result']['status'] == 'failed'

    step['result']['error_message'] = CGI.escapeHTML(step['result']['error_message'])
  end
rescue Exception => ex
  STDOUT.puts ex.message
end

def remove_backgrounds(features)
  features.each do |feature|
    scenarios = feature['elements']
    scenarios.each_with_index do |scen, i|
      html_safe_error(scen)
      next unless scen['type'] == 'background'

      next_scen = scenarios[i + 1]
      next_scen['steps'] = scen['steps'].concat(next_scen['steps'])
    end
    scenarios.delete_if { |s| s['type'] == 'background' }
  end
  features
end

def remove_dups(features)
  features.each do |feature|
    feature['elements'].reverse!.uniq! { |s| "#{s['name']}:#{s['line']}" }
    feature['elements'].reverse!
  end
  features
end

def safe_load_json(file)
  begin
    return JSON.parse(File.read(file))
  rescue
    STDERR.puts "Failed to load #{file}"
  end
  []
end


files = Dir.glob(ARGV[0].gsub('\\*', '*'))

data = []
files.each { |f| data.concat(safe_load_json(f)) }
data = remove_dups(remove_backgrounds(data))

outfile = ARGV[1] || 'out.json'
File.open(outfile, 'wb') { |f| f.write(JSON.dump(data)) }
