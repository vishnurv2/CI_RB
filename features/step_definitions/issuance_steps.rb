# frozen_string_literal: true

When(/^I begin issuance$/) do
  on(PolicyManagementPage) do |page|
    if page.quote_snapshot_modal.present?
      begin
        page.quote_snapshot_modal.quote_management
      rescue
      end
    end
    page.left_nav.navigate_to('Quote Management')
  end
  @browser.refresh
  on(PolicyManagementPage).wait_for_ajax
  on(QuoteManagementPage).begin_issuance_on_all
end

When(/^I finish issuing the policy$/) do
  ##on(PolicyManagementPage).refresh_alerts ## taken out
  on(PolicyManagementPage) do |page|
    page.premium_change_toast_close if page.premium_change_toast_close?
  end
  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage).navigate_issue_wizard
end

When(/^I fully issue the policy$/) do
  # BEGIN ISSUANCE
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  # @premium = on(QuoteManagementPage).quote_total_premium # used in some steps to compare later.  MOVED this to fully issue step
  on(QuoteManagementPage).resolve_issues_to_resolve

  # ANSWER UNDERWRITER QUESTIONS
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
  end
  on(QuoteManagementPage).underwriting_questions_tab
  # on(PolicyManagementPage).left_nav.navigate_to("Underwriting Questions")
  on(UnderwritingQuestionsSummaryPage).resolve_issues_to_resolve
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_umbrella

  # ORDER REPORTS
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Reports') unless page.page_header_text.include? "Reports"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on("Reports")
  on(ReportsPage).resolve_issues_to_resolve
  # ANSWER UNDERWRITER REFERRALS
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.each do |question|
        question.review
        #question.review_section.approval_status = "Approve"
        question.span(text: 'Approve').double_click
        question.comments = "test"
        question.save
      end
    end
  end

  #on(PolicyManagementPage).refresh_alerts  removed

  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to_first_product
    @browser.refresh
    page.wait_for_processing_overlay_to_close
  end

  on(AutoPolicySummaryPage).navigate_issue_wizard

end

When(/^I fully issue the multiple policies$/) do
  # BEGIN ISSUANCE
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  # @premium = on(QuoteManagementPage).quote_total_premium # used in some steps to compare later.  MOVED this to fully issue step
  on(QuoteManagementPage).resolve_issues_to_resolve

  # ANSWER UNDERWRITER QUESTIONS
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_home
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_umbrella
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_scheduled_property
  on(UnderwritingQuestionsSummaryPage).resolve_issues_to_resolve

  # ORDER REPORTS
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Reports') unless page.page_header_text.include? "Reports"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on("Reports")
  #on(ReportsPage).resolve_issues_to_resolve
  on(ReportsPage).multiple_issues_to_resolve

  #on(PolicyManagementPage).refresh_alerts

  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage) do |page|
        counter = page.referrals_panel.count
        if counter > 0
          counter.times do
            panel = page.referrals_panel.find { |p| p.blue_streak_seal? == true }
            if !panel.nil?
              panel.blue_streak_seal = true
              panel.reason_for_applying_seal = 'test'
              panel.seal_authorized_by = 0
              panel.apply_seal
              page.wait_for_processing_overlay_to_close
              page.wait_for_ajax
              page.scroll.to :top
            end
            if panel.nil?
              panel = page.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == "AWAITING REVIEW" } }
              counter = panel.referrals.count
              counter.times do
                panel = page.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == "AWAITING REVIEW" } }
                if !panel.nil?
                  question = panel.referrals.find { |question| question.status == "AWAITING REVIEW" }
                  question.review
                  question.span(text: 'Approve').double_click
                  question.comments = "test"
                  question.save
                end
              end
            end
          end
        end
      end
    end
  end

  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
    page.premium_change_toast_close if page.premium_change_toast_close?
  end
  @browser.refresh
  on(QuoteManagementPage).issue
  on(AutoPolicySummaryPage).navigate_issue_wizard

end

# # ------ Everything below has NOT been VERIFIED ------------------------------------- #

