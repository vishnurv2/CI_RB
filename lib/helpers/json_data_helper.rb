# frozen_string_literal: true
#

require 'json'

class JsonDataHelper

  def self.load_json_for(tags)
    scenario_json = tags.first.gsub('@json_', '')

    path = "./json/#{scenario_json}.json"
    begin
    file = File.read(path)
      JSON.parse(file)
    rescue Exception => ex
      STDERR.puts '**************RUN TERMINATED*************************'
      STDERR.puts "Failure in parsing JSON file: #{scenario_json}.json"
      STDERR.puts '**************RUN TERMINATED*************************'
      exit!
    end
  end

  def self.modify_json_new_bussiness(json)
    json['PolicyActivityId'] = 0
    # json['activityStatus'] = 'IncompleteIssue'
    json['activityStatus'] = 'IncompleteQuote'
    # json['policyNumber'] = 0
    json['policyNumber'] = 'null'
    json['quoteNumber'] = random_quote_no
    json['termType'] = 'NewBusiness'
    json['transactionType'] = 'PendingRenewal'
    json['producingAgencyCd'] = '4218'
    rand_str = get_random_string(6)
    policy_parties = json['policyParties']
    drivers = json['drivers']
    [policy_parties, drivers].each do |col|
      col.each do |row|
        unless row['driverLicense'].nil?
          row['driverLicense']['licenseNumber'] = get_license_number
        end

        next if row['partyNameInfo'].nil?
        party_info = row['partyNameInfo']

        unless party_info['givenName'].nil?
        old_first_name = party_info['givenName']
        party_info['givenName'] = "#{old_first_name}#{rand_str}"
        end

        unless party_info['surname'].nil?
          old_last_name = party_info['surname']
          party_info['surname'] = "#{old_last_name}#{rand_str}"
        end

        unless party_info['givenName'].nil?
          old_name = party_info['givenName']
          party_info['givenName'] = "#{old_name}#{rand_str}"
        end

        next if row['emails'].nil?
        temp = row['emails']
        temp.each_with_index do |e, index|
          e['emailAddress'] = "abcd#{index + 1}@xyz.com"
        end

        row['driverRelationshipToApplicant'] = 'Domestic Partner'

      end
    end

    #json['termType'] = 'Renewal'
    #json['transactionType'] = 'Renewal'
    # changing the QuoteOptionNumber to 0
    json['quoteOptionNumber'] = 0
    # json['quoteStatus'] = 'PendingQuote'  # this field is added by self not able to find in the JSON file

    additional_fields = json['additionalFields']
    idx_premium = additional_fields.index { |x| x['fieldType'] == 'PriorCarrierPremium' }
    unless idx_premium.nil?
      additional_fields[idx_premium]['value'] = modify_prior_carrier_premium(additional_fields[idx_premium]['value'])
    end

    idx_transfer_book = additional_fields.index { |x| x['fieldType'] == 'TransferBookInd' }
    unless idx_transfer_book.nil?
      additional_fields[idx_transfer_book]['value'] = false
    end
    return json
  end

  def self.modify_json_renewal(json)
    json['PolicyActivityId'] = 0
    json['activityStatus'] = 'Quoted'
    json['termType'] = 'Renewal'
    json['transactionType'] = 'Renewal'
    json['producingAgencyCd'] = '4218'
    # json['termEffectiveDt'] = Time.new.strftime("%Y-%m-%d")
    # json['termExpirationDt'] = '2022-05-10'
    # json['transactionEffectiveDtTm'] = Time.new.strftime("%Y-%m-%d")
    # json['transactionIssueDtTm'] = Time.new.strftime("%Y-%m-%d")
    # json['transactionRequestDtTm'] = Time.new.strftime("%Y-%m-%d")

    # drivers = json['drivers']
    # [drivers].each do |col|
    #   col.each do |row|
    #     # row['driverRelationshipToApplicant'] = 'Domestic Partner'
    #     unless row['driverLicense'].nil?
    #       row['driverLicense']['licenseNumber'] = get_license_number
    #     end
    #   end
    # end

    rand_str = get_random_string(6)
    policy_parties = json['policyParties']
    drivers = json['drivers']


    [policy_parties, drivers].each do |col|
      col.each do |row|
        unless row['driverLicense'].nil?
          row['driverLicense']['licenseNumber'] = get_license_number
        end

        next if row['partyNameInfo'].nil?
        party_info = row['partyNameInfo']

        unless party_info['givenName'].nil?
          old_first_name = party_info['givenName']
          party_info['givenName'] = "#{old_first_name}#{rand_str}"
        end

        unless party_info['surname'].nil?
          old_last_name = party_info['surname']
          party_info['surname'] = "#{old_last_name}#{rand_str}"
        end

        next if row['emails'].nil?
        temp = row['emails']
        temp.each_with_index do |e, index|
          e['emailAddress'] = "abcd#{index + 1}@xyz.com"
        end
        row['driverRelationshipToApplicant'] = 'Other Relative' unless row['driverRelationshipToApplicant'].nil?

      end
    end

    unless json['driverAssignments'].nil?
      driver_assignments = json['driverAssignments']
      driver_assignments.each do |col|

        unless col['driverFirstName'].nil?
          old_first_name = col['driverFirstName']
          col['driverFirstName'] = "#{old_first_name}#{rand_str}"
        end

        unless col['driverLastName'].nil?
          old_first_name = col['driverLastName']
          col['driverLastName'] = "#{old_first_name}#{rand_str}"
        end
      end
    end

    unless  json['Vehicles'].nil?
      vehicles = json['Vehicles']
      vehicles.each do |col|
        col['performanceCode'] = get_vehicle_performance_code
      end

    end


    return json
  end



  def self.random_quote_no
    DataMagic.time_name('Q-P')
  end

  def self.modify_prior_carrier_premium(old)
    new = '%.2f' % old.split('$').last.to_f
    return "$#{new}"
  end

  def self.load_json(json)
    # json['activityStatus'] = 'IncompleteQuote'
    return json
  end

  def self.get_random_string(length = 5)
    source = ("a".."z").to_a + ("A".."Z").to_a
    key = ""
    length.times { key += source[rand(source.size)].to_s }
    return key
  end

  def self.get_license_number
    # licenses = ['1160137783', '1160137784', '1030930267', '1054561615', '8941889319']
    licenses = ['1160137783', '1030930267']
    licenses.sample
  end

  def self.get_vehicle_performance_code
    codes = ['Intermediate', 'Standard']
    codes.sample
  end
  def self.compare_logic_xml(doc1, doc2)

    require 'compare-xml'
    require 'nokogiri/diff'
    res_hash = Hash.new
    res_hash[:left_diff] = res_hash[:right_diff] = ''

    res_hash['difference'] = CompareXML.equivalent?(doc1, doc2)

    full_path_left_diff = File.expand_path("./XML/side_by_side_comparision/#{DataMagic.time_name('left_diff_')}.txt")
    full_path_right_diff = File.expand_path("./XML/side_by_side_comparision/#{DataMagic.time_name('right_diff_')}.txt")
    File.delete(full_path_left_diff) if File.exist?(full_path_left_diff)
    File.delete(full_path_right_diff) if File.exist?(full_path_right_diff)

    ######## code for XML Compare Left to right ##############
    doc1.diff(doc2, :removed => true) do |change, node|
      if node.blank? == false
        #puts node.to_html.ljust(30)
        # @comparision_result.merge!(left_diff: node.to_html)
        res_hash[:left_diff] = node.to_html
        File.open(full_path_left_diff, 'a') { |f| f.write("\n#{node.to_html}") }
      end
    end
    ############ code for XML compare Right to Left ####################
    doc2.diff(doc1, :removed => true) do |change, node|
      if node.blank? == false
        puts node.to_html.ljust(30)
        res_hash[:right_diff] = node.to_html
        File.open(full_path_right_diff, 'a') { |f| f.write("\n#{node.to_html}") }
      end
    end

    #if else -> left diff vs right diff
    # if left diff is empty -> Right only
    # if right is empty -> left only
    # both present -> both files are different
    # @comparison_result['xml_compare_status'] to be set
    if File.size?(full_path_left_diff) == nil && File.size?(full_path_right_diff) == nil
      res_hash['compare_status'] = 'Both Files are Identical'
    elsif File.size?(full_path_left_diff) == nil
      res_hash['compare_status'] = 'Left Only'
    elsif File.size?(full_path_right_diff) == nil
      res_hash['compare_status'] = 'Right Only'
    elsif File.size?(full_path_left_diff) != nil && File.size?(full_path_right_diff) != nil
      res_hash['compare_status'] = 'Both Files Are Different'
    end
    [res_hash, full_path_left_diff, full_path_right_diff]
  end

  def self.compare_logic_pdf(doc1, doc2)

    require 'pdf-reader'
    require 'diffy'

    res_hash = Hash.new
    res_hash[:left_diff] = res_hash[:right_diff] = ''
    pdf1_text = pdf2_text = ''

    reader = PDF::Reader.new(doc1)
    reader.pages.each do |page|
      pdf1_text= pdf1_text + page.text
    end

    reader = PDF::Reader.new(doc2)
    reader.pages.each do |page|
      pdf2_text= pdf2_text + page.text
    end

    full_path_left_diff = File.expand_path("./XML/side_by_side_comparision/#{DataMagic.time_name('left_diff_')}.txt")
    full_path_right_diff = File.expand_path("./XML/side_by_side_comparision/#{DataMagic.time_name('right_diff_')}.txt")
    File.delete(full_path_left_diff) if File.exist?(full_path_left_diff)
    File.delete(full_path_right_diff) if File.exist?(full_path_right_diff)

    ######## code for XML Compare Left to right ##############
    res1 = Diffy::SplitDiff.new(pdf1_text, pdf2_text).left
    res_hash[:left_diff] = res1
    File.open(full_path_left_diff, 'a') { |f| f.write("\n#{res1}") }

    res2 = Diffy::SplitDiff.new(pdf1_text, pdf2_text).right
    res_hash[:right_diff] = res2
    File.open(full_path_right_diff, 'a') { |f| f.write("\n#{res2}") }

    if File.size?(full_path_left_diff) ==  File.size?(full_path_right_diff)
      res_hash['compare_status'] = 'Both Files are Identical'
    else
      res_hash['compare_status'] = 'Diff Found!'
    end
    [res_hash, full_path_left_diff, full_path_right_diff]
  end

end

