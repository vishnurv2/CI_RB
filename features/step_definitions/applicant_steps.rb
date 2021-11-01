# frozen_string_literal: true

When(/^I add another applicant$/) do
  @added_applicant = data_for('additional_applicant')
  on_current_page do |page|
    page.applicants_panel.add_applicant
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
    modal.save_and_close
  end
end

When(/^I add another auto applicant$/) do
  @added_applicant = data_for('additional_applicant')
  on(AutoPolicySummaryPage) do |page|
    page.applicants_panel.add_policy_applicant
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
    modal.save_and_close
  end
end

When(/^I try to add an applicant with a partial address$/) do
  @added_applicant = data_for('applicant')
  on_current_page do |page|
    page.applicants_panel.add_applicant
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
    #modal.save_changes_button
  end
end

When(/^I try by adding an applicant with a partial address$/) do
  @added_applicant = data_for('applicant')
  on(AccountSummaryPage) do |page|
    page.applicants_panel.add_applicant
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
    #modal.save_changes_button
  end
end

When(/^I add a blank applicant$/) do
  on(AccountSummaryPage) do |page|
    page.applicants_panel.add_applicant
    #page.add_applicant_modal.existing_party = "Add Party"
    page.add_applicant_modal.address_index = "New Address"
    page.add_applicant_modal.save
  end
end

When(/^I add a blank auto applicant$/) do
  on(AutoPolicySummaryPage) do |page|
    page.applicants_panel.add_policy_applicant
    # page.add_applicant_modal.existing_party = "New Party"
    # page.add_applicant_modal.address_index = "New Address"
    page.add_applicant_modal.save_changes
  end
end

Then(/^the delete option should not be available for the applicant in the applicant grid$/) do
  on(AccountSummaryPage) do |page|
    found_applicant = page.applicants_panel.applicants.last
    expect(found_applicant.delete_button?).to be_truthy, 'the delete button for the last applicant was not present'
    #disabled attribute is found in the parent
    expect(found_applicant.delete_button_element.parent.attribute('class').include?('disabled')).to be_truthy, 'the delete button for the last applicant was not disabled'
  end
end

Given(/^I have an existing account with more than one applicant$/) do
  @added_applicant = RouteHelper.add_applicant_to_existing
end

When(/^I try to delete the applicant I added$/) do
  on(AccountSummaryPage) do |page|
    @found_applicant = page.applicants_panel.reverse_find_applicant_by_name_stripped(@added_applicant)
    raise "Could not find #{@added_applicant.applicant_full_name} in the applicants grid." unless @found_applicant

    @found_applicant.delete_button
  end
end

