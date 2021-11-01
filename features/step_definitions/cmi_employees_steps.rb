# frozen_string_literal: true

Then(/^I can view the referral$/) do
  on(CMIEmployeesSummaryPage) do |page|
    page.referrals_panel.each do |item|
      expect(item.referrals.count).not_to be_nil
      item.referrals.first.review_element.click unless item.referrals.first.review_icon_down?
      expect(item.referrals.first.review_section?).to be_truthy
    end
  end
end

Then(/^I should see overrides available$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    page.pry
    STDOUT.puts ''
  end
end

Then(/^I should see (\d+) override panels$/) do |count|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    expect(page.overrides_panels.count).to eq(count.to_i)
  end
end

And(/^each override panel should include (\d+) vehicle override panel$/) do |count|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    RSpec.capture_assertions do
      page.overrides_panels.each do |panel|
        expect(panel.vehicle_count).to eq(count.to_i)
      end
    end
  end
end

And(/^I apply a (.*) override on vehicle (\d+) in panel (\d+)$/) do |override_type, vehicle_no, panel_no|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    page.wait_for_processing_overlay_to_close
    panel = page.overrides_panels[panel_no.to_i - 1]
    # panel_name = (override_type.downcase.include? 'tier') ? "vehicle_panels" : "#{override_type.downcase.snakecase}_panels"
    # panel_type = panel.send(panel_name)[vehicle_no.to_i - 1]
    # panel_type.override
    # panel_type.override_territory.set('002') if panel_type.override_type.downcase.include? 'territory'
    # panel_type.override_tier_element.click
    # panel_type.override_tier.set('Merit') if panel_type.override_type.downcase.include? 'tier'
    # panel_type.set_effective_date
    # panel_type.notes_element.set("not applicable")
    # panel_type.save

    override = panel.overrides_with_text(override_type)[vehicle_no.to_i - 1]
    override.edit
    data = (override_type.downcase == 'territory') ? { override_territory: '002', notes: 'test notes' } : { override_tier: 'Merit', notes: 'test notes' }
    override.populate_with(data)
    override.save
    page.wait_for_ajax
    @modified_override_details = { status: override.status, effective_date: override.override_effective_date }
    @browser.refresh
    page.wait_for_ajax
    #page.overrides_tab
  end
end

Then(/^I should see the (.*) override that I applied on vehicle (\d+) in panel (\d+)$/) do |override_type, vehicle_no, panel_no|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    panel = page.overrides_panels[panel_no.to_i - 1]
    override = panel.overrides_with_text(override_type)[vehicle_no.to_i - 1]
    # panel_name = (override_type.downcase.include? 'tier') ? "vehicle_panels" : "#{override_type.downcase.snakecase}_panels"
    # panel_type = panel.send(panel_name)[vehicle_no.to_i - 1]
    RSpec.capture_assertions do
      expect(override.status).to eq(@modified_override_details[:status])
      expect(override.override_effective_date).to eq(@modified_override_details[:effective_date])
    end
  end
end

When(/^I apply the "([^"]*)" override in panel (\d+)$/) do |type, panel_no|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text == "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    panel = page.overrides_panels[panel_no.to_i - 1]
    override_row = panel.overrides.find { |i| i.text.downcase.include? type.downcase }
    override_row.edit
    override_row.override_territory.set('002') if type.downcase.include? 'territory'
    override_row.customer_loyalty.set('4 years') if type.downcase.include? 'customer'
    override_row.override_tier.set('Merit') if type.downcase.include? 'tier'
    override_row.package_discount_applied.set('Yes with 3 - Special') if type.downcase.include? 'package discount'
    #Need to write for Package discount once its functionality is developed.
    #panel_type.override_package.set('Package') if panel_type.override_type.downcase.include? 'package'
    # override_row.effective_date = Chronic.parse("today").strftime('%m/%d/%Y')
    override_row.notes_element.set("not applicable")
    override_row.save
  end
end

