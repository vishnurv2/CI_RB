

Then(/^I gather additional data for "([^"]*)" reports$/) do |auto_type|
  #on(PolicyManagementPage).left_nav.navigate_to auto_type
  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
  end
  @quote_Premium = on(AutoPolicySummaryPage).quote_premium
  @quote_Number = on(AutoPolicySummaryPage).quote_number
end

Then(/^I validate the Auto Clue Report$/) do
  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_driver_first_name =  data_used['auto_driver_modal']['first_name'].upcase
  expected_driver_last_name = data_used['auto_driver_modal']['last_name'].upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_driver_first_name, expected_driver_last_name, expected_addr, expected_city]
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

Then(/^I validate the Insurance Score Report$/) do
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_first_name = data_used['new_personal_account_modal']['first_name'].upcase
  expected_last_name = data_used['new_personal_account_modal']['last_name'].upcase

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_first_name, expected_last_name]
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

Then(/^I validate the Property Clue Report$/) do
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_first_name = data_used['new_personal_account_modal']['first_name'].upcase
  expected_last_name = data_used['new_personal_account_modal']['last_name'].upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_first_name, expected_last_name, expected_addr, expected_city]
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

Then(/^I validate the MVReport$/) do
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_driver_first_name =  data_used['auto_driver_modal']['first_name'].upcase
  expected_driver_last_name = data_used['auto_driver_modal']['last_name'].upcase


  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_driver_first_name, expected_driver_last_name]
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

Then(/^I validate the AutoDataPrefillReport$/) do
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_driver_first_name =  data_used['auto_driver_modal']['first_name'].upcase
  expected_driver_last_name = data_used['auto_driver_modal']['last_name'].upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase


  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_driver_first_name, expected_driver_last_name, expected_addr, expected_city]
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

Then(/^I validate the VehicleDataReport$/) do
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [@vin, @vehicle_make, @body_style]
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

Then(/^I validate the CreditScoreReport$/) do
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_first_name = data_used['new_personal_account_modal']['first_name'].upcase
  expected_last_name = data_used['new_personal_account_modal']['last_name'].upcase


  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_first_name, expected_last_name]
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

Then(/^I gather additional data for vehicle data reports$/) do
  @vin = @doc.xpath('.//SectionHeader')[0].text
  @vehicle_make = @doc.xpath('.//Value')[0].text
  @body_style = @doc.xpath('.//Value')[1].text
  @engine = @doc.xpath('.//Value')[2].text
  @gross_weight = @doc.xpath('.//Value')[3].text
end