Then(/^I should see a prompt asking me if I'm sure I want to remove the applicant$/) do
  on(AccountSummaryPage) do |page|
    # use instance var from "I try to delete the applicant I added" - Applicant is hidden by delete row
    #found_applicant = page.applicants_panel.reverse_find_applicant_by_name(@added_applicant)

    Watir::Wait.until(timeout: 3, message: "Expected to see a confirm delete button on the applicant panel, but it couldn't be found") { page.applicants_panel.confirm_delete? }
  end
end

When(/^I answer (.*) to the remove applicant prompt$/) do |which|
  on(AccountSummaryPage) do |page|
    #found_applicant = page.applicants_panel.reverse_find_applicant_by_name(@added_applicant)
    @found_applicant.delete_button if @found_applicant.delete_button?
    sleep (2) #Added sleep since it was not clicking delete_yes
    page.applicants_panel.send("delete_#{which}")
    begin
      Watir::Wait.while { f = page.applicants_panel.reverse_find_applicant_by_name(@added_applicant); !f.nil? && f.present? } if which == 'yes'
    rescue
    end
  end
end

Then(/^I verify warning message, links to product summary and edit link for driver modal$/) do
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    expect(modal.warning_message).to eq('This role is view only. To edit or remove a driver, please go to the corresponding product.')
    expect(modal.auto_product_link_element.present?).to eq(true)
    expect(modal.watercraft_product_link_element.present?).to eq(true)
    modal.edit_element.click
    page.wait_for_ajax
    expect(page.auto_driver_modal.present?).to eq(true)
    page.auto_driver_modal.save_and_close
    page.wait_for_ajax
    page.applicants_panel.applicants.first.edit_element.click
    page.wait_for_ajax
    modal.driver_tab_element.click
    page.wait_for_ajax
    modal.auto_product_link_element.click
    page.wait_for_ajax
    expect(page.url.include?("/PL/auto/")).to eq(true)
    page.applicants_panel.applicants.first.edit_element.click
    page.wait_for_ajax
    modal.driver_tab_element.click
    page.wait_for_ajax
    modal.watercraft_product_link_element.click
    expect(page.url.include?("/PL/watercraft/")).to eq(true)
  end
end


Then(/^the expected applicant data should appear in the modal from the "([^"]*)" page$/) do |page_name|
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"

    if page_name == "Account Overview"
      opt = "Account Overview"
      unless page.page_header_text.include? "Account Summary"
        page.left_nav.navigate_to(opt)
      end
      # page.left_navigate_to_if_not_on(opt)
    end
    #opt = "IN - Auto" if page_name == "Auto Policy Summary"
    #page.left_navigate_to_if_not_on(opt)
  end
  on(page_name.to_page_class) do |page|
    first_applicant = page.applicants_panel.applicants.first
    first_applicant.edit
    page.wait_for_processing_overlay_to_close
    modal = page.add_applicant_modal
    modal.address_index = 1

    RSpec.capture_assertions do
      expected_applicant = @account_party['partyName']
      expect(modal.name_prefix.downcase).to eq(expected_applicant['titlePrefix'].downcase), "Applicant Modal: Expected the prefix to equal #{expected_applicant['name_prefix']}, but it was #{modal.name_prefix}"
      expect(modal.first_name.downcase).to eq(expected_applicant['givenName'].downcase), "Applicant Modal: Expected the first name to equal #{expected_applicant['first_name']}, but it was #{modal.first_name}"
      expect(modal.last_name.downcase).to eq(expected_applicant['surname'].downcase), "Applicant Modal: Expected the middle name to equal #{expected_applicant['middle_name']}, but it was #{modal.middle_name}"
      expect(modal.name_suffix.downcase).to eq(expected_applicant['nameSuffix'].downcase), "Applicant Modal: Expected the suffix to equal #{expected_applicant['name_suffix']}, but it was #{modal.name_suffix}"
      expect(modal.nickname.downcase).to eq(expected_applicant['nickName'].downcase), "Applicant Modal: Expected the nick name to equal #{expected_applicant['nickname']}, but it was #{modal.nickname}"
      expect(modal.date_of_birth_element.value).to eq(@account_party['birthDt']), "Applicant Modal: Expected the date of birth to be #{expected_applicant['date_of_birth']}, but it was #{modal.date_of_birth_element.text}"
      expect(modal.marital_status.text.downcase).to eq(@account_party['maritalStatus'].downcase), "Applicant Modal: Expected the marital status to be #{@account_party['maritalStatus']}, but it was #{modal.marital_status.text}"
      expect(modal.party_gender_element.span.text.downcase).to eq(@account_party['gender'].downcase), "Applicant Modal: Expected the gender to be #{expected_applicant['gender']}, but it was #{modal.party_gender_element.span.text}"
      emails = @account_party['emails'].map(&:downcase)
      modal_emails = modal.emails.map(&:downcase)
      emails.each { |email| expect(modal_emails.include?(email)).to be_truthy, "Applicant Modal: Expected to find #{email} as an email, but the emails found were: #{modal_emails}" }
      phones = @account_party['phones'].map { |p| p['phoneNumber'] = p['phoneNumber'].tr('^0-9', ''); p }
      modal_phones = modal.phone_nums.map { |p| { 'type' => p.type.text, 'number' => p.number.tr('^0-9', '') } }
      phones.each { |phone| expect(modal_phones.any? { |p| p['type'].downcase == phone['phoneTypeCode'].downcase && p['number'] == phone['phoneNumber'] }).to be_truthy, "Applicant Modal: Expected to find #{phone} as a phone, but the phones found were: #{modal_phones}" }
      expected_address = "#{@account_party['address']['addr1']}, #{@account_party['address']['city']}, #{@account_party['address']['state']} #{@account_party['address']['postalCode']}"
      expect(modal.address_index.text).to eq(expected_address), "Applicant Modal: Expected the address to equal #{expected_address}, but it was #{modal.address_index.text}"
    end
  end