Then(/^I should see (\d+) products to issue$/) do |count|
  #on(PolicyManagementPage).refresh_alerts
  @browser.refresh
  on(QuoteManagementPage) do |page|
    @total_premium = page.quote_total_premium
    page.issue
  end
  on(AutoPolicySummaryPage) do |page|
    modal = page.issue_wizard_modal
    expect(modal.select_product_section.products_to_issue_count).to eq(count.to_i), "Expected the Product to Issue Grid to Contain #{count} Products"
  end
  # on(PolicyIssuancePage) do |page|
  #   page.wait_for_ajax # if the product grid doesn't load fast enough, consider doing a Watir::Wait.until products_to_issue.count == count.to_i with a 5 second timeout or something
  #   expect(page.products_to_issue.count).to eq(count.to_i), "Expected the Product to Issue Grid to Contain #{count} Products"
  # end
end

And(/^the total premium for the products to issue should be correct$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.issue_wizard_modal
    expect(modal.select_product_section.total_account_premium).to eq(@total_premium)
  end

  # on(PolicyIssuancePage) do |page|
  #   expected = page.products_to_issue.map { |i| i.premium.gsub(/\$|,/, '').to_f }.sum
  #   actual = page.total_premium
  #   expect(actual).to eq(ActiveSupport::NumberHelper.number_to_currency(expected))
  # end
end

When(/^I begin issuing the first quoted policy$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Options')
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  on(QuoteManagementPage) do |page|
    page.check_first_quoted # New addition here, checking all products listed as "quoted"
    page.begin_issuance
  end
end

When(/^I stop issuance$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Account Overview') unless page.page_header_text.include? "Account Summary"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Summary')
  on(AccountSummaryPage).product_list.products.first.do_not_issue_element.click!
end

And(/^I issue the product on the Account Summary Page$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Account Overview') unless page.page_header_text.include? "Account Summary"
  end
  on(PolicyManagementPage).left_navigate_to_if_not_on('Account Summary')
  on(AccountSummaryPage).product_list.products.first.issue
end

Then(/^the total premium for paid in full should be correct$/) do
  on(QuoteManagementPage) do |page|
    expected = page.quote_section.map { |i| i.paid_in_full.gsub(/\$|,/, '').to_f }.sum
    actual = page.quote_paid_in_full
    expect(actual).to eq(ActiveSupport::NumberHelper.number_to_currency(expected)), "Expected the total premium to be \"#{expected}\" but instead it was \"#{actual}\""
  end
end

Then(/^I click the begin issuance$/) do
  on(QuoteManagementPage) do |page|
    page.wait_for_ajax
    page.scroll.to :top
    page.check_all_quoted
    page.scroll.to :top
    # the begin issuance is sometimes clicked too fast after selecting check box, adding a slight delay
    sleep(0.3)
    page.begin_issuance
    Watir::Wait.while(timeout: 120) { page.preparing_application_element.present? }
    page.wait_for_ajax

    page.issues_to_resolve_modal.close if page.issues_to_resolve_modal?
    page.thank_you_modal.close if page.thank_you_modal.present?
  end
end


And(/^I start with issue wizard modal till Signature modal$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
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
    modal.payor = 1
    modal.bill_plan_monthly.click
    page.wait_for_processing_overlay_to_close
    modal.payment_method_manual.click
    page.wait_for_processing_overlay_to_close
    modal.save_and_close
    page.wait_for_processing_overlay_to_close
  end

  on(AutoPolicySummaryPage) do |page|
    modal = page.issue_wizard_modal
    modal.next_button
    page.wait_for_processing_overlay_to_close
    modal.all_prod_selection.click
  end
end

Then(/^I start issuing the policy and verify signature carry forward functionality$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
      page.wait_for_ajax
      page.premium_change_toast_close if page.premium_change_toast_close?
    end
  end

  on(QuoteManagementPage).issue
  on(AutoPolicySummaryPage) do |page|
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
      end
    end
  end
  on(PolicyManagementPage) do |page|
    modal = page.billing_account_add_product_modal
    modal.payor = 1
    modal.label(xpath: '//p-checkbox[contains(@class,"productCheckbox")]//label[contains(text(),"IN - Auto")]').click
    page.wait_for_processing_overlay_to_close
    modal.label(xpath: '//p-checkbox[contains(@class,"productCheckbox")]//label[contains(text(),"IN - Watercraft")]').click
    page.wait_for_processing_overlay_to_close
    modal.bill_plan_monthly.click
    page.wait_for_processing_overlay_to_close
    modal.payment_method_manual.click
    page.wait_for_processing_overlay_to_close
    modal.save_and_close_button
    page.wait_for_processing_overlay_to_close
  end
  on(AutoPolicySummaryPage) do |page|
    page.issue_wizard_modal.next_button if page.issue_wizard_modal.present?
    page.wait_for_processing_overlay_to_close
    page.issue_wizard_modal.all_prod_selection.click
    page.issue_wizard_modal.email_option_1 = 1
    expect(page.issue_wizard_modal.email_option_2.text).to eq(page.issue_wizard_modal.email_option_1.text)
  end
end

Then(/^The following left nav items should have (red exclamation point|green check mark)s$/) do |colored_symbol, left_nav_items_to_compare|
  on(PolicyManagementPage) do |page|
    page.left_nav.expand_collapsed_menu_items
    RSpec.capture_assertions do
      left_nav_items_to_compare.rows.flatten.each do |item_to_compare|
        #page_item = page.left_nav.menu_items.find { |page_item_searching| item_to_compare.downcase == page_item_searching.text.downcase }
        page_item = page.left_nav.menu_items.find { |page_item_searching| item_to_compare.downcase == page_item_searching.a.element(xpath: './/span[contains(@class, "sidebarNav-text") and not(contains(@class, "exclamation-circle"))]').text.downcase }
        #expect(page_item.send("#{colored_symbol.snakecase}?")).to be_truthy, "Expected the left nav menu item for #{item_to_compare} to have a #{colored_symbol}"
        expect(page_item.present?).to be_truthy
      end
    end
  end
end

Then(/^I (should|should not) see the Issue Confirmation dismissible alert$/) do |should_or_not|
  expected_not_str = should_or_not.gsub('should', '')
  actual_not_str = ' not'.gsub(expected_not_str, '')
  on(AccountSummaryPage) do |page|
    expect(page.issue_confirmation_alert? && page.issue_confirmation_alert_element.present?).to be_truthy, "Expected#{expected_not_str} to see the 'Issue Confirmation' alert at the top of the Account Summary Page, but it was#{actual_not_str} found"
  end
end

Then(/^I (should|should not) see the Policy Change Confirmation dismissible alert$/) do |should_or_not|
  expected_not_str = should_or_not.gsub('should', '')
  actual_not_str = ' not'.gsub(expected_not_str, '')
  on(AccountSummaryPage) do |page|
    expect(page.policy_change_confirmation_alert? && page.policy_change_confirmation_alert_element.present?).to be_truthy, "Expected#{expected_not_str} to see the 'Policy Change Confirmation' alert at the top of the Account Summary Page, but it was#{actual_not_str} found"
  end
end

Then(/^The policy number should be generated$/) do
  expected_numeric_digits = 6
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
  end
  on(QuoteManagementPage) do |page|
    product = page.product_grid.items.first.product
    expect(product.count("0-9") >= expected_numeric_digits).to be_truthy, "Expected \"#{product}\" from the product grid to contain at least #{expected_numeric_digits} numeric digits representing a policy number, but it did not"
  end
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Account Overview') unless page.page_header_text.include? "Account Summary"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Summary')
  on(AccountSummaryPage) do |page|
    product = page.product_list.products.first.product_cell
    expect(product.count("0-9") >= expected_numeric_digits).to be_truthy, "Expected \"#{product}\" from the product grid to contain at least #{expected_numeric_digits} numeric digits representing a policy number, but it did not"
  end
end

And(/^I fully issue the policy with no email$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Issue')
  on(PolicyIssuancePage).issue_policy_no_e_policy
end

When(/^I issue the first policy$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Issue')
  on(PolicyIssuancePage) do |page|
    page.products_to_issue.first.issue = true
    page.products_to_issue[1..-1].each { |p| p.issue = false }
    page.issue_policy
  end
end

Then(/^The product begin issuance check boxes should have the following states$/) do |table|
  on(PolicyManagementPage).left_navigate_to_if_not_on('Issue')
  on(PolicyIssuancePage) do |page|
    states = table.hashes.map { |h| h['state'] }
    RSpec.capture_assertions do
      page.products_to_issue.each_with_index do |row, i|
        state = states[i]
        expect(row.send("checkbox_#{state}?")).to be_truthy, "Expected the issue checkbox for the product \"#{row.product_link_element.text}\" to be #{state}"
      end
    end
  end
end

And(/^The disabled product begin issuance check boxes should have a message$/) do
  on(PolicyManagementPage).left_navigate_to_if_not_on('Issue')
  on(PolicyIssuancePage) do |page|
    RSpec.capture_assertions do
      page.products_to_issue.each do |row|
        binding.pry if Nenv.cuke_debug?
        pending
        expect('').not_to(be_nil, "Expected the issue checkbox for the product \"#{row.product_link_element.text}\" to have a hover message, but it could not be found") if row.checkbox_disabled?
      end
    end
  end
end

When(/^I fully issue the umbrella policy$/) do
  # BEGIN ISSUANCE
  on(PolicyManagementPage) do |page|
    if page.quote_snapshot_modal.present?
      page.quote_snapshot_modal.quote_management
    else
      page.left_nav.navigate_to('Quote Management')
    end
  end
  #on(PolicyManagementPage).quote_snapshot_modal.quote_management
  #on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  #@premium = on(QuoteManagementPage).quote_total_premium # used in some steps to compare later.  MOVED this to fully issue step
  on(QuoteManagementPage).resolve_issues_to_resolve

  # ANSWER UNDERWRITER QUESTIONS
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
  end
  on(QuoteManagementPage).underwriting_questions_tab
  # on(PolicyManagementPage).left_nav.navigate_to("Underwriting Questions")
  # on(UnderwritingQuestionsSummaryPage).all_products_issues_to_resolve # AMN 6-29-2021 Account Underwriting Questions Have Been Removed
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_umbrella

  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to('Referrals') unless page.page_header_text.include? "Referrals"
    # page.left_navigate_to_if_not_on("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.each do |panel|
        panel.referrals.each do |question|
          #question.click
          #question.review_section_element.span(text: 'Approve').double_click
          #question.review_section.save
          if question.status.downcase.include? "awaiting review"
            on(CMIEmployeesSummaryPage).wait_for_ajax
            question.review
            #question.review_section.approval_status.scroll.to :center
            #question.review_section_element.span(text: 'Approve').click
            question.span(text: 'Approve').double_click
            question.comments = "test"
            #question.div(xpath: '//div[contains(@class,"p-toggleable-content")]').button.click
            # question.review_section.approval_status = "Approve"
            question.save
          end
        end
      end
    end
  end
  # BILLING
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Billing & Payment Options')
  #on(PaymentOptionsPage).resolve_issues_to_resolve
  #on(PolicyManagementPage).refresh_alerts

  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    page.issue
  end

  on(AutoPolicySummaryPage).navigate_issue_wizard

  # Finish issuing!
  # on(PolicyManagementPage).left_nav.navigate_to("Issues to Resolve")
  # @premium = on(PolicyIssuancePage).fully_issue_policy #  return the premium from this method.
end

When(/^I fully issue the home policy$/) do
  #Need to Nav to Quote options to generate referralls
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  on(PolicyManagementPage).wait_for_ajax

  # ANSWER UNDERWRITER REFERRALS - if any
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage) do |page|
        counter = page.referrals_panel.count
        if counter > 0
          counter.times do
            panel = page.referrals_panel.find { |p| p.blue_streak_seal? == true }
            if !panel.nil?
              panel.blue_streak_seal = true
              panel.reason_for_applying_seal = 'test'
              panel.seal_authorized_by = 0
              panel.apply_seal
              page.wait_for_processing_overlay_to_close
              page.wait_for_ajax
              page.scroll.to :top
            end
            if panel.nil?
              panel = page.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == "AWAITING REVIEW" } }
              counter = panel.referrals.count
              counter.times do
                panel = page.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == "AWAITING REVIEW" } }
                if !panel.nil?
                  question = panel.referrals.find { |question| question.status == "AWAITING REVIEW" }
                  question.review
                  question.span(text: 'Approve').double_click
                  question.comments = "test"
                  question.save
                end
              end
            end
          end
        end
      end
    end
  end
  # BEGIN ISSUANCE
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  #@premium = on(QuoteManagementPage).quote_total_premium # used in some steps to compare later.  MOVED this to fully issue step
  on(QuoteManagementPage).resolve_issues_to_resolve

  # ANSWER UNDERWRITER QUESTIONS
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
  end
  on(QuoteManagementPage).underwriting_questions_tab
  # on(PolicyManagementPage).left_nav.navigate_to("Underwriting Questions")
  # on(UnderwritingQuestionsSummaryPage).all_products_issues_to_resolve # AMN 6-29-2021 Account Underwriting Questions Have Been Removed
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_home

  # # BILLING
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Billing & Payment Options')
  # on(PaymentOptionsPage).resolve_issues_to_resolve

  # ORDER REPORTS
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Reports') unless page.page_header_text.include? "Reports"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on("Reports")
  on(ReportsPage).resolve_issues_to_resolve_home

  #on(PolicyManagementPage).refresh_alerts

  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    page.issue
  end

  on(AutoPolicySummaryPage).navigate_issue_wizard
end

And(/^I resolve all issues except underwriting questions$/) do
  # BEGIN ISSUANCE
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  #@premium = on(QuoteManagementPage).quote_total_premium # used in some steps to compare later.  MOVED this to fully issue step
  on(QuoteManagementPage).resolve_issues_to_resolve
end

When(/^I click the issue button in the left nav$/) do
  on(PolicyIssuancePage).click_issue_policy
end

When(/^I finish issuing the policy after adding billing account$/) do
  on(AutoPolicySummaryPage) do |page|
    page.issue_wizard_modal.next_button if page.issue_wizard_modal.billing_section?
    if page.issue_wizard_modal.signature_request_section?
      section = page.issue_wizard_modal.signature_request_section
      section.navigate_defaults
      page.issue_wizard_modal.next_button
    end
    page.issue_wizard_modal.submit_button if page.issue_wizard_modal.review_section?
    Watir::Wait.while { page.issue_wizard_modal.submit_button_element.present? }
    page.policies_issued_modal.to_account_summary
  end
end

Then(/^Issue button should not be enabled on "([^"]*)" page$/) do |opt|
  on(PolicyManagementPage).left_nav.navigate_to(opt)
  on(AutoPolicySummaryPage) do |page|
    page.wait_for_ajax
    expect(page.issue_element.disabled?).to be_truthy
  end
