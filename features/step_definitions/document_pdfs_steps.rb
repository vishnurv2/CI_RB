# frozen_string_literal: true

Then(/^I save the "([^"]*)" pdf$/) do |document|
  @token = APIHelper.retrieve_token # Get new token

  response = APIHelper.get_documents_from_api(@token, @account, @policy)
  #binding.pry
  find_doc_id = response.select { |doc| doc.document_name == document } # create helper for this?
  @document_id = find_doc_id.first.document_id # pluck ID from response
  document = APIHelper.download_document_by_id(@token, @account, @document_id)

  # there is a bug due to which the first code returned is 202
  # expect(APIHelper.get_response_code(document) == 202) # 'API call returned error'
  if APIHelper.get_response_code(document) == 202
    5.times do
      sleep 15
      response = APIHelper.download_document_by_id(@token, @account, @document_id)
      response_code = APIHelper.get_response_code(response)
      begin
        if response_code == 200
          document = APIHelper.download_document_by_id(@token, @account, @document_id)
        end
      rescue Exception => ex
        STDOUT.puts ex.message
      end
    end
  end

  #  binding.pry

  expect(document[1] == 200).to be_truthy, "Response code at #{Time.new} is #{document[1]}  and Document ID is: #{@document_id}"
  @document_location = "#{Nenv.documents_dir}/#{@account}.pdf"
  APIHelper.save_document(document, @document_location) # Save!
  #APIHelper.save_document(document, @account) # Save!
  #@document_location = "#{Nenv.documents_dir}/#{@account}.pdf"
end

And(/^I gather account and policy numbers for "([^"]*)"$/) do |auto_type|
  @account = @browser.url.split("/").last
  on(PolicyManagementPage).left_nav.navigate_to auto_type
  @policy = @browser.url.split("/").last
end

And(/^I gather account and policy numbers for "([^"]*)" for fully issued policy$/) do |auto_type|
  @account = @browser.url.split("/").last
  # on(PolicyManagementPage).left_nav.navigate_to('Policies')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
    page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to auto_type
  end
  @policy = @browser.url.split("/").last
end

Then(/^I saved the "([^"]*)" pdf$/) do |document|
  @token = APIHelper.retrieve_token # Get new token

  response = APIHelper.get_documents_from_api(@token, @account, @policy)
  #binding.pry
  find_doc_id = response.select { |doc| doc.document_name == document } # create helper for this?
  @document_id = find_doc_id.first.document_id # pluck ID from response
  document = APIHelper.download_document_by_id(@token, @account, @document_id)
  # Dont forget, due to a bug,you may need to re-call the above line
  if APIHelper.get_response_code(document) == 202
    5.times do
      sleep 15
      response = APIHelper.download_document_by_id(@token, @account, @document_id)
      response_code = APIHelper.get_response_code(response)
      if response_code == 200
        document = APIHelper.download_document_by_id(@token, @account, @document_id)
      else
        break
      end
    end
  end

  expect(document[1] == 200).to be_truthy, "Response code at #{Time.new} is #{document[1]}  and Document ID is: #{@document_id}"
  @document_location = "#{Nenv.documents_dir}/#{@account}.pdf"
  APIHelper.save_document(document, @document_location) # Save!
end

Then(/^I gather additional data for IN - Auto for Policy Document$/) do

  #on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Auto')
  # Fetching the Values from the XML for the
  # ### FORMS APPLICABLE TO POLICY ###
  @form_name_0 = @doc.xpath('.//Form').css('Name')[0].text
  @form_date_0 = @doc.xpath('.//Form').css('Date')[0].text
  @form_title_0 = @doc.xpath('.//Form').css('Description')[0].text

  @form_name_1 = @doc.xpath('.//Form').css('Name')[1].text
  @form_date_1 = @doc.xpath('.//Form').css('Date')[1].text
  @form_title_1 = @doc.xpath('.//Form').css('Description')[1].text

  @form_name_2 = @doc.xpath('.//Form').css('Name')[2].text
  @form_date_2 = @doc.xpath('.//Form').css('Date')[2].text
  @form_title_2 = @doc.xpath('.//Form').css('Description')[2].text

  @form_name_3 = @doc.xpath('.//Form').css('Name')[3].text
  @form_date_3 = @doc.xpath('.//Form').css('Date')[3].text
  @form_title_3 = @doc.xpath('.//Form').css('Description')[3].text

  @form_name_4 = @doc.xpath('.//Form').css('Name')[4].text
  @form_date_4 = @doc.xpath('.//Form').css('Date')[4].text
  @form_title_4 = @doc.xpath('.//Form').css('Description')[4].text

  @form_name_5 = @doc.xpath('.//Form').css('Name')[5].text
  @form_date_5 = @doc.xpath('.//Form').css('Date')[5].text
  @form_title_5 = @doc.xpath('.//Form').css('Description')[5].text

  @form_name_6 = @doc.xpath('.//Form').css('Name')[6].text
  @form_date_6 = @doc.xpath('.//Form').css('Date')[6].text
  @form_title_6 = @doc.xpath('.//Form').css('Description')[6].text

  @form_name_7 = @doc.xpath('.//Form').css('Name')[7].text
  @form_date_7 = @doc.xpath('.//Form').css('Date')[7].text
  @form_title_7 = @doc.xpath('.//Form').css('Description')[7].text

  @form_name_8 = @doc.xpath('.//Form').css('Name')[8].text
  @form_date_8 = @doc.xpath('.//Form').css('Date')[8].text
  @form_title_8 = @doc.xpath('.//Form').css('Description')[8].text

  @form_name_9 = @doc.xpath('.//Form').css('Name')[9].text
  @form_date_9 = @doc.xpath('.//Form').css('Date')[9].text
  @form_title_9 = @doc.xpath('.//Form').css('Description')[9].text

  @form_name_10 = @doc.xpath('.//Form').css('Name')[10].text
  @form_date_10 = @doc.xpath('.//Form').css('Date')[10].text
  @form_title_10 = @doc.xpath('.//Form').css('Description')[10].text

  @form_name_11 = @doc.xpath('.//Form').css('Name')[11].text
  @form_date_11 = @doc.xpath('.//Form').css('Date')[11].text
  @form_title_11 = @doc.xpath('.//Form').css('Description')[11].text

  @form_name_12 = @doc.xpath('.//Form').css('Name')[12].text
  @form_date_12 = @doc.xpath('.//Form').css('Date')[12].text
  @form_title_12 = @doc.xpath('.//Form').css('Description')[12].text

  @form_name_13 = @doc.xpath('.//Form').css('Name')[13].text
  @form_date_13 = @doc.xpath('.//Form').css('Date')[13].text
  @form_title_13 = @doc.xpath('.//Form').css('Description')[13].text

  @form_name_14 = @doc.xpath('.//Form').css('Name')[14].text
  @form_date_14 = @doc.xpath('.//Form').css('Date')[14].text
  @form_title_14 = @doc.xpath('.//Form').css('Description')[14].text

  @form_name_15 = @doc.xpath('.//Form').css('Name')[15].text
  @form_date_15 = @doc.xpath('.//Form').css('Date')[15].text
  @form_title_15 = @doc.xpath('.//Form').css('Description')[15].text

  @form_name_16 = @doc.xpath('.//Form').css('Name')[16].text
  @form_date_16 = @doc.xpath('.//Form').css('Date')[16].text
  @form_title_16 = @doc.xpath('.//Form').css('Description')[16].text

  @form_name_17 = @doc.xpath('.//Form').css('Name')[17].text
  @form_date_17 = @doc.xpath('.//Form').css('Date')[17].text
  @form_title_17 = @doc.xpath('.//Form').css('Description')[17].text

  @form_name_18 = @doc.xpath('.//Form').css('Name')[18].text
  @form_date_18 = @doc.xpath('.//Form').css('Date')[18].text
  @form_title_18 = @doc.xpath('.//Form').css('Description')[18].text

  @form_name_19 = @doc.xpath('.//Form').css('Name')[19].text
  @form_date_19 = @doc.xpath('.//Form').css('Date')[19].text
  @form_title_19 = @doc.xpath('.//Form').css('Description')[19].text

