# frozen_string_literal: true
#
#

When(/^I populate the form without selecting a product$/) do
  on(PaymentOptionsPage) do |page|
    # page.add_product_to_billing_act
    modal = page.billing_account_add_product_modal
    modal.payor_element.select_index(1) #simply select first payor in list.
    modal.next_modal
  end
end

# ------ Everything below this line is unverified ------------------------------------- #

When(/^I select "add product to billing" from the billing summary$/) do
  on(PaymentOptionsPage).add_product_to_billing_act
end

When(/^I select our applicant from the payor list$/) do
  data_used = EDSL::PageObject.fixture_cache['new_personal_account_modal']
  expected_name = "#{data_used['first_name']} #{data_used['middle_name']} #{data_used['last_name']} (applicant)"
  on(PaymentOptionsPage) do |page|
    expect(page.billing_account_add_product_modal.available_payors.find { |i| i.include? expected_name }).to be_truthy, 'The applicant is not present in the payor list'
    page.billing_account_add_product_modal.payor = expected_name
  end
end

Then(/^our applicants mailing address should appear in the billing address dropdown$/) do
  data_used = EDSL::PageObject.fixture_cache['new_personal_account_modal']['address_details']
  expected_addr = "#{data_used['address_line_1']}, #{data_used['city']}, #{STATE_NAME_TO_ABBR[data_used['state']]} #{data_used['zip_code']}"
  on(PaymentOptionsPage) do |page|
    expect(page.billing_account_add_product_modal.available_addresses.find { |i| i.include? expected_addr }).to be_truthy, 'Applicant mailing address is not present in billing address dropdown'
  end
end

Then(/^our Bill Plan should be defaulted to "([^"]*)"$/) do |item|
  expect(item.downcase).to eq(on(PaymentOptionsPage).billing_account_add_product_modal.bill_plan.downcase)
end

Then(/^I select "([^"]*)" from the Payment Method$/) do |payment_method|
  on(PaymentOptionsPage).billing_account_add_product_modal.payment_method = payment_method
end

And(/^I select "([^"]*)" for the Day of month payment is due$/) do |day|
  on(PaymentOptionsPage) do |page|
    page.billing_account_add_product_modal.payment_due_date.set(day)
  end
end

When(/^I select our applicants mailing address from the billing address dropdown$/) do
  data_used = EDSL::PageObject.fixture_cache['new_personal_account_modal']['address_details']
  expected_addr = "#{data_used['address_line_1']}, #{data_used['city']}, #{STATE_NAME_TO_ABBR[data_used['state']]} #{data_used['zip_code']}"
  on(PaymentOptionsPage) do |page|
    page.billing_account_add_product_modal.billing_address = expected_addr
  end
end

Then(/^the day of month payment is due should be enabled$/) do
  on(PaymentOptionsPage) do |page|
    actual = page.billing_account_add_product_modal.payment_due_date_element.enabled?
    expect(actual).to be_truthy
  end
end

When(/^I check all the products listed$/) do
  on(PaymentOptionsPage) do |page|
    page.billing_account_add_product_modal.toggle_all_products(true)
  end
end

When(/^I populate the billing modal using the (.*)$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)

  @data_from_fixture = data_for('billing_account_add_product_modal')

  on(AutoPolicySummaryPage) do |page|
    # page.add_product_to_billing_act
    modal = page.billing_account_add_product_modal
    modal.populate_billing_modal(@data_from_fixture)

    #TODO need to put this recommended down payment back at some point   4-29-2020
    #@calculated_down_payment = modal.down_payment_rounded(modal.recommended_down_payment)
    modal.save_and_close_button
  end
end

Then(/^I populate the billing using the "([^"]*)" fixture file$/) do |item|
  #on(PolicyManagementPage).left_navigate_to_if_not_on('Payment Options')

  Helpers::Fixtures.load_fixture(item.snakecase)
  @data_from_fixture = data_for('billing_account_add_product_modal')
  on(AutoPolicySummaryPage) do |page|
    page.add_product_to_billing_act unless page.billing_account_add_product_modal?
    modal = page.billing_account_add_product_modal
    modal.populate_billing_modal(@data_from_fixture)
    modal.save_and_close_button
    page.wait_for_modal_or_error
    page.wait_for_processing_overlay_to_close

    # GET account number for comparision later!
    #
    @billing_account = page.issue_wizard_modal.billing_section.billing_accounts.first.billing_account
  end
end

Then(/^I populate the billing using the "([^"]*)" fixture file save and wait$/) do |item|
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Payment Options')

  Helpers::Fixtures.load_fixture(item.snakecase)
  @data_from_fixture = data_for('billing_account_add_product_modal')
  on(AutoPolicySummaryPage) do |page|
    page.add_product_to_billing_act unless page.billing_account_add_product_modal?
    modal = page.billing_account_add_product_modal
    modal.populate_billing_modal(@data_from_fixture)
    modal.save_and_close_button_no_hooks
  end
end

