# frozen_string_literal: true

Then(/^I can show the account ID$/) do
  id = @browser.url.split('/').last
  STDOUT.puts "Policy ID: #{id}"
end

Then(/^the new applicant should be displayed in the general information$/) do
  on(AccountSummaryPage) do |page|
    found_applicant = page.applicants_panel.reverse_find_applicant_by_name_stripped(@added_applicant)
    expect(found_applicant).not_to be_nil, "Could not find #{@added_applicant.applicant_full_name} in the applicants list"
    expect(page.applicants_panel.strip_age_from_name_strip_new_line(found_applicant.name)).to eq(@added_applicant.applicant_age.to_s), "DOB does not match for #{@added_applicant.applicant_full_name}"
    ##expect(found_applicant.address_stripped.downcase).to start_with(@added_applicant.applicant_display_address.downcase) going to fail something missing
    expect(found_applicant.contact.include? "Contact").to eq(@added_applicant['is_contact'].to_s.casecmp('yes').zero?)
    expect(found_applicant.email).to eq(@added_applicant['emails'].join("\n"))
  end
end

# Same as above, but you can pass in Account Summary Page or Auto Policy Summary Page as page, should work for both grids
Then(/^the new applicant should be displayed in the general information from the "([^"]*)" page$/) do |page_name|
  on(page_name.to_page_class) do |page|
    page.wait_for_ajax
    found_applicant = page.applicants_panel.reverse_find_applicant_by_name_stripped(@added_applicant)
    expect(found_applicant).not_to be_nil, "Could not find #{@added_applicant.applicant_full_name} in the applicants list"
    expect(page.applicants_panel.strip_age_from_name(found_applicant.name_element.a.text)).to eq(@added_applicant.applicant_age.to_s), "DOB does not match for #{@added_applicant.applicant_full_name}"
    expect(found_applicant.name_element.span.text.downcase.gsub(',', '')).to start_with(@added_applicant.applicant_display_address_city.downcase.gsub(',', ''))
    expect(found_applicant.email).to eq(@added_applicant['emails'].join("\n"))
  end
end

# ------ Everything below this line is unverified ------------------------------------- #
#

When(/^I add and remove (\d+) applicants$/) do |arg|
  on(AccountSummaryPage) do |page|
    arg.to_i.times do |attempt|
      added_applicant = data_for('additional_applicant')
      page.add_applicant
      modal = page.add_applicant_modal
      modal.populate_with(added_applicant)
      modal.save_and_close
      found_applicant = page.applicants_panel.reverse_find_applicant_by_name(added_applicant)
      # rubocop:disable Lint/Debugger
      binding.pry if !found_applicant && Nenv.cuke_debug?
      # rubocop:enable Lint/Debugger
      found_applicant&.safe_delete
    rescue StandardError
      # rubocop:disable Lint/Debugger
      binding.pry if Nenv.cuke_debug?
      # rubocop:enable Lint/Debugger
    end
  end
end

When(/^I add (\d+) applicants$/) do |arg|
  on(AccountSummaryPage) do |page|
    arg.to_i.times do |attempt|
      added_applicant = data_for('additional_applicant')
      page.applicants_panel.add_applicant
      modal = page.add_applicant_modal
      modal.populate_with(added_applicant)
      modal.save_and_close
    rescue StandardError
      # rubocop:disable Lint/Debugger
      binding.pry if Nenv.cuke_debug?
      # rubocop:enable Lint/Debugger
    end
  end
end

And(/^I select the (.*) button on the (.*) panel$/) do |add_button, buttons_panel|
  on(AutoPolicySummaryPage) do |page|
    page.wait_for_modal_masker
    page.send(buttons_panel.snakecase).send(add_button.snakecase)
  end
end

When(/^I start adding an applicant from the account summary page$/) do
  on(AccountSummaryPage).applicants_panel.add_applicant
end

When(/^I start adding an applicant from the auto summary page$/) do
  on(AutoPolicySummaryPage).applicants_panel.add_policy_applicant
end

Then(/^the vehicle status color (should|should not) be red$/) do |should_or_not|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "IN - Auto"
      page.left_nav.navigate_to('IN - Auto')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Auto')
  error_class_as_expected = (on(AutoPolicySummaryPage).vehicle_info_panel.vehicles.first.attribute('class').include?('row-validation-error') == (should_or_not == 'not'))
  expect(error_class_as_expected).to be_truthy, "Expected the first vehicle in the vehicle grid on the Auto Policy Summary page#{should_or_not.gsub('should', '')} to appear red (class containing 'row-validation-error' when red)"
end