end

Then(/^I gather additional data for home policy "([^"]*)"$/) do |home_type|
  #on(PolicyManagementPage).left_navigate_to_if_not_on(home_type)
  # Open Auto vehicle modal & save data to instance variables.
  @quote_Premium = on(AutoPolicySummaryPage).quote_premium
  @quote_Number = on(AutoPolicySummaryPage).quote_number.split('#').last

  on(AutoPolicySummaryPage) do |page|
    modal = page.policy_coverages_panel
    @replacement_cost = modal.replacement_cost
    @other_structures = modal.other_structures
    @contents = modal.contents
    @loss_of_use = modal.loss_of_use
    @home_personal_liability = modal.home_personal_liability
    #@home_deductible = modal.home_deductible
    @home_medical_payments = modal.home_medical_payments
    # @deductible = modal.deductible.delete ","
  end
  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
  end
  # Fetching data using the XML @doc method

  @annual_installment_amount = @doc.xpath('.//PaymentPlans').text.split(' ')[0]
  @annaul_account_service_fee = @doc.xpath('.//PaymentPlans').text.split(' ')[2]

  @semi_annual_installment_amount = @doc.xpath('.//PaymentPlans').text.split(' ')[3]
  @semi_annual_account_service_fee = @doc.xpath('.//PaymentPlans').text.split(' ')[6]

  @quarterly_installment_amount = @doc.xpath('.//PaymentPlans').text.split(' ')[7]
  @quarterly_account_service_fee = @doc.xpath('.//PaymentPlans').text.split(' ')[9]

  @monthly_installment_amount = @doc.xpath('.//PaymentPlans').text.split(' ')[10]
  @monthly_account_service_fee = @doc.xpath('.//PaymentPlans').text.split(' ')[12]

  @billing_information_message = @doc.xpath('.//Message').text

end

Then(/^I validate the PDF for Binder$/) do

  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase
  expected_email = data_used['new_personal_account_modal']['email']
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']
  expected_state = data_used['new_personal_account_modal']['address_details']['state']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_email,
                 expected_agent_name, expected_phone, expected_state,
                 @effective_date, @expiration_date, @replacement_cost,
                 @other_structures, @contents, @loss_of_use, @home_personal_liability, @home_medical_payments]
    arr_second = []
    reader.pages.each do |page|

      #expect(PDFHelper.match_text(page.text, expected_text)).to eq(expected_text), "Expected to Find #{expected_text} in the Binder Document, but did not!"
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      end
    end
  end
end

Then(/^I validate the PDF for Home Quote$/) do

  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_email = data_used['new_personal_account_modal']['email']
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']
  expected_state = data_used['new_personal_account_modal']['address_details']['state']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_email,
                 expected_agent_name, expected_state,
                 @quote_Premium, @effective_date, @quote_Number]
    arr_second = [@annual_installment_amount, @annaul_account_service_fee,
                  @semi_annual_installment_amount, @semi_annual_account_service_fee, @quarterly_installment_amount, @quarterly_account_service_fee,
                  @monthly_installment_amount, @monthly_account_service_fee]
    reader.pages.each do |page|
      #expect(PDFHelper.match_text(page.text, expected_text)).to eq(expected_text), "Expected to Find #{expected_text} in the Binder Document, but did not!"
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      end
    end
  end
end

Then(/^I validate the PDF for Home Application$/) do

  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase
  expected_email = data_used['new_personal_account_modal']['email']
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']
  expected_state = data_used['new_personal_account_modal']['address_details']['state']
  expected_protection_class = data_used['property_info_modal']['protection_class'].remove('0')
  expected_primary_heat_type = "Primary Heat Type: #{data_used['property_info_modal']['primary_heat']}"
  expected_secondry_heat_type = "Secondary Heat Type: #{data_used['property_info_modal']['secondary_heat']}"
  expected_built_year_built = data_used['property_info_modal']['year_built']

  pdf_counter = 1
  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, @effective_date,
                 expected_city, expected_email, expected_agent_name, expected_phone,
                 expected_state, expected_protection_class, expected_built_year_built, @replacement_cost, @other_structures, @contents, @loss_of_use,
                 @home_personal_liability, @home_medical_payments]
    arr_second = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      end
    end
  end
end

Then(/^I gather additional data for Umbrella policy "([^"]*)"$/) do |policy_type|
  # on(PolicyManagementPage).left_navigate_to_if_not_on(policy_type)
  @total_limit_liability_value = @doc.xpath('.//Description').text.split('\\n')[0].strip
  @total_limit_value = @doc.xpath('.//Description').text.split('\\n')[1].strip
  @quote_Premium = on(AutoPolicySummaryPage).quote_premium
  @quote_Number = on(AutoPolicySummaryPage).quote_number.split('#').last

  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
    @policy_mailing_address_first = modal.address.split(',').first
    @policy_mailing_address_middle = modal.address.split(',')[1].strip
    @policy_mailing_address_last = modal.address.split(',').last
  end
  @policy_number = on(AutoPolicySummaryPage).policy_number.split('-').last.split(' ').first
end

Then(/^I validate the PDF for Umbrella Binder$/) do

  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_email = data_used['new_personal_account_modal']['email']
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']
  expected_state = data_used['new_personal_account_modal']['address_details']['state']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr,
                 expected_city, expected_email, expected_agent_name, expected_phone,
                 expected_state, @effective_date, @total_limit_liability_value,
                 @total_limit_value, @quote_Premium, @expiration_date]
    arr_second = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      end
    end
  end
end

Then(/^I validate the PDF for Umbrella Quote$/) do

  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_email = data_used['new_personal_account_modal']['email']
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr,
                 expected_city, expected_email, expected_agent_name, expected_phone,
                 @quote_Premium, @effective_date, @quote_Number, @total_limit_liability_value, @deductible, @Supplementary_liability,
                 @annual_installment_amount, @annaul_account_service_fee,
                 @semi_annual_installment_amount, @semi_annual_account_service_fee,
                 @quarterly_installment_amount, @quarterly_account_service_fee,
                 @monthly_installment_amount, @monthly_account_service_fee]
    arr_second = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      end
    end
  end
end

Then(/^I validate the PDF for Umbrella Application$/) do
  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_email = data_used['new_personal_account_modal']['email']
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_addr, expected_city, expected_email, expected_agent_name, expected_phone,
                 @effective_date, @quote_Premium, @quote_Number, @policy_number, @policy_mailing_address_first,
                 @policy_mailing_address_middle, @policy_mailing_address_last]
    arr_second = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
        end
      end
    end
  end
end

