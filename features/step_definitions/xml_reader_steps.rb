Given(/^I load "([^"]*)" as first xml$/) do |xml_data|
  @sample_file_path = "./XML/#{xml_data}"
end

And(/^I load "([^"]*)" as second xml$/) do |xml_data|
  @test_file_path = "./XML/#{xml_data}"
end

Then(/^I compare the xmls and generate the report$/) do
  @comparision_result = Hash.new

  @full_path_left_diff =@full_path_right_diff = nil

  doc1 = Nokogiri::XML(File.read(@sample_file_path))
  doc2 = Nokogiri::XML(File.read(@test_file_path))

  @comparision_result, @full_path_left_diff, @full_path_right_diff = JsonDataHelper.compare_logic_xml(doc1, doc2)
end

Then(/^I compare the pdfs and generate the report$/) do

  @comparision_result = Hash.new

  @full_path_left_diff =@full_path_right_diff = nil

  doc1 = @sample_file_path
  doc2 = @test_file_path

  @comparision_result, @full_path_left_diff, @full_path_right_diff = JsonDataHelper.compare_logic_pdf(doc1, doc2)
end

Then(/^I am saving the XML$/) do
  @token = APIHelper.retrieve_token # Get new token
  response = APIHelper.get_document_xml(@token, @document_id)
  #binding.pry
  res = JSON.parse(response[0])
  xml = res['documakerXmls'].first
  xml_response = xml['xml']
  @doc = Nokogiri::XML(xml_response) do |config|
    config.default_xml.noblanks
  end
  @doc.to_xml(:indent => 2)
  new_content = @doc.to_s.gsub('/"', '"')
  new_contents = new_content.gsub('/n', '')
  @xml_location = "#{Nenv.documents_dir}/#{@account}.xml"
  File.write(@xml_location, new_contents)
end

And(/^I launch command prompt and compare the results$/) do

  @output_path = File.expand_path("./XML/#{DataMagic.time_name('result_')}.html")
  @sample_file_path = File.expand_path(@sample_file_path)
  @test_file_path = File.expand_path(@test_file_path)
  old = Dir.pwd
  Dir.chdir("C:/Program Files/WinMerge")
  # win_merge_path = "C:/Program Files/WinMerge/WinMergeU.exe"
  cmd = "WinmergeU.exe #{@sample_file_path} #{@test_file_path} -minimize -noninteractive -cfg ReportFiles/ReportType=2 -u -or #{@output_path}"
  system(cmd)
  cmd1 = "ruby -v"
  system(cmd1)
  Dir.chdir(old)
end

And(/^I write the difference report$/) do
  # render template
  template = File.read('./XML/results_compare.html.erb')
  result = ERB.new(template).result(binding)
  # write result to file
  File.open(File.expand_path("./XML/reports/#{DataMagic.time_name('result-')}.html"), 'w+') do |f|
    f.write result
  end
end