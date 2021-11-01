# This file is used to contain the Binder PDF steps validation


Then(/^I gather additional data for "([^"]*)"$/) do |auto_type|
  # on(PolicyManagementPage).left_navigate_to_if_not_on(auto_type)
  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
  end
  @quote_Premium = on(AutoPolicySummaryPage).quote_premium
  @quote_Number = on(AutoPolicySummaryPage).quote_number
  @vin = @doc.xpath('.//Description').text.split('\n')[2]
  @agreed_value = @doc.xpath('.//Description').text.split('\n')[3]
  @cost_new = @doc.xpath('.//Description').text.split('\n')[4]
  @ico_cm_performance = @doc.xpath('.//Description').text.split('\n')[5]
  @territory = @doc.xpath('.//Description').text.split('\n')[6].strip
end

Then(/^I validate the PDF$/) do
  ## Data from automation
  data_used = EDSL::PageObject.fixture_cache

  # binding.pry
  my_pdf = @document_location

  # Its possible we may need to go to account summary page, or policy page to get data as well. sometimes thing change After
  # the fact, like the VIN
  expected_name = data_used['new_personal_account_modal'].applicant_name.upcase
  expected_addr = data_used['new_personal_account_modal']['address_details']['address_line_1']
  expected_city = data_used['new_personal_account_modal']['address_details']['city']
  expected_email = data_used['new_personal_account_modal']['email']
  expected_dob = "Date of Birth: #{data_used['new_personal_account_modal']['date_of_birth']}"
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']
  expected_state = data_used['new_personal_account_modal']['address_details']['state']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_email,
                 expected_dob, expected_agent_name, expected_state, expected_vehicle_modal,
                 @effective_date, @expiration_date,
                 @vin, @agreed_value, @cost_new, @ico_cm_performance, @territory]
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

Then(/^I gather additional data for "([^"]*)" quote for uim$/) do |auto_type|

  #  on(PolicyManagementPage).left_navigate_to_if_not_on(auto_type)
  on(AutoPolicySummaryPage) do |page|
    modal = page.general_info_panel
    @effective_date = modal.effective_date
    @expiration_date = modal.expiration_date
  end
  @quote_Premium = on(AutoPolicySummaryPage).quote_premium
  @quote_Number = on(AutoPolicySummaryPage).quote_number
  @vin = @doc.xpath('.//Description').text.split('\n')[2]
  @agreed_value = @doc.xpath('.//Description').text.split('\n')[3]
  @cost_new = @doc.xpath('.//Description').text.split('\n')[4]
  @ico_cm_performance = @doc.xpath('.//Description').text.split('\n')[5]
  @territory = @doc.xpath('.//Description').text.split('\n')[6].strip
  #@class = @doc.xpath('.//Description').text.split('\n')[3]
  #@driver_name = @doc.xpath('.//Description').text.split('\n')[7]
  #@bussiness_use = @doc.xpath('.//Description').text.split('\n')[8]
  #@combined_single_limit = @doc.xpath('.//Description').text.split('\n')[10].remove("\n").strip
  #@medical_payments =  @doc.xpath('.//Description').text.split('\n')[11]
  #@uninsured_motorist_limit = @doc.xpath('.//Description').text.split('\n')[12].split('$')[0].strip
  #@other_collisions = @doc.xpath('.//Description').text.split('\n')[13]
  #@collision_deductables = @doc.xpath('.//Description').text.split('\n')[14]
  #@agreed_value_coverage = @doc.xpath('.//Description').text.split('\n')[15].remove("\n").strip

end

Then(/^I validate the PDF for UIM$/) do

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
  expected_email = data_used['new_personal_account_modal']['email']
  expected_dob = "Date of Birth: #{data_used['new_personal_account_modal']['date_of_birth']}"
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']
  expected_state = data_used['new_personal_account_modal']['address_details']['state']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal


  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_name, expected_addr, expected_city, expected_email, expected_dob, expected_agent_name,
                 expected_phone, expected_state, expected_vehicle_modal,
                 @effective_date, @expiration_date, @vin, @agreed_value, @cost_new, @ico_cm_performance, @territory]
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