Then(/^I save the XML$/) do
  @token = APIHelper.retrieve_token # Get new token

  response = APIHelper.get_document_xml(@token, @document_id)
  #binding.pry
  res = JSON.parse(response[0])
  xml = res['documakerXmls'].first
  xml_response = xml['xml']
  @doc = Nokogiri::XML(xml_response)
  #require 'saxerator'
  #@parser = Saxerator.parser(xml_response)
  #@parser.for_tag(:PersonName).within(:InsuredOrPrincipal).each { |name| applicant.append("#{name['GivenName']} #{name['Surname']}") }
end

Then(/^I gather additional data for Umbrella policy "([^"]*)" quote$/) do |policy_type|
  #  on(PolicyManagementPage).left_navigate_to_if_not_on(policy_type)
  @total_limit_liability_value = @doc.xpath('.//Description').text.split(' ')[3]
  @deductible = @doc.xpath('.//Description').text.split(' ')[5]
  @Supplementary_liability = @doc.xpath('.//Description').text.split(' ').last

  @annual_installment_amount = @doc.xpath('.//PaymentPlans').text.split(' ')[0]
  @annaul_account_service_fee = @doc.xpath('.//PaymentPlans').text.split(' ')[2]

  @semi_annual_installment_amount = @doc.xpath('.//PaymentPlans').text.split(' ')[3]
  @semi_annual_account_service_fee = @doc.xpath('.//PaymentPlans').text.split(' ')[6]

  @quarterly_installment_amount = @doc.xpath('.//PaymentPlans').text.split(' ')[7]
  @quarterly_account_service_fee = @doc.xpath('.//PaymentPlans').text.split(' ')[9]

  @monthly_installment_amount = @doc.xpath('.//PaymentPlans').text.split(' ')[10]
  @monthly_account_service_fee = @doc.xpath('.//PaymentPlans').text.split(' ')[12]

  @quote_Premium = on(AutoPolicySummaryPage).quote_premium
  @quote_Number = on(AutoPolicySummaryPage).quote_number

  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
    @policy_mailing_address_first = modal.address.split(',').first
    @policy_mailing_address_middle = modal.address.split(',')[1].strip
    @policy_mailing_address_last = modal.address.split(',').last
  end
  @policy_number = on(AutoPolicySummaryPage).policy_number.split('-').last.split(' ').first
end

Then(/^I gather additional data for Umbrella policy "([^"]*)" application$/) do |policy_type|
  # on(PolicyManagementPage).left_navigate_to_if_not_on(policy_type)

  @quote_Premium = on(AutoPolicySummaryPage).quote_premium.remove(' ')
  @quote_Number = on(AutoPolicySummaryPage).quote_number.split('#').last

  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
    @policy_mailing_address_first = modal.address.split(',').first
    @policy_mailing_address_middle = modal.address.split(',')[1].strip
    @policy_mailing_address_last = modal.address.split(',').last
  end
  @policy_number = on(AutoPolicySummaryPage).policy_number.split('-').last.split(' ').first
end