Then(/^I should see the override invalid date validation message$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    expect(page.send("#{@last_modal_type.snakecase}_modal?") && page.send("#{@last_modal_type.snakecase}_modal").present? && page.send("#{@last_modal_type.snakecase}_modal").validation_message? && page.send("#{@last_modal_type.snakecase}_modal").validation_message_element.present?).to be_truthy, "Expected a validation message to be on the effective date on the #{@last_modal_type} modal but it could not be found"
  end
end

And(/^I resolve any underwriter referrals$/) do
  # ANSWER UNDERWRITER REFERRALS - if any
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  #on(CMIEmployeesSummaryPage).underwriting_referrals_tab

  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.each do |panel|
        panel.referrals.each do |question|
          # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
          # toggler = panel.button(class: 'p-panel-toggler')
          # toggler.click if toggler.attributes[:aria_expanded] == 'false'
          # Watir::Wait.while { panel.div(class: 'ng-animating').present? }
          if question.status.downcase.include? "awaiting review"
            question.review
            question.span(text: 'Approve').double_click
            question.comments = "test"
            question.save
          end
        end
      end
      # on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.each do |question|
      #   question.click
      #   question.review_section.approval_status = "Approve"
      #   question.review_section.save
      # end
    end
  end
end

Then(/^I should see (.*) on cmi employees page$/) do |referral_message|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  #on(CMIEmployeesSummaryPage).underwriting_referrals_tab
  if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
    expect(on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.find { |i| i.message == referral_message }).to be_truthy, "The referral message \"#{referral_message}\" is not displayed"
  end
end

Then(/^I should see (.*) on underwriting referrals modal$/) do |referral_message|
  on(QuoteManagementPage) do |page|
    page.view_underwriting_referrals
    page.wait_for_modal_or_error
  end
  on(PolicyManagementPage) do |page|
    modal = page.underwriting_referrals_modal
    sleep(2)
    modal.referrals_panel.first.filter_dropdown = 1 if modal.referrals_panel.first.filter_dropdown_element.present?
    sleep(2)
    expect(modal.referrals_panel.first.referrals.find { |i| i.message.include? referral_message }).to be_truthy, "The referral message \"#{referral_message}\" is not displayed"
  end
end

And(/^I should see the following referral messages on referrals page$/) do |table|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  on(CMIEmployeesSummaryPage) do |page|
    expected = table.raw.flatten
    if page.referrals_panel.first.referrals.count > 0
      expected.each do |message|
        expect(page.referrals_panel.find { |panel| panel.referrals.find { |i| i.message == message } }).to be_truthy, "The referral message \"#{message}\" is not displayed"
      end
    end
  end
end

And(/^I resolve any underwriter referrals using blue streak seal$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    unless page.page_header_text.include? "Referrals"
      page.left_nav.navigate_to('Referrals')
    end
    # page.left_navigate_to_if_not_on("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage) do |page|
        counter = page.referrals_panel.count
        if counter > 0
          counter.times do
            panel = page.referrals_panel.find { |p| p.blue_streak_seal? == true }
            panel.blue_streak_seal = true
            panel.reason_for_applying_seal = 'test'
            panel.seal_authorized_by = 0
            panel.apply_seal
            page.wait_for_processing_overlay_to_close
            page.wait_for_ajax
            page.scroll.to :top
          end
        end
      end
    end
  end
end

And(/^I resolve any underwriter referrals using blue streak seal or approvals$/) do
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_navigate_to_if_not_on("Referrals")
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
              if !panel.nil?
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
  end
end

And(/^I should see the following referral messages on referrals page after policy change$/) do |table|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  on(CMIEmployeesSummaryPage) do |page|
    expected = table.raw.flatten
    page.referrals_panel.first.filter_dropdown = 1 if page.referrals_panel.first.filter_dropdown_element.present?
    sleep(2)
    if page.referrals_panel.first.referrals.count > 0
      expected.each do |message|
        expect(page.referrals_panel.find { |panel| panel.referrals.find { |i| i.message == message } }).to be_truthy, "The referral message \"#{message}\" is not displayed"
      end
    end
  end
end

And(/^I verify table header checkbox is present$/) do
  on(CMIEmployeesSummaryPage) do |page|
    expect(page.referral_header_checkbox?).to be_truthy
  end
end

And(/^I verify each referral should have checkbox$/) do
  on(CMIEmployeesSummaryPage) do |page|
    expect(page.referrals_panel.find { |panel| panel.referrals.find { |checkbox| checkbox.referral_checkbox.present? } }).to be_truthy
  end
end

Then(/^I select one referral$/) do
  on(CMIEmployeesSummaryPage) do |page|
    page.referrals_panel.first.referrals.first.referral_checkbox.click
  end
end

And(/^I verify Review button should be appear$/) do
  on(CMIEmployeesSummaryPage) do |page|
    expect(page.review_button?).to be_truthy
  end
end

And(/^I select all the referrals and save the count of selected referrals$/) do
  on(CMIEmployeesSummaryPage) do |page|
    page.referrals_panel.find { |panel| panel.referrals.find { |checkbox| checkbox.referral_checkbox.click } }
    @selected_referrals = page.referrals_panel.first.referrals.count
  end
end

Then(/^I verify the selected count text$/) do
  on(CMIEmployeesSummaryPage) do |page|
    count = page.select_count
    expect(count).to eq(@selected_referrals.to_s+" referrals selected")
  end
end

Then(/^I click on Review button and Review referrals modal should appear$/) do
  on(CMIEmployeesSummaryPage) do |page|
    page.review_button
    expect(on(PolicyManagementPage).review_referrals_modal.present?).to be_truthy
  end
end

And(/^I put comment in comment section and approve it$/) do
  on(PolicyManagementPage) do |page|
    modal = page.review_referrals_modal
    modal.comments_area = 'Adding test comment'
    modal.approve
  end
end

And(/^I check the status should be updated to "([^"]*)"$/) do |status|
  on(CMIEmployeesSummaryPage) do |page|
    expect(page.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == status } }).to be_truthy
  end
end