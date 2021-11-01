#  This file is containing the steps for the Quote PDF Validation

Then(/^I gather additional data for "([^"]*)" quote$/) do |auto_type|
  #on(PolicyManagementPage).left_navigate_to_if_not_on(auto_type)
  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
  end
  @quote_Premium = on(AutoPolicySummaryPage).quote_premium
  @quote_Number = on(AutoPolicySummaryPage).quote_number
  @vin = @doc.xpath('.//Description').text.split('\n')[2]
  @agreed_value = @doc.xpath('.//Description').text.split('\n')[4]
  @cost_new = @doc.xpath('.//Description').text.split('\n')[5]
  @ico_cm_performance = @doc.xpath('.//Description').text.split('\n')[6].strip
  @territory = @doc.xpath('.//Description').text.split('\n')[9]
end

Then(/^I validate the Quote PDF$/) do

  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  expected_VIN = "VIN: #{data_used["auto_vehicle_modal"]['vehicle_identification_number']}"

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1'].upcase
  expected_city = data_used['new_personal_account_modal']['address_details']['city'].upcase
  expected_email = data_used['new_personal_account_modal']['email']
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_state = data_used['new_personal_account_modal']['address_details']['state']

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|
    arr_first = [expected_name, expected_addr, expected_city, expected_email,
                 expected_agent_name, expected_state,
                 @effective_date, @expiration_date,
                 @vin, @agreed_value, @cost_new, @territory]
    arr_second = []
    reader.pages.each do |page|
      #expect(PDFHelper.match_text(page.text, expected_text)).to eq(expected_text), "Expected to Find #{expected_text} in the Binder Document, but did not!"
      if page.number == 1
        arr_first.each do |str|
          puts str
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

Then(/^I gather additional data for IN - Signature quote$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
  end
  @quote_Premium = on(AutoPolicySummaryPage).quote_premium
  @quote_Number = on(AutoPolicySummaryPage).quote_number
  @vin = @doc.xpath('.//Vehicle').text.split('\n')[2]
  @agreed_value = @doc.xpath('.//Vehicle').text.split('\n')[3]
  @cost_new = @doc.xpath('.//Vehicle').text.split('\n')[4]
  # @symbol_used = @doc.xpath('.//Vehicle').text.split('\n')[5]
  # @ico_cm_performance = @doc.xpath('.//Vehicle').text.split('\n')[6]
  @territory = @doc.xpath('.//Vehicle').text.split('\n')[6]
  #@bussiness_use = @doc.xpath('.//Vehicle').text.split('\n')[9]
  #@territory = @doc.xpath('.//Vehicle').text.split('\n')[10]
  #@combined_single_limit = @doc.xpath('.//Description').text.split('\n')[10].remove("\n").strip
  #@medical_payments =  @doc.xpath('.//Description').text.split('\n')[11]
  #@uninsured_motorist_limit = @doc.xpath('.//Description').text.split('\n')[12]
  #@other_collisions = @doc.xpath('.//Description').text.split('\n')[13]
  #@agreed_value_coverage = @doc.xpath('.//Description').text.split('\n')[14].remove("\n").strip
  #@class = @doc.xpath('.//Vehicle').text.split('\n')[3]
end