Then(/^I validate the Policy Declaration Forms PDF$/) do
  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_VIN = "VIN: #{data_used["auto_vehicle_modal"]['vehicle_identification_number']}"

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  # expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_policy_effective_date]
    arr_second = [@form_name_0, @form_date_0, @form_title_0, @form_name_1, @form_date_1, @form_title_1,
                  @form_name_2, @form_date_2, @form_title_2, @form_name_3, @form_date_3, @form_title_3,
                  @form_name_4, @form_date_4, @form_title_4, @form_name_5, @form_date_5, @form_title_5,
                  @form_name_6, @form_date_6, @form_title_6, @form_name_7, @form_date_7, @form_title_7,
                  @form_name_8, @form_date_8, @form_title_8, @form_name_9, @form_date_9, @form_title_9,
                  @form_name_10, @form_date_10, @form_title_10, @form_name_11, @form_date_11, @form_title_11,
                  @form_name_12, @form_date_12, @form_title_12, @form_name_13, @form_date_13, @form_title_13,
                  @form_name_14, @form_date_14, @form_title_14, @form_name_15, @form_date_15, @form_title_15,
                  @form_name_16, @form_date_16, @form_title_16, @form_name_17, @form_date_17, @form_title_17,
                  @form_name_18, @form_date_18, @form_title_18, @form_name_19, @form_date_19, @form_title_19]
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 4
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I validate the Policy Declaration Forms PDF for Auto Signature/) do

  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_VIN = "VIN: #{data_used["auto_vehicle_modal"]['vehicle_identification_number']}"

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  # expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_policy_effective_date]
    arr_second = [@form_name_0, @form_date_0, @form_title_0, @form_name_1, @form_date_1, @form_title_1,
                  @form_name_2, @form_date_2, @form_title_2, @form_name_3, @form_date_3, @form_title_3,
                  @form_name_4, @form_date_4, @form_title_4, @form_name_5, @form_date_5, @form_title_5,
                  @form_name_6, @form_date_6, @form_title_6, @form_name_7, @form_date_7, @form_title_7,
                  @form_name_8, @form_date_8, @form_title_8, @form_name_9, @form_date_9, @form_title_9,
                  @form_name_10, @form_date_10, @form_title_10, @form_name_11, @form_date_11, @form_title_11,
                  @form_name_12, @form_date_12, @form_title_12, @form_name_13, @form_date_13, @form_title_13,
                  @form_name_14, @form_date_14, @form_title_14, @form_name_15, @form_date_15, @form_title_15,
                  @form_name_16, @form_date_16, @form_title_16, @form_name_17, @form_date_17, @form_title_17,
                  @form_name_18, @form_date_18, @form_title_18, @form_name_19, @form_date_19, @form_title_19,
                  @form_name_20, @form_date_20, @form_title_20, @form_name_21, @form_date_21, @form_title_21,
                  @form_name_22, @form_date_22, @form_title_22]
    arr_third = [@additional_coverage_title_text,
                 @additional_coverage_text_1, @additional_coverage_text_2, @additional_coverage_text_3,
                 @additional_coverage_text_4, @additional_coverage_text_5, @additional_coverage_text_6,
                 @additional_coverage_text_7, @additional_coverage_text_8, @additional_coverage_text_9,
                 @additional_coverage_text_10, @additional_coverage_text_11, @additional_coverage_text_12,
                 @additional_coverage_text_13, @additional_coverage_text_14, @additional_coverage_text_15,
                 @additional_coverage_text_16, @additional_coverage_text_17, @additional_coverage_text_18]

    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      elsif page.number == 4
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      elsif page.number == 3
        arr_third.each do |str|
          expect(page.text.include? str.strip).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str.strip).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I should see below mentioned Forms in the generated PDF for Auto$/) do |table|
  row = table.raw.flatten
  my_pdf = @document_location
  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|
    reader.pages.each do |page|
      if page.number == 4
        row.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I should see below mentioned Forms in the generated PDF for Auto SC_07$/) do |table|
  row = table.raw.flatten
  my_pdf = @document_location
  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|
    reader.pages.each do |page|
      if page.number == 3
        row.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for IN - Signature Auto for Policy Document$/) do

  on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Signature Auto')
  # Fetching the Values from the XML for the
  # ### FORMS APPLICABLE TO POLICY ###
  @form_name_0 = @doc.xpath('.//Form').css('Name')[0].text
  @form_date_0 = @doc.xpath('.//Form').css('Date')[0].text
  @form_title_0 = @doc.xpath('.//Form').css('Description')[0].text

  @form_name_1 = @doc.xpath('.//Form').css('Name')[1].text
  @form_date_1 = @doc.xpath('.//Form').css('Date')[1].text
  @form_title_1 = @doc.xpath('.//Form').css('Description')[1].text

  @form_name_2 = @doc.xpath('.//Form').css('Name')[2].text
  @form_date_2 = @doc.xpath('.//Form').css('Date')[2].text
  @form_title_2 = @doc.xpath('.//Form').css('Description')[2].text

  @form_name_3 = @doc.xpath('.//Form').css('Name')[3].text
  @form_date_3 = @doc.xpath('.//Form').css('Date')[3].text
  @form_title_3 = @doc.xpath('.//Form').css('Description')[3].text

  @form_name_4 = @doc.xpath('.//Form').css('Name')[4].text
  @form_date_4 = @doc.xpath('.//Form').css('Date')[4].text
  @form_title_4 = @doc.xpath('.//Form').css('Description')[4].text

  @form_name_5 = @doc.xpath('.//Form').css('Name')[5].text
  @form_date_5 = @doc.xpath('.//Form').css('Date')[5].text
  @form_title_5 = @doc.xpath('.//Form').css('Description')[5].text

  @form_name_6 = @doc.xpath('.//Form').css('Name')[6].text
  @form_date_6 = @doc.xpath('.//Form').css('Date')[6].text
  @form_title_6 = @doc.xpath('.//Form').css('Description')[6].text

  @form_name_7 = @doc.xpath('.//Form').css('Name')[7].text
  @form_date_7 = @doc.xpath('.//Form').css('Date')[7].text
  @form_title_7 = @doc.xpath('.//Form').css('Description')[7].text

  @form_name_8 = @doc.xpath('.//Form').css('Name')[8].text
  @form_date_8 = @doc.xpath('.//Form').css('Date')[8].text
  @form_title_8 = @doc.xpath('.//Form').css('Description')[8].text

  @form_name_9 = @doc.xpath('.//Form').css('Name')[9].text
  @form_date_9 = @doc.xpath('.//Form').css('Date')[9].text
  @form_title_9 = @doc.xpath('.//Form').css('Description')[9].text

  @form_name_10 = @doc.xpath('.//Form').css('Name')[10].text
  @form_date_10 = @doc.xpath('.//Form').css('Date')[10].text
  @form_title_10 = @doc.xpath('.//Form').css('Description')[10].text

  @form_name_11 = @doc.xpath('.//Form').css('Name')[11].text
  @form_date_11 = @doc.xpath('.//Form').css('Date')[11].text
  @form_title_11 = @doc.xpath('.//Form').css('Description')[11].text

  @form_name_12 = @doc.xpath('.//Form').css('Name')[12].text
  @form_date_12 = @doc.xpath('.//Form').css('Date')[12].text
  @form_title_12 = @doc.xpath('.//Form').css('Description')[12].text

  @form_name_13 = @doc.xpath('.//Form').css('Name')[13].text
  @form_date_13 = @doc.xpath('.//Form').css('Date')[13].text
  @form_title_13 = @doc.xpath('.//Form').css('Description')[13].text

  @form_name_14 = @doc.xpath('.//Form').css('Name')[14].text
  @form_date_14 = @doc.xpath('.//Form').css('Date')[14].text
  @form_title_14 = @doc.xpath('.//Form').css('Description')[14].text

  @form_name_15 = @doc.xpath('.//Form').css('Name')[15].text
  @form_date_15 = @doc.xpath('.//Form').css('Date')[15].text
  @form_title_15 = @doc.xpath('.//Form').css('Description')[15].text

  @form_name_16 = @doc.xpath('.//Form').css('Name')[16].text
  @form_date_16 = @doc.xpath('.//Form').css('Date')[16].text
  @form_title_16 = @doc.xpath('.//Form').css('Description')[16].text

  @form_name_17 = @doc.xpath('.//Form').css('Name')[17].text
  @form_date_17 = @doc.xpath('.//Form').css('Date')[17].text
  @form_title_17 = @doc.xpath('.//Form').css('Description')[17].text

  @form_name_18 = @doc.xpath('.//Form').css('Name')[18].text
  @form_date_18 = @doc.xpath('.//Form').css('Date')[18].text
  @form_title_18 = @doc.xpath('.//Form').css('Description')[18].text

  @form_name_19 = @doc.xpath('.//Form').css('Name')[19].text
  @form_date_19 = @doc.xpath('.//Form').css('Date')[19].text
  @form_title_19 = @doc.xpath('.//Form').css('Description')[19].text

  @form_name_20 = @doc.xpath('.//Form').css('Name')[20].text
  @form_date_20 = @doc.xpath('.//Form').css('Date')[20].text
  @form_title_20 = @doc.xpath('.//Form').css('Description')[20].text

  @form_name_21 = @doc.xpath('.//Form').css('Name')[21].text
  @form_date_21 = @doc.xpath('.//Form').css('Date')[21].text
  @form_title_21 = @doc.xpath('.//Form').css('Description')[21].text

  @form_name_22 = @doc.xpath('.//Form').css('Name')[22].text
  @form_date_22 = @doc.xpath('.//Form').css('Date')[22].text
  @form_title_22 = @doc.xpath('.//Form').css('Description')[22].text

  ### ADDITIONAL COVERAGES  ### Information
  @additional_coverage_title_text = @doc.xpath('.//PolicyCoverageGroup').css('Line')[0].text
  @additional_coverage_text_1 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[1].text
  @additional_coverage_text_2 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[2].text
  @additional_coverage_text_3 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[3].text
  @additional_coverage_text_4 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[4].text
  @additional_coverage_text_5 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[5].text
  @additional_coverage_text_6 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[6].text
  @additional_coverage_text_7 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[7].text
  @additional_coverage_text_8 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[8].text
  @additional_coverage_text_9 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[9].text
  @additional_coverage_text_10 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[10].text
  @additional_coverage_text_11 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[11].text
  @additional_coverage_text_12 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[12].text
  @additional_coverage_text_13 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[13].text
  @additional_coverage_text_14 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[14].text
  @additional_coverage_text_15 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[15].text
  @additional_coverage_text_16 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[16].text
  @additional_coverage_text_17 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[17].text
  @additional_coverage_text_18 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[18].text
end

