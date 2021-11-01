# frozen_string_literal: true

Then(/^I should see an address scrubber alert with the message "(.*)"/) do |msg|
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    modal.address_details.state.click if modal.address_details.present? && modal.address_details.state.present?
    modal.address_scrubber_alert.scroll.to
    expect(modal.address_scrubber_alert?).to be_truthy, 'Could not find the address scrubber alert.'
    expect(modal.address_scrubber_alert.text.include?(msg)).to be_truthy, "Expected the address scrubber to contain the message \"#{msg}\" but it could not be found"
  end
end

When(/^I select answer the address scrubber alert with "([^"]*)"$/) do |arg|
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    page.add_applicant_modal.address_details.state.click if page.add_applicant_modal.address_details.state.present?
    modal.address_scrubber_alert.scroll.to
    section = modal.address_scrubber_alert
    section.button(text: "#{arg}").click!
  end
end

Then(/^the address scrubber alert should disappear$/) do
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    expect(modal.address_scrubber_alert?).to be_falsey, 'Address scrubber did not go away'
  end
end

Then(/^the address should match what I entered$/) do
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    #modal.address_scrubber_alert.scroll.to
    expect(modal.address_details.address_line_1.upcase).to eq(@added_applicant['address_details_no_scrub']['address_line_1'].upcase)
    expect(modal.address_details.zip_code).to eq(@added_applicant['address_details_no_scrub']['zip_code'])
  end
end

Then(/^the address should be corrected$/) do
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    expect(modal.address_details.address_line_1).to eq(@added_applicant['address_details_no_scrub']['correct_address_line_1'])
    expect(modal.address_details.zip_code).to eq(@added_applicant['address_details_no_scrub']['correct_zip_code'])
  end
end

# ------ Everything below this line is unverified ------------------------------------- #


Then(/^the address (should|should not) be protected$/) do |should_or_not|
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    RSpec.capture_assertions do
      whether_should = should_or_not == 'should'
      binding.pry if Nenv.cuke_debug?
      expect(modal.address_details.address_line_1_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the address line 1 to be read only but it was not.'
      expect(modal.address_details.address_line_2_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the address line 2 to be read only but it was not.'
      #expect(modal.address_details.address_line_3_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the address line 3 to be read only but it was not.'
      expect(modal.address_details.description_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the description to be read only but it was not.  This can be seen by clicking the Description button in the toggle button list with Address and Description.'
      expect(modal.address_details.city_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the city to be read only but it was not.'
      expect(modal.address_details.state_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the state 3 to be read only but it was not.'
      expect(modal.address_details.zip_code_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the first zip code field (5 digits) to be read only but it was not.'
      #expect(modal.address_details.zip4_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the second zip code field (zip 4/4 digits) to be read only but it was not.'
      expect(modal.address_details.county_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the county to be read only but it was not.'
      expect(modal.address_details.country_element.attributes[:readonly] == 'readonly').to eq(whether_should), 'Expected the country to be read only but it was not.'
    end
  end
end