end

And(/^I save premium after issuing the policy completely from "([^"]*)" page$/) do |opt|
  on(PolicyManagementPage) do |page|
    #this is a hack to get this going today, will refactor later. #toggle quotes

    collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
    page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"

    page.left_nav.navigate_to(opt)
  end
  @premium = on(AutoPolicySummaryPage).quote_premium
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Account Overview') unless page.page_header_text.include? "Account Summary"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on("Account Overview")
end

When(/^I fully issue the scheduled property policy$/) do
  # BEGIN ISSUANCE
  on(PolicyManagementPage) do |page|
    @browser.refresh
    page.wait_for_ajax
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
  end
  on(QuoteManagementPage).wait_for_ajax
  on(QuoteManagementPage).underwriting_questions_tab
  # on(UnderwritingQuestionsSummaryPage).all_products_issues_to_resolve # AMN 6-29-2021 Account Underwriting Questions Have Been Removed
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_scheduled_property

  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end

  on(CMIEmployeesSummaryPage).wait_for_ajax

  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.each do |panel|
        panel.referrals.each do |question|
          if question.status.downcase.include? "awaiting review"
            on(CMIEmployeesSummaryPage).wait_for_ajax
            question.review
            question.span(text: 'Approve').double_click
            question.comments = "test"
            question.save
          end
        end
      end
    end
  end

  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    @browser.refresh
    page.wait_for_ajax
    page.issue
    page.wait_for_ajax
    page.thank_you_modal.close if page.thank_you_modal.present?
    @browser.refresh
    page.wait_for_ajax
  end
  on(AutoPolicySummaryPage).navigate_issue_wizard