Then(/^I gather additional data for IN - Summit Auto for Policy Document$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Summit Auto')
  # Fetching the Values from the XML for the
  # ### FORMS APPLICABLE TO POLICY ###
  @form_name_0 = @doc.xpath('.//Form').css('Name')[0].text
  @form_date_0 = @doc.xpath('.//Form').css('Date')[0].text
  @form_title_0 = @doc.xpath('.//Form').css('Description')[0].text

  @form_name_1 = @doc.xpath('.//Form').css('Name')[1].text
  @form_date_1 = @doc.xpath('.//Form').css('Date')[1].text
  @form_title_1 = @doc.xpath('.//Form').css('Description')[1].text

  @form_name_2 = @doc.xpath('.//Form').css('Name')[2].text
  @form_date_2 = @doc.xpath('.//Form').css('Date')[2].text
  @form_title_2 = @doc.xpath('.//Form').css('Description')[2].text

  @form_name_3 = @doc.xpath('.//Form').css('Name')[3].text
  @form_date_3 = @doc.xpath('.//Form').css('Date')[3].text
  @form_title_3 = @doc.xpath('.//Form').css('Description')[3].text

  @form_name_4 = @doc.xpath('.//Form').css('Name')[4].text
  @form_date_4 = @doc.xpath('.//Form').css('Date')[4].text
  @form_title_4 = @doc.xpath('.//Form').css('Description')[4].text

  @form_name_5 = @doc.xpath('.//Form').css('Name')[5].text
  @form_date_5 = @doc.xpath('.//Form').css('Date')[5].text
  @form_title_5 = @doc.xpath('.//Form').css('Description')[5].text

  @form_name_6 = @doc.xpath('.//Form').css('Name')[6].text
  @form_date_6 = @doc.xpath('.//Form').css('Date')[6].text
  @form_title_6 = @doc.xpath('.//Form').css('Description')[6].text

  @form_name_7 = @doc.xpath('.//Form').css('Name')[7].text
  @form_date_7 = @doc.xpath('.//Form').css('Date')[7].text
  @form_title_7 = @doc.xpath('.//Form').css('Description')[7].text

  @form_name_8 = @doc.xpath('.//Form').css('Name')[8].text
  @form_date_8 = @doc.xpath('.//Form').css('Date')[8].text
  @form_title_8 = @doc.xpath('.//Form').css('Description')[8].text

  @form_name_9 = @doc.xpath('.//Form').css('Name')[9].text
  @form_date_9 = @doc.xpath('.//Form').css('Date')[9].text
  @form_title_9 = @doc.xpath('.//Form').css('Description')[9].text

  @form_name_10 = @doc.xpath('.//Form').css('Name')[10].text
  @form_date_10 = @doc.xpath('.//Form').css('Date')[10].text
  @form_title_10 = @doc.xpath('.//Form').css('Description')[10].text

  @form_name_11 = @doc.xpath('.//Form').css('Name')[11].text
  @form_date_11 = @doc.xpath('.//Form').css('Date')[11].text
  @form_title_11 = @doc.xpath('.//Form').css('Description')[11].text

  @form_name_12 = @doc.xpath('.//Form').css('Name')[12].text
  @form_date_12 = @doc.xpath('.//Form').css('Date')[12].text
  @form_title_12 = @doc.xpath('.//Form').css('Description')[12].text

  @form_name_13 = @doc.xpath('.//Form').css('Name')[13].text
  @form_date_13 = @doc.xpath('.//Form').css('Date')[13].text
  @form_title_13 = @doc.xpath('.//Form').css('Description')[13].text

  @form_name_14 = @doc.xpath('.//Form').css('Name')[14].text
  @form_date_14 = @doc.xpath('.//Form').css('Date')[14].text
  @form_title_14 = @doc.xpath('.//Form').css('Description')[14].text

  @form_name_15 = @doc.xpath('.//Form').css('Name')[15].text
  @form_date_15 = @doc.xpath('.//Form').css('Date')[15].text
  @form_title_15 = @doc.xpath('.//Form').css('Description')[15].text

  @form_name_16 = @doc.xpath('.//Form').css('Name')[16].text
  @form_date_16 = @doc.xpath('.//Form').css('Date')[16].text
  @form_title_16 = @doc.xpath('.//Form').css('Description')[16].text

  @form_name_17 = @doc.xpath('.//Form').css('Name')[17].text
  @form_date_17 = @doc.xpath('.//Form').css('Date')[17].text
  @form_title_17 = @doc.xpath('.//Form').css('Description')[17].text

  @form_name_18 = @doc.xpath('.//Form').css('Name')[18].text
  @form_date_18 = @doc.xpath('.//Form').css('Date')[18].text
  @form_title_18 = @doc.xpath('.//Form').css('Description')[18].text

  @form_name_19 = @doc.xpath('.//Form').css('Name')[19].text
  @form_date_19 = @doc.xpath('.//Form').css('Date')[19].text
  @form_title_19 = @doc.xpath('.//Form').css('Description')[19].text

  @form_name_20 = @doc.xpath('.//Form').css('Name')[20].text
  @form_date_20 = @doc.xpath('.//Form').css('Date')[20].text
  @form_title_20 = @doc.xpath('.//Form').css('Description')[20].text

  @form_name_21 = @doc.xpath('.//Form').css('Name')[21].text
  @form_date_21 = @doc.xpath('.//Form').css('Date')[21].text
  @form_title_21 = @doc.xpath('.//Form').css('Description')[21].text

  @form_name_22 = @doc.xpath('.//Form').css('Name')[22].text
  @form_date_22 = @doc.xpath('.//Form').css('Date')[22].text
  @form_title_22 = @doc.xpath('.//Form').css('Description')[22].text

  @form_name_23 = @doc.xpath('.//Form').css('Name')[23].text
  @form_date_23 = @doc.xpath('.//Form').css('Date')[23].text
  @form_title_23 = @doc.xpath('.//Form').css('Description')[23].text

  @form_name_24 = @doc.xpath('.//Form').css('Name')[24].text
  @form_date_24 = @doc.xpath('.//Form').css('Date')[24].text
  @form_title_24 = @doc.xpath('.//Form').css('Description')[24].text
end

Then(/^I validate the Policy Declaration Forms PDF for Auto Summit$/) do

  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_VIN = "VIN: #{data_used["auto_vehicle_modal"]['vehicle_identification_number']}"

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  # expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_policy_effective_date]
    arr_second = [@form_name_0, @form_date_0, @form_title_0, @form_name_1, @form_date_1, @form_title_1,
                  @form_name_2, @form_date_2, @form_title_2, @form_name_3, @form_date_3, @form_title_3,
                  @form_name_4, @form_date_4, @form_title_4, @form_name_5, @form_date_5, @form_title_5,
                  @form_name_6, @form_date_6, @form_title_6, @form_name_7, @form_date_7, @form_title_7,
                  @form_name_8, @form_date_8, @form_title_8, @form_name_9, @form_date_9, @form_title_9,
                  @form_name_10, @form_date_10, @form_title_10, @form_name_11, @form_date_11, @form_title_11,
                  @form_name_12, @form_date_12, @form_title_12, @form_name_13, @form_date_13, @form_title_13,
                  @form_name_14, @form_date_14, @form_title_14, @form_name_15, @form_date_15, @form_title_15,
                  @form_name_16, @form_date_16, @form_title_16, @form_name_17, @form_date_17, @form_title_17,
                  @form_name_18, @form_date_18, @form_title_18, @form_name_19, @form_date_19, @form_title_19,
                  @form_name_20, @form_date_20, @form_title_20, @form_name_21, @form_date_21, @form_title_21,
                  @form_name_22, @form_date_22, @form_title_22, @form_name_23, @form_date_23, @form_title_23,
                  @form_name_24, @form_date_24, @form_title_24]

    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      elsif page.number == 4
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for IN - Summit Auto for Policy Document SC_04$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Summit Auto')
  # Fetching the Values from the XML for the
  # ### FORMS APPLICABLE TO POLICY ###
  @form_name_0 = @doc.xpath('.//Form').css('Name')[0].text
  @form_date_0 = @doc.xpath('.//Form').css('Date')[0].text
  @form_title_0 = @doc.xpath('.//Form').css('Description')[0].text

  @form_name_1 = @doc.xpath('.//Form').css('Name')[1].text
  @form_date_1 = @doc.xpath('.//Form').css('Date')[1].text
  @form_title_1 = @doc.xpath('.//Form').css('Description')[1].text

  @form_name_2 = @doc.xpath('.//Form').css('Name')[2].text
  @form_date_2 = @doc.xpath('.//Form').css('Date')[2].text
  @form_title_2 = @doc.xpath('.//Form').css('Description')[2].text

  @form_name_3 = @doc.xpath('.//Form').css('Name')[3].text
  @form_date_3 = @doc.xpath('.//Form').css('Date')[3].text
  @form_title_3 = @doc.xpath('.//Form').css('Description')[3].text

  @form_name_4 = @doc.xpath('.//Form').css('Name')[4].text
  @form_date_4 = @doc.xpath('.//Form').css('Date')[4].text
  @form_title_4 = @doc.xpath('.//Form').css('Description')[4].text

  @form_name_5 = @doc.xpath('.//Form').css('Name')[5].text
  @form_date_5 = @doc.xpath('.//Form').css('Date')[5].text
  @form_title_5 = @doc.xpath('.//Form').css('Description')[5].text

  @form_name_6 = @doc.xpath('.//Form').css('Name')[6].text
  @form_date_6 = @doc.xpath('.//Form').css('Date')[6].text
  @form_title_6 = @doc.xpath('.//Form').css('Description')[6].text

  @form_name_7 = @doc.xpath('.//Form').css('Name')[7].text
  @form_date_7 = @doc.xpath('.//Form').css('Date')[7].text
  @form_title_7 = @doc.xpath('.//Form').css('Description')[7].text

  @form_name_8 = @doc.xpath('.//Form').css('Name')[8].text
  @form_date_8 = @doc.xpath('.//Form').css('Date')[8].text
  @form_title_8 = @doc.xpath('.//Form').css('Description')[8].text

  @form_name_9 = @doc.xpath('.//Form').css('Name')[9].text
  @form_date_9 = @doc.xpath('.//Form').css('Date')[9].text
  @form_title_9 = @doc.xpath('.//Form').css('Description')[9].text

  @form_name_10 = @doc.xpath('.//Form').css('Name')[10].text
  @form_date_10 = @doc.xpath('.//Form').css('Date')[10].text
  @form_title_10 = @doc.xpath('.//Form').css('Description')[10].text

  @form_name_11 = @doc.xpath('.//Form').css('Name')[11].text
  @form_date_11 = @doc.xpath('.//Form').css('Date')[11].text
  @form_title_11 = @doc.xpath('.//Form').css('Description')[11].text

  @form_name_12 = @doc.xpath('.//Form').css('Name')[12].text
  @form_date_12 = @doc.xpath('.//Form').css('Date')[12].text
  @form_title_12 = @doc.xpath('.//Form').css('Description')[12].text

  @form_name_13 = @doc.xpath('.//Form').css('Name')[13].text
  @form_date_13 = @doc.xpath('.//Form').css('Date')[13].text
  @form_title_13 = @doc.xpath('.//Form').css('Description')[13].text

  @form_name_14 = @doc.xpath('.//Form').css('Name')[14].text
  @form_date_14 = @doc.xpath('.//Form').css('Date')[14].text
  @form_title_14 = @doc.xpath('.//Form').css('Description')[14].text

  @form_name_15 = @doc.xpath('.//Form').css('Name')[15].text
  @form_date_15 = @doc.xpath('.//Form').css('Date')[15].text
  @form_title_15 = @doc.xpath('.//Form').css('Description')[15].text

  @form_name_16 = @doc.xpath('.//Form').css('Name')[16].text
  @form_date_16 = @doc.xpath('.//Form').css('Date')[16].text
  @form_title_16 = @doc.xpath('.//Form').css('Description')[16].text

  @form_name_17 = @doc.xpath('.//Form').css('Name')[17].text
  @form_date_17 = @doc.xpath('.//Form').css('Date')[17].text
  @form_title_17 = @doc.xpath('.//Form').css('Description')[17].text

  @form_name_18 = @doc.xpath('.//Form').css('Name')[18].text
  @form_date_18 = @doc.xpath('.//Form').css('Date')[18].text
  @form_title_18 = @doc.xpath('.//Form').css('Description')[18].text

  @form_name_19 = @doc.xpath('.//Form').css('Name')[19].text
  @form_date_19 = @doc.xpath('.//Form').css('Date')[19].text
  @form_title_19 = @doc.xpath('.//Form').css('Description')[19].text

  @form_name_20 = @doc.xpath('.//Form').css('Name')[20].text
  @form_date_20 = @doc.xpath('.//Form').css('Date')[20].text
  @form_title_20 = @doc.xpath('.//Form').css('Description')[20].text
end

Then(/^I validate the Policy Declaration Forms PDF for Auto Summit SC_04$/) do

  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_VIN = "VIN: #{data_used["auto_vehicle_modal"]['vehicle_identification_number']}"

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  #expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_policy_effective_date]
    arr_second = [@form_name_0, @form_date_0, @form_title_0, @form_name_1, @form_date_1, @form_title_1,
                  @form_name_2, @form_date_2, @form_title_2, @form_name_3, @form_date_3, @form_title_3,
                  @form_name_4, @form_date_4, @form_title_4, @form_name_5, @form_date_5, @form_title_5,
                  @form_name_6, @form_date_6, @form_title_6, @form_name_7, @form_date_7, @form_title_7,
                  @form_name_8, @form_date_8, @form_title_8, @form_name_9, @form_date_9, @form_title_9,
                  @form_name_10, @form_date_10, @form_title_10, @form_name_11, @form_date_11, @form_title_11,
                  @form_name_12, @form_date_12, @form_title_12, @form_name_13, @form_date_13, @form_title_13,
                  @form_name_14, @form_date_14, @form_title_14, @form_name_15, @form_date_15, @form_title_15,
                  @form_name_16, @form_date_16, @form_title_16, @form_name_17, @form_date_17, @form_title_17,
                  @form_name_18, @form_date_18, @form_title_18, @form_name_19, @form_date_19, @form_title_19,
                  @form_name_20, @form_date_20, @form_title_20]

    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      elsif page.number == 4
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for IN - Auto for Policy Document for SC_07$/) do

  #on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Auto')
  # Fetching the Values from the XML for the
  # ### FORMS APPLICABLE TO POLICY ###
  @form_name_0 = @doc.xpath('.//Form').css('Name')[0].text
  @form_date_0 = @doc.xpath('.//Form').css('Date')[0].text
  @form_title_0 = @doc.xpath('.//Form').css('Description')[0].text

  @form_name_1 = @doc.xpath('.//Form').css('Name')[1].text
  @form_date_1 = @doc.xpath('.//Form').css('Date')[1].text
  @form_title_1 = @doc.xpath('.//Form').css('Description')[1].text

  @form_name_2 = @doc.xpath('.//Form').css('Name')[2].text
  @form_date_2 = @doc.xpath('.//Form').css('Date')[2].text
  @form_title_2 = @doc.xpath('.//Form').css('Description')[2].text

  @form_name_3 = @doc.xpath('.//Form').css('Name')[3].text
  @form_date_3 = @doc.xpath('.//Form').css('Date')[3].text
  @form_title_3 = @doc.xpath('.//Form').css('Description')[3].text

  @form_name_4 = @doc.xpath('.//Form').css('Name')[4].text
  @form_date_4 = @doc.xpath('.//Form').css('Date')[4].text
  @form_title_4 = @doc.xpath('.//Form').css('Description')[4].text

  @form_name_5 = @doc.xpath('.//Form').css('Name')[5].text
  @form_date_5 = @doc.xpath('.//Form').css('Date')[5].text
  @form_title_5 = @doc.xpath('.//Form').css('Description')[5].text

  @form_name_6 = @doc.xpath('.//Form').css('Name')[6].text
  @form_date_6 = @doc.xpath('.//Form').css('Date')[6].text
  @form_title_6 = @doc.xpath('.//Form').css('Description')[6].text

  @form_name_7 = @doc.xpath('.//Form').css('Name')[7].text
  @form_date_7 = @doc.xpath('.//Form').css('Date')[7].text
  @form_title_7 = @doc.xpath('.//Form').css('Description')[7].text

  @form_name_8 = @doc.xpath('.//Form').css('Name')[8].text
  @form_date_8 = @doc.xpath('.//Form').css('Date')[8].text
  @form_title_8 = @doc.xpath('.//Form').css('Description')[8].text

  @form_name_9 = @doc.xpath('.//Form').css('Name')[9].text
  @form_date_9 = @doc.xpath('.//Form').css('Date')[9].text
  @form_title_9 = @doc.xpath('.//Form').css('Description')[9].text

  @form_name_10 = @doc.xpath('.//Form').css('Name')[10].text
  @form_date_10 = @doc.xpath('.//Form').css('Date')[10].text
  @form_title_10 = @doc.xpath('.//Form').css('Description')[10].text

  @form_name_11 = @doc.xpath('.//Form').css('Name')[11].text
  @form_date_11 = @doc.xpath('.//Form').css('Date')[11].text
  @form_title_11 = @doc.xpath('.//Form').css('Description')[11].text

  @form_name_12 = @doc.xpath('.//Form').css('Name')[12].text
  @form_date_12 = @doc.xpath('.//Form').css('Date')[12].text
  @form_title_12 = @doc.xpath('.//Form').css('Description')[12].text

  @form_name_13 = @doc.xpath('.//Form').css('Name')[13].text
  @form_date_13 = @doc.xpath('.//Form').css('Date')[13].text
  @form_title_13 = @doc.xpath('.//Form').css('Description')[13].text

  @form_name_14 = @doc.xpath('.//Form').css('Name')[14].text
  @form_date_14 = @doc.xpath('.//Form').css('Date')[14].text
  @form_title_14 = @doc.xpath('.//Form').css('Description')[14].text

  @form_name_15 = @doc.xpath('.//Form').css('Name')[15].text
  @form_date_15 = @doc.xpath('.//Form').css('Date')[15].text
  @form_title_15 = @doc.xpath('.//Form').css('Description')[15].text
