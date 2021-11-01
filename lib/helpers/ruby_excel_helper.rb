# frozen_string_literal: true
#

require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'json'

class RubyExcelHelper

  def self.fetch_global_excel_data
    @excel = nil
    begin
      excel_file = get_excel_name_by_params
      path = "./excel_data/#{excel_file}.xlsx"
      @excel = RubyXL::Parser.parse path
      @excel
    rescue Exception => ex
      STDERR.puts ex.inspect
    end
  end

  def self.load_excel_data_for(tags)
    fixture_name = tags.find { |x| x.include?('@fixture') }.gsub('@fixture_', '')
    data_object = excel_parser_by(fixture_name)
    data_object
  end

  def self.initialize_redis_connection
    @redis = Redis.new(host: Nenv.redis_server, port: Nenv.redis_server_port)
    count = 3

    # max wait 9 seconds with retry every 3 seconds
    while @redis.nil? && count > 0
      @redis = Redis.new(host: Nenv.redis_server, port: Nenv.redis_server_port)
      count = count - 1
      sleep(3)
    end
    ### Redis connection failed here
    STDOUT.puts 'Redis connection failed' if @redis.nil?
    # force enabling DB to 0
    @redis.select(0)
    @redis
  end

  def self.redis_has_key?(tags)
    @redis = initialize_redis_connection

    fixture_name = tags.find { |x| x.include?('@fixture') }
    res = false
    unless fixture_name.nil?
      fixture_name = fixture_name.gsub('@fixture_', '')
      res = check_redis_has_key_for(fixture_name)
    end
    res
  end

  def self.get_from_redis_cache(tags)
    @redis = initialize_redis_connection

    fixture_name = tags.find { |x| x.include?('@fixture') }.gsub('@fixture_', '')
    data_object = get_from_redis_for(fixture_name)
    data_object
  end

  def self.flush_redis_cache
    @redis = initialize_redis_connection
    arr = @redis.keys
    res = @redis.flushdb unless arr.size == 0
    res
  end

  def self.save_to_redis_cache(fixture_name, value)
    @redis = initialize_redis_connection

    excel = get_excel_name_by_params
    key = "#{excel}___#{fixture_name}"
    res = @redis.set(key, value.to_json)
    # Every key will expire in 24 Hours
    @redis.expire(key, 86400)
    STDOUT.puts "Updated excel data for key: #{key}"
    res
  end

  def self.excel_has_key?(tags)
    fixture_name = tags.find { |x| x.include?('@fixture') }
    res = false
    #checking first column for fixture_name
    unless fixture_name.nil?
      fixture_name = fixture_name.gsub('@fixture_', '')
      arr = get_fixture_name_list_new
      res = arr.include?(fixture_name)
    end
    res
  end

  def self.excel_has_fixture_file?(fixture_name)
    res = false
    #checking first column for fixture_name
    unless fixture_name.nil?
      arr = get_fixture_name_list_new
      res = arr.include?(fixture_name)
    end
    res
  end

  def self.get_excel_name_by_params
    line = Nenv.excel_data_line.downcase.tr(' ', '_')
    prod = Nenv.excel_data_product.downcase
    state = Nenv.excel_data_state.upcase
    name = "#{line}_#{prod}_#{state}"
    name
  end

  def self.get_full_fixture_path
    line = Nenv.excel_data_line.downcase.tr(' ', '_')
    prod = Nenv.excel_data_product.downcase
    state = Nenv.excel_data_state.upcase
    fixture_path = "./fixtures_excel_yml/#{line}/#{prod}/#{state}"
    fixture_path
  end

  def self.update_excel_yaml(data, fixture_name, fixture_path)
    file_path = "#{fixture_path}/#{fixture_name}.yml"
    File.delete(file_path) if File.exist?(file_path)
    File.open(file_path, 'w') { |file| file.write(data.to_yaml) }
  end

  def self.load_excel_for(tags)
    scenario_name = tags.find { |x| x.include?('@excel') }.gsub('@excel_', '')
    excel = tags.find { |x| x.include?('@xlsx') }.gsub('@xlsx_', '')
    excel_parser_by(scenario_name)
  end

  def self.load_excel_for_fixture(scenario_name)
    excel_parser_by(scenario_name)
  end

  def self.safe_load_fixture_file(fixture_file)
    fixture_file = fixture_file.snakecase

    # Check and Load fixture file data from excel

    begin
      if Nenv.use_excel_data.include?('true')
        use_redis_server = Nenv.use_redis_server.include? 'true'
        redis_key_present = check_redis_has_key_for(fixture_file)
        if use_redis_server && redis_key_present
          redis_excel_data = get_from_redis_for(fixture_file)
          DataMagic.yml = redis_excel_data
          STDOUT.puts "REDIS: Loaded excel data for Fixture file: #{fixture_file}"
        else
          fetch_global_excel_data if @excel.nil?
          key_present = excel_has_fixture_file?(fixture_file)
          if key_present
            DataMagic.yml = load_excel_for_fixture(fixture_file)
            STDOUT.puts "EXCEL : Found and Loaded #{fixture_file} file data from excel."
          elsif fixture_file == 'vehicles'
            DataMagic.yml = get_vehicles_yml_data
            STDOUT.puts 'EXCEL : Loaded custom vehicles.yml file data from excel.'
          end
        end
      else
        Helpers::Fixtures.load_fixture(fixture_file)
        STDOUT.puts "Loading #{fixture_file} file data in scenario started..."
      end
      STDOUT.puts "Loading #{fixture_file} file data in scenario completed..."
    rescue Exception => ex
      STDERR.puts ex.inspect
    end
    DataMagic.yml
  end

  def self.get_data_from_sheet(worksheet_name, scenario_name)
    # find worksheet by name
    worksheet = @excel[worksheet_name]
    coloum_count = worksheet.sheet_data[0].size
    row = worksheet.count
    data_hash = Hash.new

    j = 0
    while j < coloum_count do

      if worksheet[0][j].nil? == false && worksheet[0][j].value == scenario_name
        begin

          i = 1
          while i < row do
            # Parsing Logic Starts
            color = worksheet[i][0].fill_color.downcase

            case color
            when '9dc3e6'
              #blue color
              key = worksheet[i][0].value
              temp = Hash.new

            when 'ffffc000'
              # Orange for Array
              key2 = worksheet[i][0].value
              arr = []
              if worksheet[i][j].value.nil?
                temp.store(key2, arr)
              else
                sting_arr = worksheet[i][j].value.split(',')
                sting_arr.each do |x|
                  value = if x.include?('true')
                            true
                          elsif x.include?('false')
                            false
                          elsif x.class == String && (x.include?('~'))
                            method = x.split('~').last
                            DataMagic.send(method)
                          else
                            x
                          end
                  arr << value
                end
                temp.store(key2, arr)
              end

            when 'f4b183'
              # light orange for nested hash
              i, key2, temp2 = resolve_fill_color_orange(i, j, worksheet)
              temp[key2] = temp2

            when 'ffffff00'
              # yellow for nested hash with array
              arr, i, key2 = resolve_fill_color_yellow(arr, i, j, worksheet)
              temp[key2] = arr

            when 'e7e6e6'
              # grey color
              unless worksheet[i][j].nil? || worksheet[i][j].value.nil?
                resolve_tilde_values_and_store(i, j, temp, worksheet)
              end

              break if worksheet[i + 1].nil?

            else
              break if worksheet[i].nil?

            end
            # Parsing Logic ends
            data_hash[key] = temp
            i += 1
          end
        rescue Exception => ex
          STDERR.puts '**************Inside Get data from sheet method*************************'
          STDERR.puts ex.inspect
          STDERR.puts "Error found in **#{scenario_name}** column parsing **#{i}** row"
          STDERR.puts ex.backtrace
          return
        end
      end
      j += 1
    end
    data_hash
  end

  def self.get_vehicles_yml_data
    worksheet = @excel['Custom_Vehicles']
    row_count = worksheet.count
    arr = []
    (0..row_count - 1).each do |row_idx|
      arr << worksheet[row_idx][0].value
    end
    container_start = arr.index('exposures_insured_with_another_carrier_container_modal')
    carrier_start = arr.index('exposures_insured_with_another_carrier_modal')

    carrier = Hash.new
    container = Hash.new

    (carrier_start..row_count).each do |i|
      j = 1
      key = worksheet[i][0].value
      unless worksheet[i][j].nil? || worksheet[i][j].value.nil?
        resolve_tilde_values_and_store(i, j, carrier, worksheet)
      end

      break if worksheet[i + 1].nil?
    end

    coloum_count = worksheet.sheet_data[0].size
    keys_arr = []
    (0...coloum_count ).each do |col_idx|
      temp = worksheet[container_start + 1][col_idx].value
        keys_arr << temp unless temp.nil?
    end

    vehicle_arr = []
    (container_start + 2..carrier_start - 1).each do |row_idx|
      temp = Hash.new
      keys_arr.each_with_index do |key,index|
        temp[key] = worksheet[row_idx][index + 1].value
      end
      vehicle_arr << temp
    end


    data_hash = Hash.new

    data_hash["exposures_insured_with_another_carrier_modal"] = carrier
    data_hash["exposures_insured_with_another_carrier_container_modal"] = Hash.new
    data_hash["exposures_insured_with_another_carrier_container_modal"]["modals"] = vehicle_arr

    data_hash
  end

  def self.load_excel_for_test(scenario_data_tag)
    excel_parser_by(scenario_data_tag)
  end

  def self.check_for_duplicate_entries
    STDOUT.puts('##################################')
    arr = get_data_map_array_from_excel
    c = arr.map { |x| x if arr.count(x) > 1 }
    c.uniq.each { |e| STDOUT.puts "Found duplicate: #{e}" unless e.nil? }
    STDOUT.puts('##################################')
  end

  private

  def self.get_data_map_array_from_excel
    worksheet = @excel['Data_Map']
    row = worksheet.count
    search_pos_row = 1
    arr = []
    while search_pos_row < row
      arr << worksheet[search_pos_row][0].value
      search_pos_row += 1
    end
    arr
  end

  def self.get_from_redis_for(fixture_name)
    excel = get_excel_name_by_params
    key = "#{excel}___#{fixture_name}"
    data_object = JSON.parse(@redis.get(key))
  end

  def self.check_redis_has_key_for(fixture_name)
    excel = get_excel_name_by_params
    key = "#{excel}___#{fixture_name}"
    res = @redis.exists?(key)
  end

  def self.resolve_fill_color_orange(i, j, worksheet)
    key2 = worksheet[i][0].value
    temp2 = Hash.new
    i += 1
    # White background non nil values for nested hash
    while worksheet[i][0].get_cell_xf.fill_id == 0
      if worksheet[i][j].value == "true"
        temp2.store(worksheet[i][0].value, true)
      elsif worksheet[i][j].value == "false"
        temp2.store(worksheet[i][0].value, false)
      else
        temp2.store(worksheet[i][0].value, worksheet[i][j].value)
      end
      if worksheet[i + 1].nil? == false && worksheet[i + 1][0].get_cell_xf.fill_id == 0
        i += 1
      else
        break
      end
    end
    return i, key2, temp2
  end

  def self.resolve_fill_color_yellow(arr, i, j, worksheet)
    key2 = worksheet[i][0].value
    i = i + 1
    idx = 0
    while worksheet[i + idx][0].get_cell_xf.fill_id == 0
      nested_key = worksheet[i + idx][0].value

      if nested_key.include? '['
        arr = []
        temp3 = Hash.new
      elsif nested_key.include? ','
        arr << temp3
        temp3 = Hash.new
      elsif nested_key.include? ']'
        arr << temp3
      else
        unless worksheet[i + idx][j].nil? || worksheet[i + idx][j].value.nil?
          resolve_tilde_values_and_store(i + idx, j, temp3, worksheet)
        end
      end
      idx += 1
    end
    return arr, i, key2
  end

  def self.get_fixture_name_list_new
    worksheet = @excel['Data_Map']
    row_count = worksheet.count
    arr = []
    (0..row_count - 1).each do |row_idx|
      arr << worksheet[row_idx][0].value
    end
    return arr
  end

  def self.resolve_tilde_values_and_store(i, j, temp, worksheet)
    entry = worksheet[i][j].value
    entry = if entry == "true"
              true
            elsif entry == "false"
              false
            elsif entry.class == Integer
              entry.to_s
              # to save the Numerical Value in the Data Hash
            elsif entry.class == String && entry.include?('##')
             entry.split('##').last.to_i
            else
              entry
            end
    temp.store(worksheet[i][0].value, entry)

    if entry.class == String && entry.include?('~')
      method = entry.split('~').last
      temp.store(worksheet[i][0].value, DataMagic.send(method))
    end
  end

  def self.excel_parser_by(scenario_name)
    excel = get_excel_name_by_params
    begin
      #TODO: The data mapping sheet is hard coded for now.
      worksheet = @excel['Data_Map']
      coloum_count = worksheet.sheet_data[0].size
      row = worksheet.count
      search_pos_row = 1
      search_pos_col = 1
      data_mapping = Hash.new
      while search_pos_row < row
        if worksheet[search_pos_row][0].value == scenario_name
          while search_pos_col < coloum_count
            col_header = worksheet[0][search_pos_col].value
            unless col_header.nil?
              col_entry = worksheet[search_pos_row][search_pos_col].value
              data_mapping[col_header] = col_entry unless col_entry.nil?
            end
            search_pos_col += 1
          end
        end
        search_pos_row += 1
      end
      data_value = Hash.new
      last_key = last_value = nil
      data_mapping.each do |key, value|
        last_key = key
        last_value = value
        temp = get_data_from_sheet(key, value)
        data_value.merge!(temp)
      end
      data_value
    rescue Exception => ex
      STDERR.puts '**************RUN TERMINATED*************************'
      STDERR.puts ex.inspect
      STDERR.puts "Error found in **#{last_key}** sheet parsing **#{last_value}** column"
      STDERR.puts "Failure in parsing EXCEL file: #{excel}.xlsx"
      STDERR.puts '**************RUN TERMINATED*************************'
      return
    end

  end

  def self.generate_redis_cache

    arr = get_data_map_array_from_excel
    arr.each_with_index do |row_value, index|
      STDOUT.puts "Processing Excel Row....#{index}"
      data_object = excel_parser_by(row_value)
      save_to_redis_cache(row_value, data_object)
    end
  end

end