end

When(/^I edit the first applicant$/) do
  on(AccountSummaryPage) do |page|
    page.wait_for_ajax
    first_applicant = page.applicants_panel.applicants.first
    first_applicant.edit
    page.wait_for_modal_or_error
    modal = page.add_applicant_modal
    @edited_applicant_email = "abc#{Time.now.to_s.tr('^0-9', '')}@mail.com"
    modal.email_addresses.first.address_element.set(@edited_applicant_email)
    modal.save_and_close
  end
end

And(/^I delete all account applicants but one$/) do
  on(AccountSummaryPage).applicants_panel.delete_all_but_one
end

And(/^I delete all account applicants but one from the "([^"]*)" page$/) do |page_name|
  on(page_name.to_page_class).applicants_panel.delete_all_but_one
end

When(/^I edit the first applicant from the "([^"]*)" page$/) do |page_name|
  on(page_name.to_page_class) do |page|
    page.wait_for_ajax
    first_applicant = page.applicants_panel.applicants.first
    first_applicant.edit
    page.wait_for_modal_or_error
    modal = page.add_applicant_modal
    @edited_applicant_email = "abc#{Time.now.to_s.tr('^0-9', '')}@mail.com"
    modal.email_addresses.first.address_element.set(@edited_applicant_email)
    modal.save_and_close
    page.wait_for_ajax
  end
end

Then(/^the applicant should have changed from the "([^"]*)" page$/) do |page_name|
  on(page_name.to_page_class) do |page|
    all_emails = page.applicants_panel.applicants.map(&:email)
    expect(all_emails.any? { |e| e.downcase == @edited_applicant_email.downcase }).to be_truthy, "Account Summary Page: Expected to find an applicant with an email of #{@edited_applicant_email}, but it could not be found among the emails found: #{all_emails}"
  end
end