end

Then(/^I validate the Policy Declaration Forms PDF for Auto for SC_07$/) do

  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_VIN = "VIN: #{data_used["auto_vehicle_modal"]['vehicle_identification_number']}"

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  # expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_policy_effective_date]
    arr_second = [@form_name_0, @form_date_0, @form_title_0, @form_name_1, @form_date_1, @form_title_1,
                  @form_name_2, @form_date_2, @form_title_2, @form_name_3, @form_date_3, @form_title_3,
                  @form_name_4, @form_date_4, @form_title_4, @form_name_5, @form_date_5, @form_title_5,
                  @form_name_6, @form_date_6, @form_title_6, @form_name_7, @form_date_7, @form_title_7,
                  @form_name_8, @form_date_8, @form_title_8, @form_name_9, @form_date_9, @form_title_9,
                  @form_name_10, @form_date_10, @form_title_10, @form_name_11, @form_date_11, @form_title_11,
                  @form_name_12, @form_date_12, @form_title_12, @form_name_13, @form_date_13, @form_title_13,
                  @form_name_14, @form_date_14, @form_title_14, @form_name_15, @form_date_15, @form_title_15]

    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      elsif page.number == 3
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I validate the AutoIDCard pdf$/) do
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal
  expected_VIN = data_used['auto_vehicle_modal']['vehicle_identification_number']
  expected_modal = data_used['auto_vehicle_modal']['xxblack_book_model'].upcase

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_addr, expected_city, expected_policy_effective_date, expected_VIN, expected_modal]
    arr_second = []

    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for schedule property policy$/) do

  # Retrieving the form Name
  @form_name_0 = @doc.xpath('.//FormsAttachedToPolicy').css('Name')[0].text
  @form_date_0 = @doc.xpath('.//FormsAttachedToPolicy').css('Date')[0].text
  @form_title_0 = @doc.xpath('.//FormsAttachedToPolicy').css('Description')[0].text

  @form_name_1 = @doc.xpath('.//FormsAttachedToPolicy').css('Name')[1].text
  @form_date_1 = @doc.xpath('.//FormsAttachedToPolicy').css('Date')[1].text
  @form_title_1 = @doc.xpath('.//FormsAttachedToPolicy').css('Description')[1].text

  @form_name_2 = @doc.xpath('.//FormsAttachedToPolicy').css('Name')[2].text
  @form_date_2 = @doc.xpath('.//FormsAttachedToPolicy').css('Date')[2].text
  @form_title_2 = @doc.xpath('.//FormsAttachedToPolicy').css('Description')[2].text

  @form_name_3 = @doc.xpath('.//FormsAttachedToPolicy').css('Name')[3].text
  @form_date_3 = @doc.xpath('.//FormsAttachedToPolicy').css('Date')[3].text
  @form_title_3 = @doc.xpath('.//FormsAttachedToPolicy').css('Description')[3].text

  @form_name_4 = @doc.xpath('.//FormsAttachedToPolicy').css('Name')[4].text
  @form_date_4 = @doc.xpath('.//FormsAttachedToPolicy').css('Date')[4].text
  @form_title_4 = @doc.xpath('.//FormsAttachedToPolicy').css('Description')[4].text

  @form_name_5 = @doc.xpath('.//FormsAttachedToPolicy').css('Name')[5].text
  @form_date_5 = @doc.xpath('.//FormsAttachedToPolicy').css('Date')[5].text
  @form_title_5 = @doc.xpath('.//FormsAttachedToPolicy').css('Description')[5].text