When(/^I change the agent of record on Account Summary$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(AccountSummaryPage) do |page|
    @policy_activity_num = page.product_list.products.first.product # Need to get the Policy Number to verify later!
    @original_account = @browser.url.split('/').last # needed for the transfer policy step

    agent = page.account_info.agency
    page.account_info.modify
    modal = page.account_general_info_modal
    modal.change_agent_of_record # has wait for ajax hook

    modal = page.agency_of_record_change_modal # new addition here, pops to new modal.

    # Need to get the old account number here and save to instance variable?  399176622  399875928
    filename = File.join(Dir.pwd, "fixtures/sample_pdf_1.pdf")
    modal.file_to_upload = filename
    modal.effective_date_of_change = Chronic.parse('today').to_date.strftime('%m/%d/%Y')
    modal.agency_name = agent.downcase.include?('hupe') ? 'PURMORT BROS INS AGCY (0-6958)' : 'THE DEHAYES GROUP (0 - BJ01)'
    modal.agency_contact = 1
    modal.agency_producer = 0
    modal.save_and_close
    page.wait_for_ajax
  end
  on(PolicyManagementPage).existing_account_or_new_account
end

When(/^I open the add product modal$/) do
  on(AccountSummaryPage) do |page|
    page.left_nav.add_product if page.left_nav.add_product?
    if page.left_nav.actions?
      page.left_nav.actions
      page.left_nav.new_quote
    end
  end
end

And(/^I search for "([^"]*)" using the basic search$/) do |text|
  on(AccountSummaryPage) do |page|
    entered_text = @email.split '.com' if text == 'email'
    entered_text = @name.split.map(&:capitalize).join(' ') if text == 'name'
    entered_text = @phone.delete("^0-9") if text == 'phone'
    page.basic_search_section.search_text = entered_text
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I select "([^"]*)" record matching with secondary text of "([^"]*)"$/) do |icon, text|
  expected_text = @email if text == 'email'
  expected_text = @name.split.map(&:capitalize).join(' ') if text == 'name'
  expected_text = @phone.remove("(Mobile)").strip if text == 'phone'
  on(AccountSummaryPage) do |page|
    results = page.basic_search_section.search_results
    result = results.find { |item| item.send("#{icon}_element").present? == true && item.search_report_name == expected_text }
    result.click
  end
end

And(/^I validate "([^"]*)" in applicants panel$/) do |text|
  expected_text = @email if text == 'email'
  expected_text = @name.upcase if text == 'name'
  expected_text = @phone if text == 'phone'
  on(AccountSummaryPage) do |page|
    expect(page.applicants_panel.applicants.first.send("#{text}").include? expected_text).to be_truthy
  end
end

Then(/^I select "([^"]*)" record matching with primary text "([^"]*)"$/) do |icon, text|
  if text == "name"
    @full_name = @name.split.map(&:capitalize).join(' ')
    on(AccountSummaryPage) do |page|
      results = page.basic_search_section.search_results
      result = results.find { |item| item.send("#{icon}_element").present? == true && item.primary_text.downcase == @full_name.downcase }
      result.click
    end
  else
    if text == "policy number" || "quote_number" || "account number"
      on(AccountSummaryPage) do |page|
        results = page.basic_search_section.search_results
        result = results.find { |item| item.send("#{icon}_element").present? == true && item.primary_text_element.following_sibling.text == @number }
        result.click
      end
    end
  end
end

And(/^I select "([^"]*)" and search by full name$/) do |option|
  on(AccountSummaryPage) do |page|
    page.basic_search_section.account_type = option
    page.basic_search_section.search_text = @name
    page.wait_for_processing_overlay_to_close
  end
end

And(/^I search for "([^"]*)" along with invalid letter$/) do |text|
  data_used = data_for('new_personal_account_modal')
  invalid_name = "#{data_used[text]}invalid"
  on(AccountSummaryPage) do |page|
    page.basic_search_section.search_text = invalid_name
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I validate empty message$/) do
  on(AccountSummaryPage) do |page|
    expect(page.basic_search_section.no_results_found_img?).to be_truthy
    expect(page.basic_search_section.no_results_found_message).to eq("No results found.")
  end
end

And(/^I save policy or quote number from account summary page$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(AccountSummaryPage) do |page|
    if page.product_list.quotes_tab_element.parent.attributes[:aria_selected] == 'false'
      if !page.product_list.products?
        page.product_list.quotes_tab
      end
    end
    @name = page.product_list.products.first.product
    @number = page.product_list.products.first.product.remove("IN - Auto -").strip
  end
end

And(/^I save policy or quote number from account summary page for "([^"]*)" policy$/) do |policy|
  on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(AccountSummaryPage) do |page|
    if page.product_list.quotes_tab_element.parent.attributes[:aria_selected] == 'false'
      if !page.product_list.products?
        page.product_list.quotes_tab
      end
    end
    @name = page.product_list.products.first.product
    case policy
    when policy = "Dwelling"
      @number = page.product_list.products.first.product.remove("IN - Special Dwelling -").strip
    when policy = "Home"
      @number = page.product_list.products.first.product.remove("IN - Homeowners -").strip
    when policy = "Auto"
      @number = page.product_list.products.first.product.remove("IN - Auto -").strip
    when policy = "Umbrella"
      @number = page.product_list.products.first.product.remove("IN - Umbrella -").strip
    end
  end
end

