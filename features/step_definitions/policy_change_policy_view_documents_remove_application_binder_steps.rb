# frozen_string_literal: true

Then(/^I (should|should not) see following documents in "([^"]*)" section$/) do |which, section, table|
  row = table.raw.first
  on(DocumentsPage) do |page|
    item = page.docs_list.headers.find { |e| e.text.include? section }
    if item != nil
      header_text = page.docs_list.headers.find { |e| e.text.include? section }.text
      counter = page.docs_list.item_count_from_header(header_text).to_i
      documents = []
      doc_count = 0
      counter.times do
        if item.following_sibling.td.child(name: 'chkItem').present?
          documents << item.following_sibling.div(class: 'documentNameText').text
          item = item.following_sibling
          doc_count = doc_count + 1
        end
        doc_count
        documents
      end
      # first_text = page.forms_to_retain_grid.items.first.text.downcase
      # available = if first_text.include? "no data"
      #               false # no data available string
      #             else
      #               page.send("#{section}").items.map { |x| x.text }
      #             end
      if which == 'should'
        row.each do |item|
          expect(documents.include? item).to be_truthy, "Expected to find: \"#{item}\" document in the \"#{section}\" section!"
        end
      else
        row.each do |item|
          expect(documents.include? item).to be_falsey, "Expected NOT to find \"#{item}\", but there is something in the grid."
        end
      end
    else
      if which == 'should'
        expect(item).not_to be_nil, "Expected to find: \"#{section}\" section!"
      end
    end
  end
end

Then(/^I issue the policy fully$/) do
  # ANSWER UNDERWRITER QUESTIONS
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(QuoteManagementPage).underwriting_questions_tab

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

  #on(PolicyManagementPage).refresh_alerts

  # ANSWER UNDERWRITER REFERRALS
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  #on(CMIEmployeesSummaryPage).underwriting_referrals_tab
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.each do |question|
        # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
        question.review
        question.approval_status = "Approve"
        question.comments = "test"
        question.save
      end
    end
  end

  #on(PolicyManagementPage).refresh_alerts

  on(PolicyManagementPage).left_nav.navigate_to_first_product

  on(AutoPolicySummaryPage).navigate_issue_wizard
end