end

Then(/^I validate the PDF for Schedule Property Declaration$/) do
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_addr, expected_city, expected_name]
    arr_second = [@form_name_0, @form_date_0, @form_title_0, @form_name_1, @form_date_1, @form_title_1,
                  @form_name_2, @form_date_2, @form_title_2, @form_name_3, @form_date_3, @form_title_3,
                  @form_name_4, @form_date_4, @form_title_4, @form_name_5, @form_date_5, @form_title_5]

    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for IN - Auto for Policy Document for Sc_05$/) do

  #on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Auto')
  # Fetching the Values from the XML for the
  # ### FORMS APPLICABLE TO POLICY ###
  @form_name_0 = @doc.xpath('.//Form').css('Name')[0].text
  @form_date_0 = @doc.xpath('.//Form').css('Date')[0].text
  @form_title_0 = @doc.xpath('.//Form').css('Description')[0].text

  @form_name_1 = @doc.xpath('.//Form').css('Name')[1].text
  @form_date_1 = @doc.xpath('.//Form').css('Date')[1].text
  @form_title_1 = @doc.xpath('.//Form').css('Description')[1].text

  @form_name_2 = @doc.xpath('.//Form').css('Name')[2].text
  @form_date_2 = @doc.xpath('.//Form').css('Date')[2].text
  @form_title_2 = @doc.xpath('.//Form').css('Description')[2].text

  @form_name_3 = @doc.xpath('.//Form').css('Name')[3].text
  @form_date_3 = @doc.xpath('.//Form').css('Date')[3].text
  @form_title_3 = @doc.xpath('.//Form').css('Description')[3].text

  @form_name_4 = @doc.xpath('.//Form').css('Name')[4].text
  @form_date_4 = @doc.xpath('.//Form').css('Date')[4].text
  @form_title_4 = @doc.xpath('.//Form').css('Description')[4].text

  @form_name_5 = @doc.xpath('.//Form').css('Name')[5].text
  @form_date_5 = @doc.xpath('.//Form').css('Date')[5].text
  @form_title_5 = @doc.xpath('.//Form').css('Description')[5].text

  @form_name_6 = @doc.xpath('.//Form').css('Name')[6].text
  @form_date_6 = @doc.xpath('.//Form').css('Date')[6].text
  @form_title_6 = @doc.xpath('.//Form').css('Description')[6].text

  @form_name_7 = @doc.xpath('.//Form').css('Name')[7].text
  @form_date_7 = @doc.xpath('.//Form').css('Date')[7].text
  @form_title_7 = @doc.xpath('.//Form').css('Description')[7].text

  @form_name_8 = @doc.xpath('.//Form').css('Name')[8].text
  @form_date_8 = @doc.xpath('.//Form').css('Date')[8].text
  @form_title_8 = @doc.xpath('.//Form').css('Description')[8].text

  @form_name_9 = @doc.xpath('.//Form').css('Name')[9].text
  @form_date_9 = @doc.xpath('.//Form').css('Date')[9].text
  @form_title_9 = @doc.xpath('.//Form').css('Description')[9].text

  @form_name_10 = @doc.xpath('.//Form').css('Name')[10].text
  @form_date_10 = @doc.xpath('.//Form').css('Date')[10].text
  @form_title_10 = @doc.xpath('.//Form').css('Description')[10].text

  @form_name_11 = @doc.xpath('.//Form').css('Name')[11].text
  @form_date_11 = @doc.xpath('.//Form').css('Date')[11].text
  @form_title_11 = @doc.xpath('.//Form').css('Description')[11].text

  @form_name_12 = @doc.xpath('.//Form').css('Name')[12].text
  @form_date_12 = @doc.xpath('.//Form').css('Date')[12].text
  @form_title_12 = @doc.xpath('.//Form').css('Description')[12].text

  @form_name_13 = @doc.xpath('.//Form').css('Name')[13].text
  @form_date_13 = @doc.xpath('.//Form').css('Date')[13].text
  @form_title_13 = @doc.xpath('.//Form').css('Description')[13].text

  @form_name_14 = @doc.xpath('.//Form').css('Name')[14].text
  @form_date_14 = @doc.xpath('.//Form').css('Date')[14].text
  @form_title_14 = @doc.xpath('.//Form').css('Description')[14].text

  @form_name_15 = @doc.xpath('.//Form').css('Name')[15].text
  @form_date_15 = @doc.xpath('.//Form').css('Date')[15].text
  @form_title_15 = @doc.xpath('.//Form').css('Description')[15].text

  @form_name_16 = @doc.xpath('.//Form').css('Name')[16].text
  @form_date_16 = @doc.xpath('.//Form').css('Date')[16].text
  @form_title_16 = @doc.xpath('.//Form').css('Description')[16].text

  @form_name_17 = @doc.xpath('.//Form').css('Name')[17].text
  @form_date_17 = @doc.xpath('.//Form').css('Date')[17].text
  @form_title_17 = @doc.xpath('.//Form').css('Description')[17].text