end

Then(/^I finish issuing the policies$/) do
  #on(PolicyManagementPage).refresh_alerts
  @browser.refresh
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
    page.premium_change_toast_close if page.premium_change_toast_close?
  end
  on(QuoteManagementPage).issue
  on(AutoPolicySummaryPage).navigate_issue_wizard

end

And(/^I begin issuance on policy change$/) do
  on(QuoteManagementPage) do |page|
    if page.uw_referrals_error_message?
      if page.view_underwriting_referrals?
        page.view_underwriting_referrals
        page.wait_for_modal_or_error
      end
    end
  end
  on(PolicyManagementPage) do |page|
    if page.underwriting_referrals_modal?
      modal = page.underwriting_referrals_modal
      counter = modal.referrals_panel.count
      if counter > 0
        counter.times do
          panel = modal.referrals_panel.find { |p| p.blue_streak_seal? == true }
          if !panel.nil?
            panel.blue_streak_seal = true
            panel.reason_for_applying_seal = 'test'
            panel.seal_authorized_by = 0
            panel.apply_seal
            page.wait_for_processing_overlay_to_close
            page.wait_for_ajax
            page.scroll.to :top
          end
          if panel.nil?
            panel = modal.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == "AWAITING REVIEW" } }
            counter = panel.referrals.count
            counter.times do
              panel = modal.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == "AWAITING REVIEW" } }
              if !panel.nil?
                question = panel.referrals.find { |question| question.status == "AWAITING REVIEW" }
                question.review
                question.span(text: 'Approve').double_click
                question.comments = "test"
                question.save
              end
            end
          end
        end
      end
      modal.close
      page.wait_for_ajax
    end
  end
  on(QuoteManagementPage) do |page|
    page.check_all_quoted
    page.submit_changes
    page.product_checkbox.check
    page.review_and_submit_policy
    page.go_to_account_summary
  end
