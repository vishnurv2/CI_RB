Then(/^I validate the Binder Document for WaterCraft$/) do
  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_email = data_used['new_personal_account_modal']['email']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city,
                 @insured_name, @insured_city, @insured_state, @insured_zipcode, @insured_email_address]

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

Then(/^I save additional details for watercraft Binder$/) do
  @insured_name =  @doc.xpath('.//InsuredInformation').css('Name')[1].text
  @insured_city = @doc.xpath('.//InsuredInformation').css('City').text
  @insured_state = @doc.xpath('.//InsuredInformation').css('State').text
  @insured_zipcode = @doc.xpath('.//InsuredInformation').css('ZipCode').text
  @insured_email_address = @doc.xpath('.//InsuredInformation').css('EmailAddress').text

end

Then(/^I save additional details for watercraft Application$/) do
  @insured_name =  @doc.xpath('.//InsuredInformation').css('Name')[1].text
  @insured_city = @doc.xpath('.//InsuredInformation').css('City').text
  @insured_state = @doc.xpath('.//InsuredInformation').css('State').text
  @insured_zipcode = @doc.xpath('.//InsuredInformation').css('ZipCode').text
  @insured_email_address = @doc.xpath('.//InsuredInformation').css('EmailAddress').text

  # Collecting the Agent Information using XML
  @quote_number =  @doc.xpath('.//QuoteNumber').text
  @prepared_by = @doc.xpath('.//PreparedBy').text
end

Then(/^I validate the Application Document for WaterCraft$/) do
  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_email = data_used['new_personal_account_modal']['email']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, @insured_email_address,
                 @insured_name, @insured_city, @insured_state, @insured_zipcode,
                 @quote_number, @prepared_by]

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

Then(/^I save additional details for watercraft Quote$/) do
  @insured_name =  @doc.xpath('.//InsuredInformation').css('Name')[1].text
  @insured_city = @doc.xpath('.//InsuredInformation').css('City').text
  @insured_state = @doc.xpath('.//InsuredInformation').css('State').text
  @insured_zipcode = @doc.xpath('.//InsuredInformation').css('ZipCode').text
  @insured_email_address = @doc.xpath('.//InsuredInformation').css('EmailAddress').text

  # Collecting the Agent Information using XML
  @quote_number =  @doc.xpath('.//QuoteNumber').text
  @prepared_by = @doc.xpath('.//PreparedBy').text

  @annual_installment_amount = @doc.xpath('.//PaymentPlans').css('Amount')[0].text
  @semi_annual_installment_amount = @doc.xpath('.//PaymentPlans').css('Amount')[1].text
  @quarterly_installment_amount = @doc.xpath('.//PaymentPlans').css('Amount')[2].text
  @monthly_installment_amount = @doc.xpath('.//PaymentPlans').css('Amount')[3].text
  @annual_premium = @doc.xpath('.//AnnualPremium').text
end

Then(/^I validate the Quote Document for WaterCraft$/) do
  data_used = EDSL::PageObject.fixture_cache
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_email = data_used['new_personal_account_modal']['email']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city,
                 @insured_name, @insured_city, @insured_state, @insured_zipcode, @insured_email_address,
                 @quote_number, @prepared_by, @annual_installment_amount, @semi_annual_installment_amount,
                 @quarterly_installment_amount, @monthly_installment_amount, @annual_premium]

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

Then(/^I save additional details for watercraft Policy Declaration$/) do
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

  # @form_name_12 = @doc.xpath('.//Form').css('Name')[12].text
  # @form_date_12 = @doc.xpath('.//Form').css('Date')[12].text
  # @form_title_12 = @doc.xpath('.//Form').css('Description')[12].text

  # @form_name_13 = @doc.xpath('.//Form').css('Name')[13].text
  # @form_date_13 = @doc.xpath('.//Form').css('Date')[13].text
  # @form_title_13 = @doc.xpath('.//Form').css('Description')[13].text

  # @form_name_14 = @doc.xpath('.//Form').css('Name')[14].text
  # @form_date_14 = @doc.xpath('.//Form').css('Date')[14].text
  # @form_title_14 = @doc.xpath('.//Form').css('Description')[14].text

end

Then(/^I validate the Policy Declaration Document for WaterCraft$/) do
  ## Data from automation
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

    arr_first = [expected_name, expected_addr, expected_city]
    arr_second = [@form_name_0, @form_date_0, @form_title_0, @form_name_1, @form_date_1, @form_title_1,
                  @form_name_2, @form_date_2, @form_title_2, @form_name_3, @form_date_3, @form_title_3,
                  @form_name_4, @form_date_4, @form_title_4, @form_name_5, @form_date_5, @form_title_5,
                  @form_name_6, @form_date_6, @form_title_6, @form_name_7, @form_date_7, @form_title_7,
                  @form_name_8, @form_date_8, @form_title_8, @form_name_9, @form_date_9, @form_title_9,
                  @form_name_10, @form_date_10, @form_title_10, @form_name_11, @form_date_11, @form_title_11]
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 2
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