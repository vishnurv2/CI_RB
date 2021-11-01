# frozen_string_literal: true

Then(/^I should see a (red|green) underwriting referral stating "([^"]*)"$/) do |color, message|
  on(QuoteOptionsPage) do |page|
    expect(page.uw_ref_section.alerts).to include(message)
    expect(page.uw_ref_section.send("#{color}?")).to be_truthy, "Underwriting referral is not #{color}"
  end
end

Then(/^I should see an underwriting referrals message stating "([^"]*)"$/) do |message|
  on(CMIEmployeesSummaryPage) do |page|
    expect(page.referrals_panel.referral_messages).to include(message)
  end
end

When(/^I mark the referral for "([^"]*)" as "([^"]*)" with the note of "([^"]*)"$/) do |message, status, note|
  @referral_message = message
  # @referral_status = status == 'Approved' ? 'Pending approval' : status # selecting "Approved" should expect the result to be "Approved", "Pending approval" is used before a selection is made
  @referral_status = status # selecting "Approved" should expect the result to be "Approved", "Pending approval" is used before a selection is made
  @referral_note = note
  on(CMIEmployeesSummaryPage) do |page|
    page.referrals_panel.find_referral(message).edit
    page.referral_modal.populate_with(status: status, notes: note)
    page.referral_modal.save_and_close
  end
end

Then(/^the referral should reflect my changes in the referral grid$/) do
  on(CMIEmployeesSummaryPage) do |page|
    ref = page.referrals_panel.find_referral(@referral_message)
    expect(ref.status).to eq(@referral_status)
    expect(ref.notes).to eq(@referral_note)
    # This will match strings in the form of: 03/04/2019 2:59 PM by Sally Generic
    rev_regex = /\d+\/\d+\/\d\d\d\d \d+:\d+\s(A|P)M\s+by\s\w+\s\w+/
    expect(ref.reviewed).to match(rev_regex)
  end
end

And(/^I (Approve|Decline) all referrals$/) do |status|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    unless page.page_header_text.include? "Referrals"
      page.left_nav.navigate_to('Referrals')
    end
  end
  on(CMIEmployeesSummaryPage).set_all_referral_statuses_to(status)
end

And(/^The CMI Employees page should have an underwriting referral containing "([^"]*)"$/) do |referral_message|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    unless page.page_header_text.include? "Referrals"
      page.left_nav.navigate_to('Referrals')
    end
    # page.left_navigate_to_if_not_on('Referrals')
  end
  on(CMIEmployeesSummaryPage) do |page|
    found_referral = page.referrals_panel.referrals_grid.items.find { |referral| referral.message.downcase.include? referral_message }
    expect(found_referral).not_to be_nil, "Expected to find a referral containing the text \"#{referral_message}\" but it was not found"
  end
end

And(/^I resolve all the underwriter referrals$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    on(CMIEmployeesSummaryPage) do |page|
      counter = page.referrals_panel.count
      counter.times do
        panel = page.referrals_panel.find { |panel| panel.referrals.first.status == "AWAITING REVIEW" }
        panel.referrals.each do |question|
          # page.expand_each_policy_referrals
          question.review
          question.span(text: 'Approve').double_click
          question.comments = "test"
          question.save
        end
      end
    end
  end
end

And(/^I verify contact underwriter button and send email modal details on referrals modal$/) do
  on(QuoteManagementPage) do |page|
    page.view_underwriting_referrals
    page.wait_for_modal_or_error
  end
  on(PolicyManagementPage) do |page|
    modal = page.underwriting_referrals_modal
    expect(modal.contact_underwriter?).to be_truthy
    modal.contact_underwriter
    page.wait_for_ajax
    expect(page.log_activity_modal?).to be_truthy
    modal = page.log_activity_modal
    #expect(modal.email_from_element.present?).to be_truthy
    #expect(modal.email_to_element.present?).to be_truthy
    expect(modal.subject_element.present?).to be_truthy
    expect(modal.related_to_element.present?).to be_truthy
    modal.close
    page.wait_for_ajax
  end
end

And(/^I verify UW info details on referrals modal$/) do
  on(QuoteManagementPage) do |page|
    page.view_underwriting_referrals
    page.wait_for_modal_or_error
  end
  on(PolicyManagementPage) do |page|
    modal = page.underwriting_referrals_modal
    expect(modal.uw_name.present?).to be_truthy
    expect(modal.uw_title.present?).to be_truthy
    expect(modal.uw_phone.present?).to be_truthy
    expect(modal.uw_email_element.present?).to be_truthy
    modal.close
    page.wait_for_ajax
  end
end

And(/^I verify UW info details on referrals page$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    unless page.page_header_text.include? "Referrals"
      page.left_nav.navigate_to('Referrals')
    end
  end
  on(CMIEmployeesSummaryPage) do |page|
    expect(page.uw_name.present?).to be_truthy
    expect(page.uw_title.present?).to be_truthy
    expect(page.uw_phone.present?).to be_truthy
    expect(page.uw_email_element.present?).to be_truthy
  end
end

Then(/^I verify contact underwriter button and send email modal details on referrals page$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    unless page.page_header_text.include? "Referrals"
      page.left_nav.navigate_to('Referrals')
    end
  end
  on(CMIEmployeesSummaryPage) do |page|
    expect(page.contact_underwriter?).to be_truthy
    page.contact_underwriter
    page.wait_for_ajax
    expect(page.log_activity_modal?).to be_truthy
    modal = page.log_activity_modal
    #expect(modal.email_from_element.present?).to be_truthy
    #expect(modal.email_to_element.present?).to be_truthy
    expect(modal.subject_element.present?).to be_truthy
    expect(modal.related_to_element.present?).to be_truthy
    modal.close
    page.wait_for_ajax
  end
end

And(/^I validate that contact underwriter button is not present$/) do
  on(QuoteManagementPage) do |page|
    page.view_underwriting_referrals
    page.wait_for_modal_or_error
  end
  on(PolicyManagementPage) do |page|
    modal = page.underwriting_referrals_modal
    expect(modal.contact_underwriter?).to be_falsey
    modal.close
    page.left_nav.find_option("Referrals").scroll.to
    unless page.page_header_text.include? "Referrals"
      page.left_nav.navigate_to('Referrals')
    end
  end
  on(CMIEmployeesSummaryPage) do |page|
    expect(page.contact_underwriter?).to be_falsey
  end
end