end

And(/^I start issue policy change$/) do
  on(QuoteManagementPage) do |page|
    @browser.refresh
    page.wait_for_ajax
    2.times do
      page.scroll.to :bottom
      page.scroll.to :top
    end
    page.check_all_quoted
    page.submit_changes
  end
end

And(/^I fully issue the home policy with annual billing payment$/) do
  #Need to Nav to Quote options to generate referralls
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  on(PolicyManagementPage).wait_for_ajax

  # ANSWER UNDERWRITER REFERRALS - if any
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  # on(CMIEmployeesSummaryPage).underwriting_referrals_tab

  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.each do |question|
        # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
        question.review
        question.span(text: 'Approve').double_click
        question.comments = "test"
        # question.review_section.approval_status = "Approve"
        question.save
      end
    end
  end

  # BEGIN ISSUANCE
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  #@premium = on(QuoteManagementPage).quote_total_premium # used in some steps to compare later.  MOVED this to fully issue step
  on(QuoteManagementPage).resolve_issues_to_resolve

  # ANSWER UNDERWRITER QUESTIONS
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
  end
  on(QuoteManagementPage).underwriting_questions_tab
  # on(PolicyManagementPage).left_nav.navigate_to("Underwriting Questions")
  # on(UnderwritingQuestionsSummaryPage).all_products_issues_to_resolve # AMN 6-29-2021 Account Underwriting Questions Have Been Removed
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_home

  # # BILLING
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Billing & Payment Options')
  # on(PaymentOptionsPage).resolve_issues_to_resolve

  # ORDER REPORTS
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Reports') unless page.page_header_text.include? "Reports"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on("Reports")
  on(ReportsPage).resolve_issues_to_resolve_home

  #on(PolicyManagementPage).refresh_alerts

  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    page.issue
  end

  on(AutoPolicySummaryPage).navigate_issue_wizard_annual