Then(/^the billing account should be listed in the Billing Account grid$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.issue_wizard_modal
    section = modal.billing_section
    actual_payment_method = section.billing_accounts_element.items.first.payment_method
    actual_bill_plan = section.billing_accounts_element.items.first.bill_plan
    RSpec.capture_assertions do
      expect(actual_payment_method).to eq(data_for('expected_grid_data')['payment_method'])
      expect(actual_bill_plan).to eq(data_for('expected_grid_data')['bill_plan'])
    end
  end
  # on(PaymentOptionsPage) do |page|
  #   actual_payor = page.billing_accounts_element.items.first.payor
  #   actual_bill_plan = page.billing_accounts_element.items.first.bill_plan
  #   #actual_recommended_payment = page.billing_accounts_element.items.first.recommended_down_payment.gsub('$', '')
  #
  #   expected_payor = if @data_from_fixture.key?('new_first_name')
  #                      "#{@data_from_fixture['new_first_name']} #{@data_from_fixture['new_last_name']}"
  #                    else
  #                      # HACK for pat4963 bug
  #                      page.billing_account_add_product_modal.expected_payor_temp
  #                    end
  #
  #   RSpec.capture_assertions do
  #     #expect(actual_recommended_payment.to_f).to eq(@calculated_down_payment)
  #     expect(actual_payor.downcase).to eq(expected_payor.downcase)
  #     expect(actual_bill_plan).to eq(data_for('expected_grid_data')['bill_plan'])
  #   end
  # end
end

When(/^I edit the billing modal with the new data in the (.*)$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(PaymentOptionsPage) do |page|
    page.billing_accounts_element.items.first.edit_billing_acct
    modal = page.billing_account_add_product_modal
    modal.populate_with(data_for('edit_billing_account_data'))
    modal.next_modal
  end
end

Then(/^the Add Product to Billing Account button should be disabled$/) do
  on(PaymentOptionsPage) do |page|
    expect(page.add_product_to_billing_act_disabled?).to be_truthy
  end
end

Then(/^I should see a validation message$/) do
  on(PaymentOptionsPage) do |page|
    modal = page.billing_account_add_product_modal
    expected_msg = modal.validation_messages?
    expect(expected_msg).to be_truthy, "Expected to find a validation message, but did not!"
  end
end

Then(/^I verify products under home$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
    page.premium_change_toast_close if page.premium_change_toast_close?
  end
  on(QuoteManagementPage).issue
  modal = on(AutoPolicySummaryPage).issue_wizard_modal
  expect(modal.select_product_section.home_attached_products_spp_element.present?).to be_truthy
  expect(modal.select_product_section.home_attached_products_watercraft_element.present?).to be_truthy
  modal.select_product_section.product_collapse_element.click
  expect(modal.select_product_section.home_attached_products_spp_element.present?).to be_falsey
  expect(modal.select_product_section.home_attached_products_watercraft_element.present?).to be_falsey
end



Then(/^I navigate till billing modal and validate it$/) do
  #on(PolicyManagementPage).refresh_alerts

  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    page.issue unless page.issue_wizard_modal.present?
    Watir::Wait.until { page.issue_wizard_modal.present? }
    modal = page.issue_wizard_modal
    section_to_navigate = modal.get_section
    previous_section = nil
    while modal.present? && section_to_navigate != previous_section && !section_to_navigate.nil?
      if !modal.billing_section.present?
        section_to_navigate.navigate_defaults
        modal.next_button
        Watir::Wait.while { section_to_navigate.present? }
        previous_section = section_to_navigate
        section_to_navigate = modal.get_section
      else
        section_to_navigate.add_billing_account
        page.wait_for_modal_or_error
        expect(page.billing_account_add_product_modal.present?).to be_truthy
      end

    end

  end
end

And(/^I populate the billing modal with credit card details$/) do
  on(PaymentOptionsPage) do |page|
    modal = page.billing_account_add_product_modal
    modal.apply_billing_account_to_selected_products
    ex = modal.expected_payor.upcase.split(/[()]/)
    modal.payor = "#{ex.first}(#{ex.last.downcase})"
    modal.bill_plan_monthly.click
    modal.e_billing = false
    modal.payment_method_credit.click
    modal.add_card
  end
  on(PolicyManagementPage) do |page|
    page.provide_card_details
    sleep(2)
  end
  on(PaymentOptionsPage) do |page|
    modal = page.billing_account_add_product_modal
    modal.save_and_close_button
    Watir::Wait.while { modal.present? }
    sleep(2)
  end
end

And(/^I populate the billing modal with checking account details$/) do
  on(PaymentOptionsPage) do |page|
    modal = page.billing_account_add_product_modal
    modal.apply_billing_account_to_selected_products
    ex = modal.expected_payor.upcase.split(/[()]/)
    modal.payor = "#{ex.first}(#{ex.last.capitalize})"
    modal.bill_plan_monthly.click
    modal.e_billing = false
    modal.payment_method_eft.click
    modal.add_bank_account
  end
  on(PolicyManagementPage) do |page|
    page.provide_checking_account_details
    sleep(2)
  end
  on(PaymentOptionsPage) do |page|
    modal = page.billing_account_add_product_modal
    modal.save_and_close_button
    Watir::Wait.while { modal.present? }
    sleep(2)
  end
end

Then(/^I navigate till billing modal and validate default option of bill plan$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
    page.premium_change_toast_close if page.premium_change_toast_close?
    @browser.refresh
  end
  on(QuoteManagementPage).issue
  on(AutoPolicySummaryPage) do |page|
    page.issue unless page.issue_wizard_modal.present?
    Watir::Wait.until { page.issue_wizard_modal.present? }
    modal = page.issue_wizard_modal
    section_to_navigate = modal.get_section
    previous_section = nil
    while modal.present? && section_to_navigate != previous_section && !section_to_navigate.nil?
      if !modal.billing_section.present?
        section_to_navigate.navigate_defaults
        modal.next_button
        Watir::Wait.while { section_to_navigate.present? }
        previous_section = section_to_navigate
        section_to_navigate = modal.get_section
      else
        section_to_navigate.add_billing_account
        page.wait_for_modal_or_error
        expect(page.billing_account_add_product_modal.present?).to be_truthy
      end
    end
  end
  on(PolicyManagementPage) do |page|
    modal = page.billing_account_add_product_modal
    expect(modal.bill_plan_annual_element.div.classes.include? 'p-radiobutton-checked').to be_truthy
  end
end