And(/^I've started adding an applicant that is a (Non-Person Entity|Person)$/) do |_type|
  on(AccountSummaryPage).applicants_panel.add_applicant
  #on(AccountSummaryPage).add_applicant_modal.existing_party = "Add Party"
end

When(/^I select view (more|less) on the applicant panel$/) do |which|
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    modal.send("view_#{which}")
  end
end

Then(/^I (should|should not) see additional applicant fields$/) do |which|
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    method = which == 'should' ? 'showing_more_fields?' : 'showing_less_fields?'
    expect(modal.send(method)).to eq(true)
  end
end

And(/^I add first applicant using the (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @first_applicant = data_for('first_applicant')
  on_current_page do |page|
    modal = page.new_personal_account_modal
    modal.populate_with(@first_applicant)
    page.wait_for_processing_overlay_to_close

    #address scrubbing is called in address_details= used by fixture
    #modal.address_scrubber_alert.scroll.to
    #modal.user_entered_element.preceding_sibling.click
  end
end

And(/^I add first applicant using applicant data cache$/) do
  on_current_page do |page|
    modal = page.new_personal_account_modal
    modal.populate_with(@first_applicant)
    page.wait_for_processing_overlay_to_close

    #address scrubbing is called in address_details= used by fixture
    #modal.address_scrubber_alert.scroll.to
    #modal.user_entered_element.preceding_sibling.click
  end
end

# ------ Everything below this line is unverified ------------------------------------- #

When(/^I add multiple applicants$/) do
  on_current_page do |page|
    page.populate
    page.save_and_continue
  end
end

Then(/^the applicant should (remain in the list|be removed)$/) do |which|
  on(AccountSummaryPage) do |page|
    found_applicant = page.applicants_panel.reverse_find_applicant_by_name_stripped(@added_applicant)
    removed = (which == 'be removed')
    not_str = removed ? '' : ' not'
    expect(found_applicant.nil?).to eq(removed), "Expected the applicant #{@added_applicant['first_name']} #{@added_applicant['last_name']}#{not_str} to be removed from the grid, but it was#{not_str} found"
  end
end

When(/^I edit the last applicant$/) do
  @modified_applicant = @added_applicant.dup.except!('existing_party') #Exclude existing party from fixture - breaks automation!
  %w[first_name last_name].each { |n| @modified_applicant[n] = "mod#{@modified_applicant[n]}" }
  on(AccountSummaryPage) do |page|
    found_applicant = page.applicants_panel.reverse_find_applicant_by_name_stripped(@added_applicant)
    raise "Could not find #{@added_applicant.applicant_full_name} in the applicants grid." unless found_applicant
    found_applicant.edit
    page.wait_for_ajax
    modal = page.add_applicant_modal
    modal.edit_wrench_element.scroll.to
    modal.edit_wrench #activate the address box
    modal.populate_with(@modified_applicant)
    modal.save_and_close
  end
end

Then(/^the applicant data should be updated in the applicant grid$/) do
  on(AccountSummaryPage) do |page|
    page.wait_for_ajax
    found_applicant = page.applicants_panel.reverse_find_applicant_by_name_stripped(@modified_applicant)
    expect(found_applicant.nil?).to be_falsey, 'Modifications to applicant not saved'
    begin
      found_applicant.delete
    rescue Exception => ex
      STDERR.puts "Warning: Exception '#{ex.message}' thrown while cleaning up added applicant"
    end
  end
end

Then(/^I should see the following errors on the page$/) do |table|
  on(PolicyManagementPage) do |page|
    expected = table.raw.flatten
    RSpec.capture_assertions do
      expected.each do |message|
        found = page.field_validation_errors.include? message.downcase
        expect(found).to be_truthy, "Expected to find \"#{message}\" validation error on the page/modal!"
      end
    end
  end
end

Then(/^The driver from the data for "([^"]*)" should appear in the add applicant dropdown$/) do |expected_driver|
  hashes = expected_driver.split('/')
  driver = data_for(hashes.first.snakecase)
  hashes.shift
  hashes.each { |hash_name| driver = driver[hash_name.snakecase] }
  expect(on(PolicyManagementPage).add_applicant_modal.existing_parties_include?([driver['first_name'], driver['last_name']])).to be_truthy, "Expected the driver drop down on the add applicant modal to contain a name containing #{[driver['first_name'], driver['last_name']]}, but it could not be found"
end

When(/^I add another applicant from the auto summary page$/) do
  @added_applicant = data_for('additional_applicant')
  on(AutoPolicySummaryPage) do |page|
    page.applicants_panel.add_policy_applicant
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
    modal.save_and_close
  end
  on(ReportsPage) do |page|
    if page.premium_change_modal?
      page.premium_change_modal.close
      page.wait_for_overlay_no_ajax_wait
    end
  end
end

When(/^I add another applicant from the account summary page$/) do
  @added_applicant = data_for('additional_applicant')
  on(AutoPolicySummaryPage) do |page|
    page.account_summary_applicants_panel.add_applicant
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
    modal.save_and_close
  end
  on(ReportsPage) do |page|
    if page.premium_change_modal?
      page.premium_change_modal.close
      page.wait_for_overlay_no_ajax_wait
    end
  end
end

And(/^I edit the first applicant using the data from "([^"]*)"$/) do |arg|
  on(AutoPolicySummaryPage) do |page|
    page.applicants.first.edit
    Helpers::Fixtures.load_fixture(arg)
    page.add_applicant_modal.populate
    page.add_applicant_modal.save_and_close
    page.wait_for_modal_masker
  end
end

Then(/^I shouldn't be able to delete the only applicant on the (account|auto policy) summary page$/) do |page_name|
  page_class = Object.const_get("#{page_name} summary page".camelcase(:upper))
  on(page_class) do |page|
    applicants = page.applicants_panel.applicants
    # No longer relevant, drivers now appear in the summary screen.
    #expect(applicants.count).to eq(1), "Account Summary: Expected there to be exactly 1 applicant in the grid, but there were #{applicants.count}, did the existing account get changed?"

    a = page.applicants_panel.applicants.first
    expect(a.delete_button_element.present?).to be_truthy, "Expected the delete button (trash can) on the applicant to be present, but it could not be found"
    RSpec.capture_assertions do
      expect(a.delete_button_element.parent.attributes[:disabled] == '').to be_truthy, "Expected the link containing the trashcan button on the applicant to have a class of 'disabled' but it did not:\r\n#{a.delete_button_element.parent.html}\r\n"

      #Removed this, the hover message is not a parent of the element anymore and appears a tooltip in the bottom of the html document.
      #expect(a.delete_button_element.parent.parent.attributes[:title].include? 'last applicant').to be_truthy, "Expected the trashcan hover message to include the text 'last applicant' but it could not be found:\r\n#{a.delete_button_element.parent.html}\r\n"
    end
  end
end

Then(/^I select (existing|new) account$/) do |which|
  on_current_page do |page|
    case which.downcase
    when "existing"
      page.existing_client_modal.select_existing_account
    when "new"
      page.existing_client_modal.add_as_new
    else
      return
    end
  end
end

And(/^I validate that add applicant modal is getting displayed$/) do
  on_current_page do |page|
    expect(page.add_applicant_modal.present?).to be_truthy, "Add applicant modal is not displayed"
  end
end

Then(/^I click on name of the policy applicant$/) do
  on_current_page do |page|
    page.applicant_name
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I click on name of the account applicant$/) do
  on_current_page do |page|
    page.applicants_panel.applicants.first.edit # just click the edit!
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I click on the name of the account applicant$/) do
  on(AccountSummaryPage) do |page|
    page.applicants_panel.applicants.first.edit # just click the edit!
    page.wait_for_processing_overlay_to_close
  end