end

Then(/^I validate the Policy Declaration Forms PDF for SC_05$/) do
  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_VIN = "VIN: #{data_used["auto_vehicle_modal"]['vehicle_identification_number']}"

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  # expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_policy_effective_date]
    arr_second = [@form_name_0, @form_date_0, @form_title_0, @form_name_1, @form_date_1, @form_title_1,
                  @form_name_2, @form_date_2, @form_title_2, @form_name_3, @form_date_3, @form_title_3,
                  @form_name_4, @form_date_4, @form_title_4, @form_name_5, @form_date_5, @form_title_5,
                  @form_name_6, @form_date_6, @form_title_6, @form_name_7, @form_date_7, @form_title_7,
                  @form_name_8, @form_date_8, @form_title_8, @form_name_9, @form_date_9, @form_title_9,
                  @form_name_10, @form_date_10, @form_title_10, @form_name_11, @form_date_11, @form_title_11,
                  @form_name_12, @form_date_12, @form_title_12, @form_name_13, @form_date_13, @form_title_13,
                  @form_name_14, @form_date_14, @form_title_14, @form_name_15, @form_date_15, @form_title_15,
                  @form_name_16, @form_date_16, @form_title_16, @form_name_17, @form_date_17, @form_title_17]
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 4
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I validate the EvidenceOfCancellation pdf$/) do
  data_used = EDSL::PageObject.fixture_cache

  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase
  expected_policy_effective_date = Chronic.parse(data_used['add_product_modal']['policy_effective_date']).to_date.strftime('%B %d, %Y')
  expected_cancellation_date = Chronic.parse('today').to_date.strftime('%B %d, %Y')

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_policy_effective_date, expected_cancellation_date]
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I validate the CancelNotice pdf$/) do
  data_used = EDSL::PageObject.fixture_cache

  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase
  expected_date_of_notice = Chronic.parse('today').to_date.strftime('%m/%d/%Y')
  cancellation_reason = @cancellation_data['reason_dropdown'].upcase

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_date_of_notice, cancellation_reason]
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I validate the ReinstatementDeclaration pdf$/) do
  data_used = EDSL::PageObject.fixture_cache

  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase
  expected_date_of_notice = Chronic.parse('today').to_date.strftime('%m/%d/%Y')

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_date_of_notice]
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I validate the Proposal pdf$/) do
  data_used = EDSL::PageObject.fixture_cache

  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase
  expected_date = Chronic.parse('today').to_date.strftime('%B %d, %Y')

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_date, @prepared_for, @prepared_by]
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I saved the "([^"]*)" pdf from account$/) do |document|
  @token = APIHelper.retrieve_token # Get new token

  response = APIHelper.get_all_documents_from_api(@token, @account)
  #binding.pry
  find_doc_id = response.select { |doc| doc.document_name == document } # create helper for this?
  @document_id = find_doc_id.first.document_id # pluck ID from response
  document = APIHelper.download_document_by_id(@token, @account, @document_id)
  # Dont forget, due to a bug,you may need to re-call the above line
  if APIHelper.get_response_code(document) == 202
    5.times do
      sleep 15
      response = APIHelper.download_document_by_id(@token, @account, @document_id)
      response_code = APIHelper.get_response_code(response)
      if response_code == 200
        document = APIHelper.download_document_by_id(@token, @account, @document_id)
      else
        break
      end
    end
  end

  expect(document[1] == 200).to be_truthy, "Response code at #{Time.new} is #{document[1]}  and Document ID is: #{@document_id}"
  @document_location = "#{Nenv.documents_dir}/#{@account}.pdf"
  APIHelper.save_document(document, @document_location) # Save!
end

Then(/^I validate the NonRenewalNotice pdf$/) do
  data_used = EDSL::PageObject.fixture_cache

  my_pdf = @document_location

  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase
  expected_policy_effective_date = Chronic.parse(data_used['add_product_modal']['policy_effective_date']).to_date.strftime('%B %d, %Y')
  expected_cancellation_date = Chronic.parse('today').to_date.strftime('%B %d, %Y')

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_policy_effective_date, expected_cancellation_date]
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      end
    end
  end
end