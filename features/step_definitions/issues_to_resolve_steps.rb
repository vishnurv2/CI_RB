# frozen_string_literal: true

Then(/^I should see an issue to resolve containing "([^"]*)"$/) do |issue_text|
  on(PolicyManagementPage) do |page|
    @browser.refresh
    page.wait_for_ajax
    page.issue_to_resolve
    page.wait_for_ajax
    expect(page.alerts_side_bar.issues_needing_resolved_section.issue_needing_resolved_exists issue_text).to be_truthy, "Expected an issue needing resolved containing the text \"#{issue_text}\" to appear on the Issues to Resolve page, but it did not."
  end
end

When(/^I open the issue to resolve containing "([^"]*)"$/) do |issue_text|
  on(PolicyManagementPage) do |page|
    issue = page.alerts_side_bar.issues_needing_resolved_section.find_issue_needing_resolved(issue_text.downcase)
    expect(issue).not_to be_nil, "Expected to find an issue to resolve containing the text #{issue_text}, but it was not found"
    issue.click
  end
end

Then(/^The issues to resolve should load the appropriate modals$/) do |table|
  on(PolicyManagementPage) do |page|
    @browser.refresh
    page.issue_to_resolve
    page.wait_for_ajax
    table.hashes.each do |h|
      issue = page.alerts_side_bar.issues_needing_resolved_section.find_issue_needing_resolved(h[:issue])
      expect(issue).not_to be_nil, "Expected to find an issue to resolve containing the text #{h[:issue]}, but it was not found"
      issue_text = issue.text
      issue.click
      Watir::Wait.until(message: "attempted to click \"#{issue_text},\" timed out waiting for #{h[:modal]} to appear") { page.send("#{h[:modal].snakecase}?") }
      expect(page.send("#{h[:modal].snakecase}?")).to be_truthy, "Expected the issue stating \"#{issue_text}\" to load the #{h[:modal]}"
      page.send("#{h[:modal].snakecase}").send("dismiss")
    end
  end
end

Then(/^The issues to resolve should load the appropriate pages$/) do |table|
  on(PolicyManagementPage) do |page|
    # page.left_nav.bell_icon_element.click unless page.alerts_side_bar?
    @browser.refresh
    page.issue_to_resolve
    page.wait_for_ajax
    table.hashes.each do |h|
      issue = page.alerts_side_bar.issues_needing_resolved_section.find_issue_needing_resolved(h[:issue])
      expect(issue).not_to be_nil, "Expected to find an issue to resolve containing the text #{h[:issue]}, but it was not found"
      issue_text = issue.text
      issue.click
      on("#{h[:page].snakecase}".to_page_class) do |page|
        expect(page.displayed?).to be_truthy, "Expected the issue stating \"#{issue_text}\" to load the #{h[:page]}"
      end
      page.issue_to_resolve
      page.wait_for_ajax
    end
  end
end

And(/^I resolve the issues to resolve$/) do
  # ANSWER UNDERWRITER QUESTIONS
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
  on(UnderwritingQuestionsSummaryPage).resolve_issues_to_resolve
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_umbrella

  # ORDER REPORTS
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Reports"
      page.left_nav.navigate_to('Reports')
    end
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
        question.span(text: 'Approve').double_click
        question.comments = "test"
        question.save
      end
    end
  end

  # on(PolicyManagementPage).left_nav.navigate_to_first_product
end

Then(/^I should see (.*) on issues to resolve page$/) do |issue_message|
  on(PolicyManagementPage) do |page|
    page.issue_to_resolve
    # page.left_nav.bell_icon_element.click
    page.wait_for_ajax
    alerts_panel = page.alerts_side_bar
    issue = alerts_panel.issues_needing_resolved_section.find_issue_needing_resolved(issue_message)
    expect(issue).not_to be_nil, "Expected to find an issue to resolve containing the text #{issue_message}, but it was not found"
  end
end

Then(/^I should not see any issues on issues to resolve page$/) do
  on(PolicyManagementPage) do |page|
    #page.left_nav.bell_icon_element.click unless page.alerts_side_bar?
    expect(page.left_nav.issues_to_resolve?).to be_falsey
    page.wait_for_ajax
    #expect(page.alerts_side_bar.happy_alert_bell?).to be_truthy
    #expect(page.alerts_side_bar.no_issues_title).to eq("You're all caught up!")
    #expect(page.alerts_side_bar.no_issues_subtext).to eq("There are currently no issues to resolve.")
    #page.left_nav.issues_to_resolve_element.click if page.alerts_side_bar?
  end
end

Then(/^I should see the following issue messages on alerts side bar$/) do |table|
  on(PolicyManagementPage) do |page|
    expected = table.raw.flatten
    page.left_nav.issues_to_resolve_element.click
    page.wait_for_ajax
    Watir::Wait.until { page.alerts_side_bar.issues_needing_resolved_section? }
    alerts_panel = page.alerts_side_bar
    expected.each do |message|
      issue = alerts_panel.issues_needing_resolved_section.find_issue_needing_resolved(message)
      expect(issue).not_to be_nil, "Expected to find an issue to resolve containing the text #{message}, but it was not found"
    end
    page.issues_to_resolve_close_button_element.click if page.alerts_side_bar?
  end
end

Then(/^I validate issues to resolve and resolve it$/) do
  on(PolicyManagementPage) do |page|
    data = data_for("scheduled_property_classes_modal")
    unless page.page_header_text.include? "IN - Scheduled Property"
      page.left_nav.navigate_to('IN - Scheduled Property')
    end
    page.issue_to_resolve
    page.wait_for_ajax
    alerts_panel = page.alerts_side_bar
    issue_message = "Scheduled and Agreed amounts must equal what was quoted for Bicycles."
    issue = alerts_panel.issues_needing_resolved_section.find_issue_needing_resolved(issue_message)
    issue.click
    page.wait_for_ajax
    modal = page.scheduled_property_classes_modal
    modal.bicycles_item_amount = data['bicycles_agreed_amount']
    modal.save_and_close
  end
end

Then(/^I should see (.*) present on alert side bar$/) do |issue_messages|
  on(PolicyManagementPage) do |page|
    page.left_nav.issues_to_resolve_element.click
    page.wait_for_ajax
    Watir::Wait.until { page.alerts_side_bar.issues_needing_resolved_section? }
    alerts_panel = page.alerts_side_bar
      issue = alerts_panel.issues_needing_resolved_section.find_issue_needing_resolved(issue_messages)
      expect(issue).not_to be_nil, "Expected to find an issue to resolve containing the text #{issue_messages}, but it was not found"
    page.issues_to_resolve_close_button_element.click if page.alerts_side_bar?
  end
end

Then(/^I click on reports issues from Issue to resolve panel$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.issues_to_resolve_element.click
    page.wait_for_ajax
    modal = page.issues_to_resolve_modal
    modal.mvr_report_element.click
  end
end