end

And(/^the account summary should have an applicant$/) do
  on(AccountSummaryPage) do |page|
    data_used = EDSL::PageObject.fixture_cache['new_personal_account_modal']
    first_applicant = page.applicants_panel.applicants.first

    expect(page.applicants_panel.applicants.count).to be > 0
    expect(data_used.applicant_full_name.upcase).to eq(first_applicant.name_element.a.text), "Expected entered name to display in the applicants panel"
    # data mismatch with commas and extra spaces, striping them out
    expect(data_used.applicant_display_address_comma.upcase.gsub(',', '')).to eq(first_applicant.name_element.span(class: /report-name/).text), "Expected entered address to display in the applicants panel"
    expect(data_used['email']).to eq(first_applicant.email), "Expected entered address to display in the applicants panel"
  end
end

Then(/^the property information I entered should be displayed in the property information panel$/) do
  on(AccountSummaryPage) do |page|
    data_used = EDSL::PageObject.fixture_cache['property_info_modal']
    address1 = EDSL::PageObject.fixture_cache['new_personal_account_modal'].property_display_address_comma_with_county
    add = EDSL::PageObject.fixture_cache['new_personal_account_modal']['address_details']
    address = "#{add['address_line_1']}, #{add['city']}, #{add['county']}, #{add['state'][0..1]}, #{add['zip_code']}".upcase
    panel = page.property_info_panel

    actual_address = panel.address.split.join(" ").gsub(',', '').downcase
    expected_address_info = [address.gsub(',', '').downcase, address1.gsub(',', '').downcase]
    RSpec.capture_assertions do
      expect((actual_address == expected_address_info[0]) || (actual_address == expected_address_info[1])).to be_truthy, "Expected the address in the property information panel to contain an address similar to \"#{expected_address_info[0]}\" or \"#{expected_address_info[1]}\", but it was \"#{actual_address}\""
      expect(panel.year_built).to eq(data_used['year_built']), "Expected year built entered to display on the Property Information panel, but got #{panel.year_built}."
      expect(panel.construction).to eq(data_used['construction_type']), "Expected construction type entered to display on the Property Information panel, but got #{panel.construction}."
      expect(panel.dwelling_use).to eq(data_used['premise_use']), "Expected dwelling/primary use entered to display on the Property Information panel, but got #{panel.dwelling_use}."
      expect(panel.form_type).to eq(data_used['form_type']), "Expected form type entered to display on the Property Information panel, but got #{panel.form_type}."
    end
  end