And(/^I save policy number from account summary page$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    @name = page.product_list.products.first.product
    @number = page.product_list.products.first.product.remove("IN - Auto -").strip.split(' ').first
  end
end

And(/^I search for (policy|account|quote) number in the basic search$/) do |which|
  on(AccountSummaryPage) do |page|
    if which == "policy" || "quote" || "account"
      page.basic_search_section.search_text = @number
      page.wait_for_processing_overlay_to_close
    else
      return
    end
  end
end

And(/^I validate "([^"]*)" in products panel$/) do |text|
  @browser.refresh
  on(AccountSummaryPage) do |page|
    if page.product_list.quotes_tab_element.parent.attributes[:aria_selected] == 'false'
      if !page.product_list.products?
        page.product_list.quotes_tab
      end
    end
    expect(page.product_list.products.first.send("#{text}")).to eq(@name)
  end
end

Then(/^I save account number and quote number from payments page and account summary page$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('IN - Auto')
  on(AutoPolicySummaryPage) do |page|
    @number = page.policy_number.split("\n").first.split().last
  end
  on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(AccountSummaryPage) do |page|
    if page.product_list.quotes_tab_element.parent.attributes[:aria_selected] == 'false'
      if !page.product_list.products?
        page.product_list.quotes_tab
      end
    end
    @name = page.product_list.products.first.product
  end
end

And(/^I save name email and phone number from account summary page$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(AccountSummaryPage) do |page|
    @email = page.applicants_panel.applicants.first.email
    @name = page.applicants_panel.applicants.first.name_element.b.text
    @phone = page.applicants_panel.applicants.first.phone
  end
end

Then(/^I click on view all results on top$/) do
  on(AccountSummaryPage) do |page|
    page.basic_search_section.view_all_results_element.click
  end
end

Then(/^I search for non existing "([^"]*)"$/) do |text|
  on(AccountSummaryPage) do |page|
    entered_text = 'Non existent' if text == 'name'
    entered_text = 'nonexistent@email' if text == 'email'
    entered_text = '9550894219' if text == 'phone'
    page.basic_search_section.search_text = entered_text
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I click on advanced search$/) do
  on(AccountSummaryPage) do |page|
    page.basic_search_section.search_text_element.click
    page.basic_search_section.advanced_search
    page.wait_for_modal_or_error
  end
end

And(/^I save first and last name$/) do
  on(AccountSummaryPage) do |page|
    @name = page.applicants_panel.applicants.first.name_element.a.b.text
    @first_name = @name.split(' ').first
    @last_name = @name.split(' ').last
  end
end

And(/^the new party with "([^"]*)" and roles as "([^"]*)" should be displayed on the account overview page$/) do |name, roles|
  on(AccountSummaryPage) do |page|
    found_applicant = page.applicants_panel.applicants.select { |i| i.name.downcase.include? @added_applicant[name.snakecase].downcase }
    expect(found_applicant).not_to be_nil, "Could not find #{@added_applicant['organization_name']} in the applicants list"
    expect(found_applicant.last.roles).to eq(roles)
  end
end

And(/^the new party with "([^"]*)" and roles as "([^"]*)" should not be displayed on the account overview page$/) do |name, roles|
  on(AccountSummaryPage) do |page|
    found_applicant = page.applicants_panel.applicants.find { |i| i.name.downcase.include? @added_applicant[name.snakecase].downcase }
    expect(found_applicant).to be_nil, "found #{@added_applicant['organization_name']} in the applicants list"
  end
end

And(/^I click on the edit party button and add edit party details$/) do
  @edit_party = data_for('edit_party')
  on(AccountSummaryPage) do |page|
    page.applicants_panel.applicants.last.edit
    page.wait_for_processing_overlay_to_close
    modal = page.add_applicant_modal
    modal.populate_with(@edit_party)
  end
end

And(/^I validate "([^"]*)" (is|is not) present in actions dropdown$/) do |opt, which|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(PolicyManagementPage) do |page|
    if page.premium_change_toast_close?
      page.premium_change_toast_close
    end
  end
  on(AccountSummaryPage) do |page|
    page.action
    select_list = page.div(class: /action-menu p-menu/).lis.map(&:text)
    if which == 'is'
      expect(select_list.include?(opt)).to be_truthy, "Option #{opt} not found"
    elsif which == 'is not'
      expect(select_list.include?(opt)).to be_falsey, "Option #{opt} found"
    end
  end
end

And(/^I should see ([^"]*) line should be generated$/) do |status|
  on(AccountSummaryPage) do |page|
    status_found = page.product_list.products.first.status
    expect(status_found).to eq(status)
  end
end

And(/^I validate billing section is present on Account Overview page$/) do
  on(AccountSummaryPage) do |page|
    expect(page.billing_summary_panel?).to be_truthy
  end
end

And(/^I verify view and order reports modal should appear$/) do
  on(PolicyManagementPage) do |page|
    modal = page.order_reports_modal
    modal.close
  end
end

And(/^I save account and name of the policy created$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(AccountSummaryPage) do |page|
    @email = page.applicants_panel.applicants.first.email
    @name = page.applicants_panel.applicants.first.name_element.b.text
    @phone = page.applicants_panel.applicants.first.phone
    @original_account = @browser.url
    @policy_activity_num = page.product_list.products.first.product
  end
end