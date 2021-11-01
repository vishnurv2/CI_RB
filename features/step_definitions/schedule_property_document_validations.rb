Then(/^I gather additional data for schedule property policy Quote PDF$/) do
  #  Collecting the Insured Information using XML
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

Then(/^I validate the quote PDF$/) do
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

    arr_first = [expected_name, expected_addr, expected_city,
                  @insured_name, @insured_city, @insured_state, @insured_zipcode,
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

Then(/^I gather additional data for schedule property policy Binder PDF$/) do
  @insured_name =  @doc.xpath('.//InsuredInformation').css('Name')[1].text
  @insured_city = @doc.xpath('.//InsuredInformation').css('City').text
  @insured_state = @doc.xpath('.//InsuredInformation').css('State').text
  @insured_zipcode = @doc.xpath('.//InsuredInformation').css('ZipCode').text
  @insured_email_address = @doc.xpath('.//InsuredInformation').css('EmailAddress').text
  @annual_premium = @doc.xpath('.//AnnualPremium').text

  # Collecting the Agent Information using XML

  
end

Then(/^I validate the Binder PDF$/) do
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
                 @insured_name, @insured_city, @insured_state, @insured_zipcode,
                 @annual_premium]

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

Then(/^I gather additional data for schedule property policy Application PDF$/) do
  @insured_name =  @doc.xpath('.//InsuredInformation').css('Name')[1].text
  @insured_city = @doc.xpath('.//InsuredInformation').css('City').text
  @insured_state = @doc.xpath('.//InsuredInformation').css('State').text
  @insured_zipcode = @doc.xpath('.//InsuredInformation').css('ZipCode').text
  @insured_email_address = @doc.xpath('.//InsuredInformation').css('EmailAddress').text
  @annual_premium = @doc.xpath('.//AnnualPremium').text
  @quote_number =  @doc.xpath('.//QuoteNumber').text

end

Then(/^I validate the Application PDF for Schedule Property$/) do
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
                 @insured_name, @insured_city, @insured_state, @insured_zipcode,
                 @quote_number, @annual_premium]

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