end

And(/^I select party type as "([^"]*)" and role as "([^"]*)" and add new party details$/) do |party_type, role|
  if party_type == 'Individual'
    @added_applicant = data_for('additional_party')
    @added_applicant['first_name'] = DataMagic.first_name
    @added_applicant['last_name'] = DataMagic.last_name
  else
    @added_applicant = data_for('additional_applicant')
    @added_applicant['organization_name'] = DataMagic.user_name
  end


  on(AccountSummaryPage) do |page|
    on(PolicyManagementPage).wait_for_ajax
    page.applicants_panel.add_party_details(party_type, role)
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
  end
end

And(/^I select party type as "([^"]*)" and role as "([^"]*)" and add new party details only one required left$/) do |party_type, role|
  if party_type == 'Individual'
    @added_applicant = data_for('additional_party')
  else
    @added_applicant = data_for('additional_applicant')
  end
  on(AccountSummaryPage) do |page|
    on(PolicyManagementPage).wait_for_ajax
    page.applicants_panel.add_party_details(party_type, role)
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
  end
end

And(/^I select party type as "([^"]*)" and role as "([^"]*)" and add new party details after navigating from Thank you modal$/) do |party_type, role|
  if party_type == 'Individual'
    @added_applicant = data_for('additional_party')
  else
    @added_applicant = data_for('additional_applicant')
  end
  on(AccountSummaryPage) do |page|
    #page.add_party_details_from_Thankyou_Modal(party_type, role)
    page.add_party_details_from_Message_Card(party_type, role)
    modal = page.add_applicant_modal
    modal.populate_with(@added_applicant)
  end
end

Then(/^I validate "([^"]*)" role details and "([^"]*)" the modal$/) do |role, which|
  on_current_page do |page|
    modal = page.add_applicant_modal
    count = modal.products_display_name.count
    modal.products_display_name[count-2].product_checkbox = true
    modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
    expect(modal.tabs.text.downcase).to eq(role.downcase)
    modal.send("#{which.snakecase}")
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I validate "([^"]*)" role details and "([^"]*)" the modal for auto$/) do |role, which|
  on_current_page do |page|
    modal = page.add_applicant_modal
    modal.products_display_name.last.product_checkbox = true
    modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
    expect(modal.tabs.text.downcase).to eq(role.downcase)
    modal.send("#{which.snakecase}")
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I validate Trustee role details and "([^"]*)" the modal$/) do |which|
  on_current_page do |page|
    modal = page.add_applicant_modal
    #modal.products_display_name.last.product_checkbox = true
    #modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
    #expect(modal.tabs.text.downcase).to eq(role.downcase)
    modal.send("#{which.snakecase}")
  end
end

Then(/^I add another role "([^"]*)"$/) do |role|
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    count = modal.products_display_name.count
    modal.products_display_name[count-2].product_checkbox = true
    # modal.products_display_name.last.product_checkbox = true
    modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
    modal.add_role
    modal.send("#{role.snakecase}")
    page.wait_for_processing_overlay_to_close
    modal.products_display_name.last.product_checkbox = true
  end
end

Then(/^I add another role "([^"]*)" for auto$/) do |role|
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    modal.products_display_name.last.product_checkbox = true
    # modal.products_display_name.last.product_checkbox = true
    modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
    modal.add_role
    modal.send("#{role.snakecase}")
    page.wait_for_processing_overlay_to_close
    modal.products_display_name.last.product_checkbox = true
  end
end

And(/^I delete the added role$/) do
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    modal.delete_role
    if modal.message_error?
      modal.delete_role
      page.wait_for_processing_overlay_to_close
    end
    modal.save_and_close
  end
end

Then(/^I validate that the product is disabled which was already selected$/) do
  on_current_page do |page|
    modal = page.add_applicant_modal
    expect(modal.products_display_name.last.product_checkbox.disabled?).to be_truthy
  end
