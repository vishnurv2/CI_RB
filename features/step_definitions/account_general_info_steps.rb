# frozen_string_literal: true

Then(/^the expected agency and agency contact should be visible in General Information$/) do
  on(AccountSummaryPage) do |page|
    data = data_for("expected_general_information")
    general_info_panel = page.account_info
    actual_agency = general_info_panel.agency
    actual_contact = general_info_panel.agency_contact_full_name
    RSpec.capture_assertions do
      expect(actual_agency.downcase.include?(data['agency'].downcase)).to be_truthy, "Expected \"#{data['agency']}\" , but found \"#{actual_agency}\"!"
      expect(actual_contact.downcase).to eq(data['agency_contact_full_name'].downcase), "Expected \"#{data['agency_contact_full_name']}\" , but found \"#{actual_contact}\"!"
    end
  end
end

And(/^I modify the account general info$/) do
  on(AccountSummaryPage) do |page|
    page.account_info.modify
    agency_contact = page.account_general_info_modal.agency_contact
    option_elements = agency_contact.option_elements
    expect(option_elements.count > 0).to be_truthy, "Expected there to be options in the agency contact dropdown, but none could be found"
    agency_contact.select((agency_contact.selected_index + 1) % agency_contact.option_elements.count)
    @new_agency_contact = agency_contact.text
    page.account_general_info_modal.underwriter.select(1)
    page.account_general_info_modal.save_changes
  end
end

Then(/^I should see the new account general info$/) do
  actual = on(AccountSummaryPage).account_info.agency_contact_full_name
  expect(actual.snakecase).to eq(@new_agency_contact.snakecase), "Account General Info: Expected the Agnecy Contact to be #{@new_agency_contact}, but it was #{actual}"
end

And(/^I fill the data in "([^"]*)" modal with (.*) fixture file and "([^"]*)" flag using "([^"]*)"$/) do |which, fixture_file, action, pdf_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for("#{which.snakecase}_modal")
  on(PolicyManagementPage) do |page|
    modal = page.send("#{which.snakecase}_modal")
    page.wait_for_ajax
    modal.populate_with(data)
    modal.choose_files

    attach_modal = page.insert_file_modal_domestic_abuse
    attach_modal.upload_new
    attach_modal.wait_for_ajax
    filename = File.join(Dir.pwd, "fixtures/#{pdf_file}.pdf")
    attach_modal.file_to_upload = filename
    Watir::Wait.until { attach_modal.related_to_element.present? }
    page.wait_for_ajax
    attach_modal.insert_button
    page.wait_for_ajax
    #issue - file uploads but attach modal does not go away first time
    attach_modal.insert_button if attach_modal.present?
    # Watir::Wait.until { modal.attached_document_list_element.present? }
    if(action == 'add')
      modal.add_flag
      page.wait_for_ajax
      expect(on(AccountSummaryPage).priority_restrictive_image_element.present?).to be_truthy
      # expect(on(AutoPolicySummaryPage).actions_menu.remove_domestic_abuse_flag.present?).to be_truthy
    elsif action == 'remove'
      modal.remove_flag
      page.wait_for_ajax
      expect(on(AccountSummaryPage).priority_restrictive_image_element.present?).to be_falsey
      #expect(on(AutoPolicySummaryPage).actions_menu.remove_domestic_abuse_flag.present?).to be_falsey
    end
  end
end
