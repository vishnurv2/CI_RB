# this file contain the details of Auto Quote details for validation



Then(/^I validate the Application PDF$/) do

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
  # expected_dob = "Date of Birth: #{data_used['new_personal_account_modal']['date_of_birth']}"
  expected_agent_name = data_used['new_personal_account_modal']['select_agency'].split('(', 2).first
  expected_phone = data_used['new_personal_account_modal']['phone']
  # expected_state = data_used['new_personal_account_modal']['address_details']['state']
  expected_policy_effective_date = data_used['add_product_modal']['policy_effective_date']
  expected_vehicle_modal = data_used['auto_vehicle_modal'].vehicle_modal
  expected_driver_name = data_used['auto_driver_modal'].driver_name.upcase
  expected_driver_gender = "SEX: #{data_used['auto_driver_modal']['gender']}"
  expected_driver_dob = "DATE OF BIRTH: #{data_used['auto_driver_modal']['date_of_birth']}"
  expected_driver_martial_status = "MARITAL STATUS: #{data_used['auto_driver_modal']['marital_status']}"
  expected_driver_license_number = "PERMIT/LICENSE #: #{data_used['auto_driver_modal']['license_number']}"
  expected_relation_to_applicant = "RELATION TO APPLICANT: #{data_used['auto_driver_modal']['relationship_to_applicant']}"

  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [expected_VIN, expected_name, expected_addr, expected_city,
                 expected_email, expected_agent_name, expected_phone,
                 expected_vehicle_modal, expected_driver_name, expected_driver_gender, expected_driver_dob,
                 expected_driver_martial_status, expected_driver_license_number,
                 @effective_date, @expiration_date, @vin, @agreed_value, @cost_new, @ico_cm_performance, @territory]
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

Then(/^I gather additional data for "([^"]*)" application$/) do |auto_type|
  #on(PolicyManagementPage).left_navigate_to_if_not_on(auto_type)
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
  @territory = @doc.xpath('.//Description').text.split('\n')[6].remove("\n").strip
end