end

Then(/^I select all the products and "([^"]*)" the modal$/) do |which|
  on_current_page do |page|
    modal = page.add_applicant_modal
    modal.products_display_name.each do |product|
      product.product_checkbox = true
    end
    modal.send("#{which.snakecase}")
  end
end

Then(/^I validate that there are no vehicles to choose$/) do
  on_current_page do |page|
    modal = page.add_applicant_modal
    expect(modal.products_display_name.count == 0).to be_truthy
  end
end

And(/^I click on plus on party model and "([^"]*)" is not present there$/) do |opt|
  on(AccountSummaryPage) do |page|
    page.applicants_panel.add_party_details_dropdown_assertion
    element = page.applicants_panel.link_accounts_menu_element.span(class: 'ui-menuitem-text')
    expect(element.text).to eq(opt)
  end
end

And(/^I click on plus on party model "([^"]*)" and "([^"]*)" should present there$/) do |arg1, arg2|
  on(AccountSummaryPage) do |page|
    page.applicants_panel.add_party_details_dropdown_assertion
    element = page.applicants_panel.link_accounts_menu_element.span(class: 'p-menuitem-text')
    expect(element.text).to eq(arg2)
    element = page.applicants_panel.add_party_menu_without_click_element.span(class: 'p-menuitem-text')
    expect(element.text).to eq(arg1)
  end
end


But(/^I checked Add Applicants should not be present$/) do
  on(AccountSummaryPage) do |page|
    found_applicant_option = page.applicants_panel
    expect(found_applicant_option.add_applicant_menu_without_click?).to be_falsey, 'the Add applicant option is not present'
  end
end


Then(/^I delete and validate the deleted party from applicant modal$/) do
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    modal.delete_party
    modal.confirm_delete_role
    page.wait_for_processing_overlay_to_close
    applicant_deleted = page.applicants_panel.applicants.find { |i| i.name.downcase.include? @added_applicant['organization_name'].downcase }
    page.wait_for_processing_overlay_to_close
    expect(applicant_deleted).nil?
  end
end

Then(/^I select only Products from role applies to$/) do
  on_current_page do |page|
    modal = page.add_applicant_modal
    modal.products_display_name.first.product_checkbox = false
    modal.products_display_name.last.product_checkbox = true
    modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
  end
end

Then(/^I should see (.*) under the Contact role$/) do |first_contact_description|
  on_current_page do |page|
    modal = page.add_applicant_modal
    expect(modal.content_element.b.text).to eq(first_contact_description)
  end
end

Then(/^I should see (.*) under the Contact role in next line$/) do |second_contact_description|
  on_current_page do |page|
    modal = page.add_applicant_modal
    expect(modal.content_element.i.text).to eq(second_contact_description)
  end
end

And(/^I validate "([^"]*)" role details and both role applies options "([^"]*)" the modal$/) do |role, which|
  on_current_page do |page|
    modal = page.add_applicant_modal
    modal.products_display_name.first.product_checkbox = true
    modal.products_display_name.last.product_checkbox = true
    modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
    expect(modal.tabs.text.downcase).to eq(role.downcase)
    modal.send("#{which.snakecase}")
  end
end

Then(/^I select only Account level from role applies to$/) do
  on_current_page do |page|
    modal = page.add_applicant_modal
    modal.products_display_name.first.product_checkbox = true
    modal.products_display_name.last.product_checkbox = false
  end
end

Then(/^I validate "([^"]*)" role details and try to click "([^"]*)" and "([^"]*)" warning appears$/) do |role, which, warning_message|
  on_current_page do |page|
    modal = page.add_applicant_modal
    modal.products_display_name.last.product_checkbox = true
    modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
    expect(modal.tabs.text.downcase).to eq(role.downcase)
    modal.send("#{which.snakecase}")
    expect(modal.first_name_warning_element.text).to eq(warning_message)
  end
end