end

And(/^I fully issue the dwelling policy$/) do

  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  on(PolicyManagementPage).wait_for_ajax

  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.each do |panel|
        panel.referrals.each do |question|
          if question.status.downcase.include? "awaiting review"
            on(CMIEmployeesSummaryPage).wait_for_ajax
            question.review
            question.span(text: 'Approve').double_click
            question.comments = "test"
            question.save
          end
        end
      end
    end
  end

  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  on(QuoteManagementPage).resolve_issues_to_resolve

  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text.include? "Quote Management"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(QuoteManagementPage).underwriting_questions_tab
  # on(UnderwritingQuestionsSummaryPage).all_products_issues_to_resolve # AMN 6-29-2021 Account Underwriting Questions Have Been Removed
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_dwelling

  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Reports') unless page.page_header_text.include? "Reports"
  end
  on(ReportsPage).resolve_issues_to_resolve_home
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.each do |panel|
        panel.referrals.each do |question|
          if question.status.downcase.include? "awaiting review"
            on(CMIEmployeesSummaryPage).wait_for_ajax
            question.review
            question.span(text: 'Approve').double_click
            question.comments = "test"
            question.save
          end
        end
      end
    end
  end
  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    page.issue
  end

  on(AutoPolicySummaryPage).navigate_issue_wizard
