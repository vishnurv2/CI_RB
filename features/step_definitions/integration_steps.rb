# frozen_string_literal: true

When(/^I search for "([^"]*)" using the following benchmark (.*) for "([^"]*)"$/) do |type, policy, state|

  ## append results to file from env param
  @file = ENV['BENCHMARK']
  @file = "benchmarks.txt" if @file == "" || @file.nil?

  visit(BenchmarkViewerPage)
  visit(BenchmarkViewerPage) unless @browser.title == "Select Quotes"

  on(BenchmarkViewerPage) do |page|
    @benchmark = policy
    page.quotes_to_receive = 'Benchmark Quotes'
    page.line_of_business = type
    #page.retrieve_options = 'Second Latest Effective Date'
    page.state = state
    page.retrieve

    benchmark = page.find_benchmark(@benchmark)
    benchmark.select_element.click
    benchmark.options_element.click
    page.download

    @quote_id = benchmark.title.delete(' ').split(':').last
    @premium = benchmark.premium
  end

end

Then(/^I save and extract the benchmark to a file$/) do
  @raw_xml = File.join(Nenv.download_dir, "#{@quote_id}.xml")
  File.delete(@raw_xml) if File.exist?(@raw_xml) # remove if xml exists from prev run

  sleep 6

  path = Nenv.download_dir
  zipped_file = Dir.glob("#{path}/*.zip").max_by { |f| File.mtime(f) }

  # Extract Zip
  Zip::File.open(zipped_file) do |zip_file|
    zip_file.each do |f|
      f_path = File.join(Nenv.download_dir, f.name)
      zip_file.extract(f, f_path)
    end
  end

  sleep 1
  File.delete(zipped_file) if File.exist?(zipped_file)
  found = File.exist?(@raw_xml)

  unless found
    expect(found).to be_truthy, "Expected to find an extracted xml file, but did not, exiting..."
  end

end

Then(/^I modify the data in the XML with (.*)$/) do |state|
  given_name = @benchmark
  sir_name = state
  new_sir_name = Helpers::FakeIt.random_last_name
  new_given_name = Helpers::FakeIt.first_name

  # Modify
  text = File.read(@raw_xml)
  replace_sir_name = text.gsub(/#{sir_name}/, new_sir_name)
  replace_gvn_name = replace_sir_name.gsub(/#{given_name}/, new_given_name)

  File.open(@raw_xml, 'w') { |file| file.puts replace_gvn_name }

  sleep 2

  found = File.exist?(@raw_xml)

  if found
    @raw_xml_data = File.read(@raw_xml) # used for modifications later!
  else
    expect(found).to be_truthy, "Expected to find an extracted xml file, but did not, exiting..."
  end
  @doc = Nokogiri::XML(@raw_xml_data)
  #@doc = Nokogiri::XML(@raw_xml_data) do |config|
  # config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NOBLANKS
  #end
  require 'saxerator'
  @parser = Saxerator.parser(@raw_xml_data)
end

Then(/^I post the data to rate accord and continue$/) do
  STDOUT.puts " Calling RATE ACCORD "

  tok = APIHelper.retrieve_token
  header_params = APIHelper.header_params(tok)
  body = APIHelper.create_body(@raw_xml_data)
  header_params.merge!(body)

  api = PolicyAPI::PolicyActivitiesApi.new
  response = api.v1_policy_activities_rate_acord_post_with_http_info(header_params)

  res = JSON.parse(response[0])
  xml = res['acordResponseXml']
  xml_decoded = Nokogiri::XML(xml)
  @benchmark_pat_account = xml_decoded.xpath('.//AccountId').text
end

And(/^I navigate to the newly created account$/) do
  RouteHelper.login_with_creds
  url = "#{Nenv.base_url}/PolicyAdminWeb/PL/account/#{@benchmark_pat_account}"
  @browser.goto(url)

  text = "#{@benchmark} >> #{url}"
  STDOUT.puts " "
  STDOUT.puts "#{text}"
  STDOUT.puts " "

  base_path = File.expand_path(File.dirname(File.dirname(__FILE__)))
  benchmark_dir = "benchmark/#{@file}"
  full_path = File.join(base_path, benchmark_dir)

  File.open(full_path, 'a') { |f| f.write("\n#{text}") }
end



Then(/^the premium should be the same as (.*) legacy$/) do |policy_type|

  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
  end
  on(PolicyManagementPage).left_navigate_to_toggle(policy_type)

end
Then(/^the new applicants should be displayed in the general information$/) do
  #party_arr = [@party_name_1, @party_name_2, @party_name_3, @party_name_4, @party_name_5, @party_name_6]
  applicant = []
  additional_party = []
  total_applicant = []
  @parser.for_tag(:PersonName).within(:InsuredOrPrincipal).each { |name| applicant.append("#{name['GivenName']} #{name['Surname']}") }
  @parser.for_tag(:PersonName).within(:PersAutoLineBusiness).each { |name| additional_party.append("#{name['GivenName']} #{name['Surname']}") unless additional_party.include? ("#{name['GivenName']} #{name['Surname']}") }
  additional_party = additional_party.uniq
  total_applicant = applicant + additional_party
  on(AccountSummaryPage) do |page|
    total_applicant.each do |str|
        next unless str != " "
        page.applicants_panel.applicants.each_with_index  do |item, i|
          if str.upcase == item.name_element.a.b.text
            puts "Applicant #{i+1}: #{str} is found at Account Summary Screen"
          end
        end
    end
    end
end
Then(/^I validate all vehicle should be present at general information$/) do
  #vehicle_array = [@vehicle_name_0, @vehicle_name_1, @vehicle_name_2, @vehicle_name_3, @vehicle_name_4]
  vehicle_arr = []
  @parser.for_tag(:PersVeh).within(:PersAutoLineBusiness).each { |name|
    name['Manufacturer'] = "null" if name['Manufacturer'] == nil
    vehicle_arr.append("#{name['ModelYear']} #{name['Manufacturer']} #{name['Model']}") unless vehicle_arr.include? ("#{name['ModelYear']} #{name['Manufacturer']} #{name['Model']}") }

  on(AutoPolicySummaryPage) do |page|
    vehicle_arr.each do |str|
      next unless str != " "
      page.vehicle_info_panel.vehicles.each_with_index do |item, i|
        if str == item.vehicle_element.a.text
          puts "Vehicle #{i+1} : #{str} is found at Auto Policy Summary Page"
        end
      end
    end
  end
end

Then(/^I validate all vehicle should be present at WaterCraft general information$/) do
  #vehicle_array = [@vehicle_name_0, @vehicle_name_1, @vehicle_name_2, @vehicle_name_3, @vehicle_name_4]
  vehicle_arr = []
  @parser.for_tag(:ItemDefinition).within(:WatercraftLineBusiness).each { |name| vehicle_arr.append("#{name['ModelYear']} #{name['Model']}") unless vehicle_arr.include? ("#{name['ModelYear']} #{name['Model']}") }

  on(AutoPolicySummaryPage) do |page|
    vehicle_arr.each do |str|
      next unless str != " "
      page.watercraft_vehicle_panel.vehicles.each_with_index do |item, i|
        if str == item.vehicle_element.a.text
          puts "Vehicle #{i+1} : #{str} is found at Auto Policy Summary Page"
        end
      end
    end
  end
end

And(/^I Verify Applicant Name in Account Overview$/) do
  applicant = []
  @parser.for_tag(:PersonName).within(:InsuredOrPrincipal).each { |name| applicant.append("#{name['GivenName']} #{name['Surname']}") }
  on(AccountSummaryPage) do |page|
    applicant.each do |str|
      next unless str != " "
      page.applicants_panel.applicants.each_with_index  do |item, i|
        if str.upcase == item.name_element.a.b.text
          puts "Applicant #{i+1}: #{str.upcase} is found at Account Summary Screen"
        end
      end
    end
  end
end