And(/^I validate the columns in parties modal$/) do
  on(AccountSummaryPage) do |page|
    modal = page.applicants_panel
    expect(modal.name_header_element.text).to eq("Name")
    expect(modal.role_header_element.text).to eq("Role(s)")
    expect(modal.email_header_element.text).to eq("Email")
    expect(modal.phone_header_element.text).to eq("Phone")
    expect(modal.account_owner_header_element.text).to eq("Account Owner")

  end
end

And(/^I select party type as "([^"]*)" and validate hover over message$/) do |party_type|
  on(AccountSummaryPage) do |page|
    page.applicants_panel.add_party_details_driver_trustee(party_type)
    modal = page.applicants_panel.add_party_modal
    expect(page.div(class: /p-dropdown-items-wrapper/).div(id: 'DriverRoleOption').div.click!).to be_falsey
    expect(page.div(class: /p-dropdown-items-wrapper/).div(id: 'TrusteeRoleOption').div.click!).to be_falsey
  end
end

And(/^I close the add party modal and return to account summary page$/) do
  on(AccountSummaryPage) do |page|
    modal=page.applicants_panel.add_party_modal
    modal.close_button_element.double_click
  end
end

Then(/^I try to choose the vehicle under role applies to and validate hover over message$/) do
  on(AccountSummaryPage) do |page|
    modal = page.applicants_panel.add_applicant_modal
    modal.products_display_name.last.product_checkbox_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("Lessor already applies to this vehicle")
  end
end


Then(/^I add another role "([^"]*)" and "([^"]*)" the modal$/) do |role, which|
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    modal.add_role
    modal.send("#{role.snakecase}")
    page.wait_for_processing_overlay_to_close
    modal.products_display_name.first.product_checkbox = true
    modal.products_display_name.last.product_checkbox = true
    modal.products_display_name.last.description = "NA" if modal.products_display_name.last.description_element.present?
    modal.send("#{which.snakecase}")
  end
end


And(/^I click on delete party button and verify the red bar$/) do
  on(AccountSummaryPage) do |page|
    page.applicants_panel.applicants.first.delete_button
    expect(page.applicants_panel.applicants.first.delete_confirmation_message?).to be_truthy
  end
end

Then(/^I click on delete button from red bar$/) do
  on(AccountSummaryPage) do |page|
    page.applicants_panel.delete_yes
  end
end

And(/^I validate the delete button should be disabled for Prefill Driver not added on Account Overview$/) do
  on(AccountSummaryPage) do |page|
    delete_button = page.applicants_panel.applicants.last.delete_button_element
    expect(delete_button.click!).to be_falsey
  end
end

Then(/^I click on cancel button from red bar$/) do
  on(AccountSummaryPage) do |page|
    page.applicants_panel.delete_no
  end
end

And(/^I validate the roles "([^"]*)" are present$/) do |roles|
  on(AccountSummaryPage) do |page|
    found_role = page.applicants_panel.applicants.first.roles_element.text
    expect(found_role).to eq(roles)
  end
end

And(/^I select party type as "([^"]*)" and role as "([^"]*)"$/) do |party_type, role|
  on(AccountSummaryPage) do |page|
    on(PolicyManagementPage).wait_for_ajax
    page.applicants_panel.add_party_details(party_type, role)
  end
end


And(/^I add first applicant using the "([^"]*)" fixture to fill Personal Account Modal$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  #RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @first_applicant = data_for('first_applicant')
  on_current_page do |page|
    modal = page.new_personal_account_modal
    modal.populate_with(@first_applicant)
    page.wait_for_processing_overlay_to_close

    #address scrubbing is called in address_details= used by fixture
    #modal.address_scrubber_alert.scroll.to
    #modal.user_entered_element.preceding_sibling.click
  end
end

And(/^I have populated the trailer info modal with "([^"]*)" fixture$/) do |fixture_file|
  Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  @trailer_info = data_for('trailer_information_modal')
  on_current_page do |page|
    modal = page.trailer_information_modal
    modal.populate_with(@trailer_info)
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I update wrong email on personal account modal$/) do
  on_current_page do |page|
    modal = page.new_personal_account_modal
    modal.email = 'abcd'
  end
end
