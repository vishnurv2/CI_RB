# frozen_string_literal: true

And(/^I click the "([^"]*)" tab$/) do |tab|
  on(AccountSummaryPage) do |page|
    left = page.left_nav
    left.send("#{tab.snakecase}") if left.policies_element.parent.attributes[:aria_selected] == 'false'
    page.wait_for_ajax
  end
end

And(/^I should see the following links available in the left nav$/) do |table|
  row = table.raw.first
  on(PolicyManagementPage) do |page|
    nav_bar = page.left_nav.list_group.map { |x| x.text.upcase }
    RSpec.capture_assertions do
      row.each do |item|
        expect(nav_bar.include?(item.upcase)).to be_truthy, "Expected \"#{item}\" to be in the left hand navigation!"
      end
    end
  end
end

Then(/^No quotes should exist$/) do
  on(AccountSummaryPage) do |page|
    page.product_list.quotes_tab
    expect(page.product_list.products?).to be_falsey, "Expected the Quotes tab and products table NOT to have any open quotes!!"
  end
end

Then(/^The products section has "([^"]*)" in the actions dropdown$/) do |arg|
  on(AccountSummaryPage) do |page|
    Watir::Wait.until(timeout: 30) { page.product_list.products.first.three_dots? }
    page.product_list.products.first.three_dots

    link = page.product_list.products.first.send("#{arg}?")
    expect(link).to be_truthy, "Expected to find the link in the drop down menu"
  end
end

And(/^The auto policy matches whats in the products table$/) do
  on(AccountSummaryPage) do |page|
    page.scroll.to :bottom
    page.claims_summary.report_a_claim
    first_option = page.claims_summary.claims_button_list.first.text.to_s
    first_product = page.product_list.products.first.product_cell.to_s

    expect(first_product).to eq(first_option)
  end
end

Then(/^I update auto applicant using "([^"]*)"$/) do |fixture_file|
  on(PolicyManagementPage).left_nav.navigate_to("IN-AUTO")
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(AutoPolicySummaryPage) do |page|
    page.applicants_panel.applicants_grid.items.first.edit
    modal = page.add_applicant_modal
    modal.populate_with(data_for('issues_to_resolve'))
    modal.save_and_close
  end
end

When(/^I order CLUE\/MVR and save$/) do
  on(PolicyManagementPage).left_nav.navigate_to("Reports")
  on(ReportsPage).resolve_issues_to_resolve

  # OLD WAY
  #on(ReportsPage) do |page|
    #page.clue_prefill_mvr_section.order_reports_by_type(['Auto CLUE', 'MVR'])
    #modal = page.auto_driver_modal
    #modal.save_and_close
  #end
end

Then(/^I answer underwriting questions$/) do
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  # on(PolicyManagementPage).left_nav.navigate_to("Underwriting Questions")
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.all_products_questions.edit
    modal = page.underwriting_questions_modal
    modal.agree_to_all_questions=true
    modal.save_and_continue
    modal.agree_to_all_questions_auto=true
    modal.save_and_close
  end
end

When(/^I order CLUE\/MVR reports and answer the underwriting questions$/) do
  on(PolicyManagementPage).left_nav.navigate_to("Reports")
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.order_reports_by_type(['Auto CLUE', 'MVR'])
    modal = page.auto_driver_modal
    modal.save_and_close
  end

  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  # on(PolicyManagementPage).left_nav.navigate_to("Underwriting Questions")
  on(UnderwritingQuestionsSummaryPage) do |page|
    # all products
    page.all_products_questions.edit
    modal = page.underwriting_questions_modal
    modal.agree_to_all_questions=true
    modal.save_and_close
    # auto questions
    page.auto_questions.edit
    modal.agree_to_all_questions_auto=true
    modal.save_and_close
  end
end

And(/^The vehicle should be updated in the second quote option$/) do
  data_used = EDSL::PageObject.fixture_cache['auto_vehicle_modal']

  on(QuoteOptionsPage) do |page|
    second_panel = page.quote_option_panels[1]
    actual_vehicle = second_panel.vehicles.first.vehicle_name
    expected_vehicle = "#{data_used['vehicle_year']} #{data_used['vehicle_make']} #{data_used['vehicle_model']}"
    expect(actual_vehicle).to eq(expected_vehicle), "Expected to find \"#{expected_vehicle}\" but found \"#{actual_vehicle}\" instead!"
  end
end

And(/^The policy change count should be (\d+)$/) do |expected_count|
  on(PolicyManagementPage) do |page|
    actual_count = page.policy_change_count
    expect(actual_count).to eq(expected_count.to_s), "Expected the policy change count in the left nav to equal #{expected_count}, but a count of #{actual_count} was found"
  end
end