end

And(/^I fully issue the watercraft policy$/) do
  #Need to Nav to Quote options to generate referralls
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  on(PolicyManagementPage).wait_for_ajax

  # ANSWER UNDERWRITER REFERRALS - if any
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  # on(CMIEmployeesSummaryPage).underwriting_referrals_tab

  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.each do |question|
        # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
        question.review
        question.span(text: 'Approve').double_click
        question.comments = "test"
        # question.review_section.approval_status = "Approve"
        question.save
      end
    end
  end

  # BEGIN ISSUANCE
  on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  #@premium = on(QuoteManagementPage).quote_total_premium # used in some steps to compare later.  MOVED this to fully issue step
  on(QuoteManagementPage).resolve_issues_to_resolve

  # ANSWER UNDERWRITER QUESTIONS
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text.include? "Quote Management"
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(QuoteManagementPage).underwriting_questions_tab
  # on(PolicyManagementPage).left_nav.navigate_to("Underwriting Questions")
  # on(UnderwritingQuestionsSummaryPage).all_products_issues_to_resolve # AMN 6-29-2021 Account Underwriting Questions Have Been Removed
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_watercraft

  # # BILLING
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Billing & Payment Options')
  # on(PaymentOptionsPage).resolve_issues_to_resolve

  # ORDER REPORTS
  #on(PolicyManagementPage).left_navigate_to_if_not_on("Reports")
  #on(ReportsPage).resolve_issues_to_resolve_home

  on(PolicyManagementPage).left_nav.navigate_to_first_product
  on(AutoPolicySummaryPage) do |page|
    page.issue
  end
  on(AutoPolicySummaryPage).navigate_issue_wizard
end

Then(/^I Issue Policy Change$/) do
  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :top
    page.issue_policy_change
  end
end

Then(/^I navigate till issue wizard policy distribution modal and validate it$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to('Quote Management') unless page.page_header_text == "Quote Management"
    page.premium_change_toast_close if page.premium_change_toast_close?
  end
  @browser.refresh
  on(QuoteManagementPage).issue
  on(AutoPolicySummaryPage) do |page|
    issue unless page.issue_wizard_modal.present?
    page.wait_for_ajax
    modal = page.issue_wizard_modal
    section = modal.select_product_section
    section.navigate_defaults
    modal.next_button
    Watir::Wait.while(timeout: 120) { section.present? }
    section = modal.distribution_section
    section.set_distribution_by_product = true
    section.products_distribution.first.distribution_type = 'Email'
    section.products_distribution.first.send_to = 1
    section.products_distribution.last.distribution_type = 'Paper'
    section.products_distribution.last.new_product_send_to = 'Agency'
    section.products_distribution.last.renewals_send_to = 'Insured'
    expect(section.terms_and_conditions?).to be_truthy
    modal.next_button
    Watir::Wait.while(timeout: 120) { section.present? }
  end

end