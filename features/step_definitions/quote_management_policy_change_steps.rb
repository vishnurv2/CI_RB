# frozen_string_literal: true

Then(/^I should see my change in the product table$/) do
  on(QuoteManagementPage) do |page|
    has_items = page.products_has_items.positive?
    expect(has_items).to be_truthy, "Expected Summary of Changes to have product changes.."
  end
end

And(/^I add a policy change with "([^"]*)"$/) do |text|
  on(AccountSummaryPage) do |page|
    # page.product_list.add_policy_change_element.scroll.to :center
    # page.product_list.add_policy_change
    # modal = page.product_list.add_policy_change_modal
    modal = page.add_policy_change_modal
    modal.specific_date = Date.today.to_date.strftime('%m/%d/%Y')
    # modal.specific_date_text= Date.today
    modal.date.span(text: text).click
    modal.description = 'add deductible' #just add something for now....
    modal.save_and_continue_button
  end
end

And(/^I submit changes$/) do
  on(QuoteManagementPage).submit_changes
end

Then(/^I should see a policy change message containing the text "([^"]*)"$/) do |policy_change_message|
  on(QuoteManagementPage) do |page|
    has_message = page.product_grid.items.any? { |row| row.lis.any? { |l| l.text.downcase.include? policy_change_message.downcase } }
    expect(has_message).to be_truthy, "Expected to Find a Policy Change with a Message Containing the Text #{policy_change_message}, but It Was Not Found"
  end
end

#WIP
Then(/^I verify and submit the changes on quote management page$/) do
  on(PolicyManagementPage) do |page|
    #this is a hack to get this going today, will refactor later. #toggle quotes

    collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
    page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"

    page.left_nav.navigate_to("Open Policy Changes")
  end
  # on(PolicyManagementPage).left_nav.navigate_to('Quote Management')
  on(QuoteManagementPage) do |page|
    page.wait_for_ajax
    page.scroll.to :top
    premium = page.policy_change_quote_section.premium
    # quote_premium_difference = page.policy_change_quote_section.quote_premium
    current_annual_premium = page.policy_change_summary_section.current_annual_premium
    new_annual_premium = page.policy_change_summary_section.new_annual_premium
    difference_in_premium = page.policy_change_summary_section.difference_in_premium
    difference = new_annual_premium.delete('$').delete(',').to_i - current_annual_premium.delete('$').delete(',').to_i
    expect(premium).to eq(new_annual_premium)
    expect(difference).to eq(difference_in_premium.delete('$').delete(',').to_i)
    # expect(difference_in_premium).to eq(difference)
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
      @browser.refresh
      page.wait_for_ajax
    end
  end

  on(QuoteManagementPage) do |page|
    page.check_all_quoted
    sleep(0.3)
    page.submit_change
    page.wait_for_ajax
  end
  # on(AutoPolicySummaryPage).navigate_issue_wizard
  on(AutoPolicySummaryPage) do |page|
    modal = page.review_and_submit_policy_change
    modal.submit
    page.wait_for_ajax
  end
  on(PolicyManagementPage) do |page|
    modal = page.policy_change_issued_modal
    modal.go_to_account_summary
  end
end

Then(/^I click on policy change link$/) do
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(AccountSummaryPage) do |page|
    @found_product = page.product_list.products.first
    @found_product.right_arrow_element.click if @found_product.right_arrow_element.present?
    @found_product.following_sibling.td(data_label: 'Name').link.click
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^the initial premium should differ from the new premium$/) do
  on(QuoteManagementPage) do |page|
    @browser.refresh
    page.wait_for_processing_overlay_to_close
    new_premium = page.quote_total_premium
    current_annual_premium = page.policy_change_summary_section.current_annual_premium
    expect(current_annual_premium).not_to eq(new_premium), "These two premiums should not equal! Initial Premium: #{@premium}, premium after Policy Change: #{new_premium}"
  end
end

Then(/^the initial premium should not differ from the new premium$/) do
  on(QuoteManagementPage) do |page|
    @browser.refresh
    page.wait_for_processing_overlay_to_close
    new_premium = page.quote_total_premium
    current_annual_premium = page.policy_change_summary_section.current_annual_premium
    expect(current_annual_premium).to eq(new_premium), "These two premiums should be equal!!!! First premium: #{@premium}, new premium: #{new_premium}"
  end
end

And(/^the summary of changes premium should equal total premium$/) do
  on(QuoteManagementPage) do |page|
    new_premium = page.quote_total_premium
    summary_premium = page.policy_change_summary_section.new_annual_premium

    old_premium = @premium
    summary_old_premium = page.policy_change_summary_section.current_annual_premium

    expect(summary_premium).to eq(new_premium), "Expected the Summary of Changes new annual premium (#{new_premium}) to equal the Total premium (#{summary_premium})"
    expect(summary_old_premium).to eq(old_premium), "Expected the Summary of Changes old annual premium (#{summary_old_premium}) to equal the original calculated premium (#{old_premium})"
  end
end

And(/^I validate policy change message for optional coverages$/) do
  on(QuoteManagementPage) do |page|
    expect(page.policy_change_summary_section.policy_change_reason_message).to eq("Changed Limited Fungi Wet or Dry Rot or Bacteria Coverage Liability Limit from $0.00 to $50,000.00")
  end
end