And(/^I add out of sequence policy changes$/) do
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  @first_policy_change_effective_date = Chronic.parse('100 days from now').to_date.strftime('%m/%d/%Y')

  on(AccountSummaryPage).add_policy_change_effective(@first_policy_change_effective_date)
  on(AutoPolicySummaryPage) do |page|
    page.edit_first_vehicle_otc_coverage
  end

  on(PolicyManagementPage) do |page|
    #this is a hack to get this going today, will refactor later. #toggle quotes

    collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
    page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"

    page.left_nav.navigate_to("Open Policy Changes")
  end

  on(QuoteManagementPage) do |page|
    if page.view_underwriting_referrals?
      page.view_underwriting_referrals
      page.wait_for_modal_or_error
    end
  end
  on(PolicyManagementPage) do |page|
    if page.underwriting_referrals_modal?
      modal = page.underwriting_referrals_modal
      modal.referrals_panel.each do |panel|
        panel.referrals.each do |referral|
          unless referral.status.downcase.include? "approved"
            referral.click
            referral.review_section.approval_status = "Approve"
            referral.review_section.save
            page.wait_for_ajax
          end
        end
      end
    end
  end

  on(QuoteManagementPage).submit_changes
  on(AutoPolicySummaryPage) do |page|
    Watir::Wait.until { page.issue_wizard_modal.present? }
    page.issue_wizard_modal.navigate(page.billing_account_add_product_modal)
  end


  @second_policy_change_effective_date = Chronic.parse('50 days from now').to_date.strftime('%m/%d/%Y')
  on(AccountSummaryPage).add_policy_change_effective(@second_policy_change_effective_date)
  on(AutoPolicySummaryPage) do |page|
    page.edit_first_vehicle_otc_coverage
  end
  on(PolicyManagementPage) do |page|
    #this is a hack to get this going today, will refactor later. #toggle quotes

    collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
    page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"

    page.left_nav.navigate_to("Open Policy Changes")
  end

  on(QuoteManagementPage) do |page|
    if page.view_underwriting_referrals?
      page.view_underwriting_referrals
      page.wait_for_modal_or_error
    end
  end
  on(PolicyManagementPage) do |page|
    if page.underwriting_referrals_modal?
      modal = page.underwriting_referrals_modal
      modal.referrals_panel.each do |panel|
        panel.referrals.each do |referral|
          unless referral.status.downcase.include? "approved"
            referral.click
            referral.review_section.approval_status = "Approve"
            referral.review_section.save
            page.wait_for_ajax
          end
        end
      end
    end
  end

  on(QuoteManagementPage).submit_changes
  on(AutoPolicySummaryPage) do |page|
    Watir::Wait.until { page.issue_wizard_modal.present? }
    page.issue_wizard_modal.navigate(page.billing_account_add_product_modal)
  end

end

When(/^I edit the auto applicant name$/) do
  on(AccountSummaryPage) do |page|
    page.applicants_panel.applicants.first.edit_element.click
    modal = page.add_applicant_modal
    modal.first_name = Helpers::FakeIt.last_name #Fake something random using last name helper
    #  modal.gender_male = true
    modal.save_and_close
    page.wait_for_ajax
  end
end

Then(/^I should see out of sequence policy changes$/) do
  on(AccountSummaryPage) do |page|
    page.product_list.products.first.expand
    products = page.product_list.products
    RSpec.capture_assertions do
      expect(products[1].effective_date).to eq(@first_policy_change_effective_date), "Expected the second policy row to have the effective date of the first policy change (#{@first_policy_change_effective_date})"
      expect(products[2].effective_date).to eq(@first_policy_change_effective_date), "Expected the third policy row to have the effective date of the first policy change (#{@first_policy_change_effective_date})"
      expect(products[2].product.include?('Reversed')).to be_truthy, "Expected the third policy row to include the word 'Reversed'"
      expect(products[3].effective_date).to eq(@second_policy_change_effective_date), "Expected the fourth policy row to have the effective date of the second policy change (#{@second_policy_change_effective_date})"
      expect(products[4].effective_date).to eq(@first_policy_change_effective_date), "Expected the fifth policy row to have the effective date of the first policy change (#{@first_policy_change_effective_date})"
      expect(products[4].product.include?('Reapplied')).to be_truthy, "Expected the fifth policy row to include the word 'Reapplied'"
    end
  end
end


Then(/^I validate policy change modal appears$/) do
  on(AccountSummaryPage) do |page|
    modal = page.add_applicant_modal
    expect(modal).to be_truthy
  end
end


When(/^I update the Affiliate Discount in general info modal from No to "([^"]*)"$/) do |opt|
  on(AccountSummaryPage) do |page|
    page.watercraft_account_info.modify
    on(PolicyManagementPage) do |page|
      modal = page.auto_general_info_modal
      modal.affiliate_discount = opt
      modal.save_and_close
    end
  end
end

When(/^I click on the error validation from issues to resolve modal$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.issues_to_resolve_element.click
    page.issues_to_resolve_modal.error_validation.click
  end
end

And(/^I edit policy change from policies tab$/) do
  on(AccountSummaryPage) do |page|
    row_index = page.product_list.products.find{|i| i.status.downcase == "change pending"}.rowindex
    found_product = page.product_list.products[row_index]
    found_product.three_dots
    found_product.edit_policy_change
    modal = page.edit_policy_change_modal
    modal.date.span(text: 'Specify Date').click
    modal.specific_date = Chronic.parse('3 days from now').to_date.strftime('%m/%d/%Y')
    modal.description_element.click
    modal.description = 'effective date updated again'
    sleep(0.6)
    modal.save_and_close_button
    page.wait_for_ajax
  end
end

And(/^I verify the option Open Policy Change should present on left nav with its own navigation$/) do
  on(PolicyManagementPage) do |page|
    left_nav_bar = page.left_nav
    expect(left_nav_bar.open_policy_changes_element.present?).to be_truthy
  end
end