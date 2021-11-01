# frozen_string_literal: true

Then(/^I should see the following reports available with the correct status$/) do |table|
  expected = table.rows.to_h
  on(ReportsPage) do |page|
    RSpec.capture_assertions do
      expected.each do |k, v|
        row = page.clue_prefill_mvr_section.find_report_by_type(k)&.first
        expect(row).not_to be_nil, "Expected to find a report row of type #{k}, but it could not be found"
        unless row.nil?
          actual = row.status
          expect(actual).to eq(v), "Expected status of #{v} for #{k} but it is #{actual}"
        end
      end
    end
  end
end

When(/^I order the "([^"]*)" report$/) do |report_type|
  on(ReportsPage).clue_prefill_mvr_section.order_reports_by_type(report_type)
end

Then(/^the status for the "([^"]*)" report should change to "([^"]*)"$/) do |report_type, status|
  on(ReportsPage) do |page|
    actual = page.clue_prefill_mvr_section.find_report_by_type(report_type)&.first.status
    expect(actual).to eq(status), "Expected status of #{status} for #{report_type} but it is #{actual}"
  end
end

And(/^the checkbox for ordering "([^"]*)" (should|should not) be enabled$/) do |report_type, which|
  on(ReportsPage) do |page|
    report = page.clue_prefill_mvr_section.find_report_by_type(report_type)
    expect(report.first.order_element.input.attribute_list.include?(:disabled)).to eq(which == 'should not')
  end
end

When(/^I order CLUE and MVR reports$/) do
  on(PolicyManagementPage).left_nav.navigate_to('Reports')
  on(ReportsPage).resolve_issues_to_resolve
  #on(PolicyManagementPage) do |page|
  # page.premium_change_toast_close if page.premium_change_toast_close?
  #end
end

# ------ Everything below this line is unverified ------------------------------------- #
# Put above this line when you have verified each step/component

And(/^the checkbox for ordering "([^"]*)" (should|should not) be visible$/) do |report_type, which|
  on(ReportsPage) do |page|
    report = page.clue_prefill_mvr_section.find_report_by_type(report_type)
    expect(report.first&.order?).to eq(which == 'should')
  end
end

And(/^I dispute the current report$/) do
  on(ReportsPage) do |page|
    page.auto_clue_modal.policy_losses_table.items.first.mark_for_dispute = true
    row = page.auto_clue_modal.policy_losses_dispute_reasons_table.items.first
    row.dispute_reason = 'Not At Fault'
    page.auto_clue_modal.save_and_close
  end
end

Then(/^I can view the disputed (Auto CLUE|Auto Prefill) report$/) do |report_type|
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.find_report_by_type(report_type).edit
    row = page.auto_clue_modal.policy_losses_table.items.first
    expect(row.mark_for_dispute).to be_truthy
    row = page.auto_clue_modal.policy_losses_dispute_reasons_table.items.first
    expect(row.dispute_reason).to eq('Not At Fault')
  end
end

Then(/^the Auto CLUE report should contain the expected data$/) do
  expected = data_for('reports_page')['expected_policy_losses']
  on(ReportsPage) do |page|
    RSpec.capture_assertions do
      expected.each_with_index do |e, i|
        loss = page.report_results_modal.policy_losses[i]
        expect(loss.amount_paid).to eq(e[:amount_paid])
        expect(loss.claim_type).to eq(e[:claim_type])
        expect(loss.date).to match(/\d+\/\d+\/\d+/)
        expect(loss.status).to eq(e[:status])
      end
    end
  end
end

When(/^I dispute the first policy loss in the clue report$/) do
  on(ReportsPage) do |page|
    page.report_results_modal.policy_losses.first.mark_for_dispute = true
  end
end

Then(/^I should see UI allowing me to choose a reason to dispute the loss$/) do
  on(ReportsPage) do |page|
    actual = page.report_results_modal.policy_losses.first
    expect(actual.dispute_remarks?).to be_truthy, "Expected to see a row containing a dispute reason/remark text area but found #{actual} of them."
  end
end

And(/^I assign drivers to all unassigned losses in the current report$/) do
  on(ReportsPage) do |page|
    Watir::Wait.until { page.auto_clue_modal.unassigned_driver_losses.count.positive? }
    page.auto_clue_modal.unassigned_driver_losses.each(&:assign_first_driver)
    page.auto_clue_modal.save_and_close_button
    Watir::Wait.until { !page.auto_clue_modal.present? }
    page.change_premium_modal.dismiss if page.change_premium_modal?
  end
end

Then(/^I can view the (Auto CLUE|Auto Prefill) report driver assignment$/) do |report_type|
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.find_report_by_type(report_type).edit
    page.wait_for_modal(page.auto_clue_modal)
    expect(page.auto_clue_modal.unassigned_driver_losses.count).to eq(0), 'expected the unassigned driver losses grid to be empty but it was not'
  end
end

And(/^I assign drivers on the current report$/) do
  on(ReportsPage) do |page|
    page.wait_for_modal(page.auto_clue_modal)
    page.auto_clue_modal.unassigned_driver_losses.each(&:assign_first_driver)
    page.auto_clue_modal.save_and_close_button
    page.report_results_modal.dismiss if page.report_results_modal?
  end
end

And(/^I dispute an accident or violation$/) do
  on(ReportsPage) do |page|
    page.wait_for_modal(page.auto_driver_modal)
    page.auto_driver_modal.accidents_and_violations.first.dispute_with_reason('Not At Fault')
    page.auto_driver_modal.save_and_close
  end
end

Then(/^I should see the disputed accident or violation$/) do
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.find_report_by_type('Auto CLUE').edit
    page.wait_for_modal(page.auto_clue_modal)
    page.auto_clue_modal.save_and_continue
    checked = page.auto_driver_modal.accidents_and_violations.first.dispute_element.checked?
    reason = page.auto_driver_modal.accidents_and_violations.first.reason
    RSpec.capture_assertions do
      expect(checked).to be_truthy, "Expected first accident or violation's dispute checkbox to be checked but it is #{checked}"
      expect(reason).to eq('Not At Fault'), "Expected first accident or violation's dispute reason to be 'Not At Fault' but it is #{reason}"
    end
  end
end

And(/^I create an accident or violation$/) do
  on(ReportsPage) do |page|
    page.wait_for_modal(page.auto_driver_modal)
    page.auto_driver_modal.add_accident('Accident not at fault')
  end
end

Then(/^I should see the created accident or violation$/) do
  on(ReportsPage) do |page|
    page.open_and_save_report('Auto CLUE', page.clue_prefill_mvr_section)
    today = Time.now.strftime('%m/%d/%Y')
    av = page.auto_driver_modal.find_accident_or_violation(today, 'Accident not at fault')
    expect(av).not_to be_nil, "Could not find an accident or violation with the date, #{today}, and the type, Accident not at fault"
    page.auto_driver_modal.save_and_close
  end
end

And(/^I delete the accident or violation$/) do
  on(ReportsPage) do |page|
    page.open_and_save_report('Auto CLUE', page.clue_prefill_mvr_section)
    av = page.auto_driver_modal.find_accident_or_violation(Time.now.strftime('%m/%d/%Y'), 'Accident not at fault')
    av.delete
    page.auto_driver_modal.save_and_close
  end
end

Then(/^I should not see the deleted accident or violation$/) do
  on(ReportsPage) do |page|
    page.open_and_save_report('Auto CLUE', page.clue_prefill_mvr_section)
    today = Time.now.strftime('%m/%d/%Y')
    av = page.auto_driver_modal.find_accident_or_violation(today, 'Accident not at fault')
    expect(av).to be_nil, "Expected not to find an accident or violation with the date, #{today}, and the type, Accident not at fault; but one was found"
  end
end

Then(/^All reports should be checked$/) do
  on(ReportsPage) do |page|
    RSpec.capture_assertions do
      page.clue_prefill_mvr_section.report_grid.items.each { |report| expect(report.order_element.checked?).to be_truthy }
    end
  end
end

Then(/^I should see the CLUE dispute reasons available on the CLUE modal$/) do
  dispute_reasons = data_for('dispute_reasons')
  on(ReportsPage) do |page|
    page.wait_for_modal(page.auto_clue_modal)
    RSpec.capture_assertions do
      dispute_reasons['clue'].each_with_index do |reason_set, i|
        page.auto_clue_modal.unassigned_driver_losses[i].mark_for_dispute = true
        row = page.auto_clue_modal.unassigned_losses_dispute_reasons[i]
        reason_set.each { |r| expect(row.dispute_reason_element.include?(r)).to be_truthy, "Expected CLUE dispute reasons to include \"#{r}\" but it didn't" }
      end
    end
  end
end

When(/^I apply to quote on the CLUE modal$/) do
  on(ReportsPage).auto_clue_modal.apply_to_quote
end

Then(/^I should see the MVR dispute reasons available on the auto driver modal$/) do
  dispute_reasons = data_for('dispute_reasons')
  on(ReportsPage) do |page|
    page.wait_for_modal(page.auto_driver_modal)
    mvr_avs = page.auto_driver_modal.mvr_accidents_and_violations
    RSpec.capture_assertions do
      dispute_reasons['mvr'].each_with_index do |reason_set, i|
        mvr_avs[i].dispute = true
        reason_set.each { |r| expect(mvr_avs[i].reason_element.include?(r)).to be_truthy, "Expected MVR dispute reasons to include \"#{r}\" but it didn't" }
      end
    end
  end
end

Then(/^the report should contain the manually added losses$/) do
  on(ReportsPage) do |page|
    RSpec.capture_assertions do
      data_for('auto_general_info_modal')['manual_losses'].each do |loss|
        table_loss = page.auto_clue_modal.find_pl_by_date_and_type(loss['date'], loss['type'])
        expect(table_loss).not_to be_nil, "Expected to find a loss in the table with the date \"#{loss['date']}\" and a type containing \"#{loss['type']}\" but did not"
      end
    end
  end
end

When(/^I delete the fixture's first manually added loss$/) do
  on(ReportsPage) do |page|
    first_loss = data_for('auto_general_info_modal')['manual_losses'].first
    @deleted_loss = first_loss
    page.auto_clue_modal.delete_pl_by_date_and_type(first_loss['date'], first_loss['type'])
    page.auto_clue_modal.save_and_close
  end
end

Then(/^I should not see the deleted manually added loss$/) do
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.find_report_by_type('Auto CLUE').edit
    expected_date = Chronic.parse(@deleted_loss['date']).to_date.strftime('%m/%d/%Y')
    table_loss = page.auto_clue_modal.policy_losses_hash.find { |l| l[:date] == expected_date && (l[:claim_type].include? @deleted_loss['type']) }
    expect(table_loss).to be_nil, "Attempted to delete a loss and expected not to find a loss in the table with the date \"#{expected_date}\" and a type containing \"#{@deleted_loss['type']}\" but did"
  end
end

Then(/^I should see at least (\d+) report tabs$/) do |expected_tabs|
  on(ReportsPage) do |page|
    #optionally we could count the products in the left nav and match the reports tab....
    actual_tabs = page.clue_prefill_mvr_section.reports_grid.count
    expect(actual_tabs).to be >= expected_tabs, "Expected the number of tabs in the clue prefill mvr section to equal #{expected_tabs} (to match the number of products on the policy), but it was #{actual_tabs}"
  end
end

Then(/^I should see my insurance score$/) do
  on(ReportsPage) do |page|
    insurance_score = data_for('reports_page')['expected_insurance_score']
    page.clue_prefill_mvr_section.reports_grid.first.chevron_right_element.click if page.clue_prefill_mvr_section.reports_grid.first.chevron_right?
    expect(page.clue_prefill_mvr_section.find_report_by_type('Insurance Score').first.status).to eq(insurance_score), "Expected the insurance score section on the reports page to contain a row with an insurance score of \"#{insurance_score}\" but it could not be found"
  end
end

When(/^I edit the first territory report$/) do
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.find_report_by_type('Territory').first.eye_icon_element.click
  end
end

And(/^I order and dispute MVRs$/) do
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.order_reports_by_type('MVR')
    page.wait_for_modal(page.auto_driver_modal)
    mvr_avs = page.auto_driver_modal.mvr_accidents_and_violations
    mvr_avs.each do |av|
      av.dispute = true
      av.reason = 'Other'
      av.dispute_remarks = 'random remarks'
    end
    page.auto_driver_modal.save_and_close
  end
end

And(/^I click the eye icon on "([^"]*)" report$/) do |type|
  on(ReportsPage) do |page|
    product_report = page.clue_prefill_mvr_section.reports_grid.first
    product_report.chevron_right_element.click if product_report.chevron_right?
    page.clue_prefill_mvr_section.reports_grid.find { |x| x.type.include? type if x.type? }.eye_icon_element.click
    page.wait_for_modal(page.territory_report_modal)
  end
end

Then(/^I (should|should not) see the "([^"]*)" section$/) do |should_or_not, section|
  on(ReportsPage) do |page|
    modal = page.territory_report_modal
    if should_or_not == 'should'
      expect(modal.ppc_information_section.present?).to be_truthy
    else
      expect(modal.ppc_information_section.present?).to be_falsey
    end
  end
end

And(/^I validate fields under Geocoding Information using the (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @geocoding_information = data_for('geocoding_information')
  on(ReportsPage) do |page|
    modal = page.territory_report_modal
    expect(modal.geocoding_information_section.auto_territories).to eq(@geocoding_information['auto_territories']) if @geocoding_information['auto_territories'] != "Not Available"
    expect(modal.geocoding_information_section.home_territories).to eq(@geocoding_information['home_territories']) if @geocoding_information['home_territories'] != "Not Available"
    expect(modal.geocoding_information_section.dwelling_territories).to eq(@geocoding_information['dwelling_territories']) if @geocoding_information['dwelling_territories'] != "Not Available"
  end
end

Then(/^I validate status for "([^"]*)" report as "([^"]*)"$/) do |type, status|
  on(ReportsPage) do |page|
    product_report = page.clue_prefill_mvr_section.reports_grid.first
    product_report.chevron_right_element.click if product_report.chevron_right?
    @status = page.clue_prefill_mvr_section.reports_grid.find { |x| x.type.include? type if x.type? }.status
    expect(@status).to eq(status)
  end
end

When(/^I order CLUE and MVR reports for multiple policies$/) do
  on(PolicyManagementPage).left_nav.navigate_to('Reports')
  on(ReportsPage).multiple_issues_to_resolve
end

When(/^I order CLUE and MVR reports for home$/) do
  on(PolicyManagementPage).left_nav.navigate_to('Reports')
  on(ReportsPage).resolve_issues_to_resolve_home
end

Then(/^I order reports apart from inspection order$/) do
  on(PolicyManagementPage).left_nav.navigate_to('Reports')
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.reports_grid.each do |item|
      if item.order? && item.type?
        if item.order.enabled?
          item.order = true
          item.order = false if item.type == "Property Inspection"
        end
      end
    end
    on(ReportsPage).resolve_issues_to_resolve_home
  end
end

And(/^I enter and save accident and violation details in MVR report$/) do
  on(ReportsPage) do |page|
    report = page.clue_prefill_mvr_section.reports_grid.find { |i| i.type.include? "MVR" if i.type? }
    report.edit_report
    page.wait_for_ajax
    modal = page.auto_driver_modal
    panel = modal.accidents_and_violations.find { |i| i.panel_title.include? 'MVR' }
    panel.dispute = true
    panel.reason = 1
    modal.add_accident_button
    panel = modal.accidents_and_violations.find { |i| i.panel_title.include? 'Manually Entered Accident' }
    panel.accident_date = Chronic.parse('yesterday').to_date.strftime('%m/%d/%Y')
    panel.accident_type = 1
    panel.description = "test"
    modal.add_violation_button
    panel = modal.accidents_and_violations.find { |i| i.panel_title.include? 'Manually Entered Violation' }
    panel.accident_date = Chronic.parse('yesterday').to_date.strftime('%m/%d/%Y')
    panel.accident_type = 1
    panel.description = "test"
    modal.save_and_close
    page.wait_for_ajax
  end
end

Then(/^I validate accident and violation details in MVR report$/) do
  on(ReportsPage) do |page|
    report = page.clue_prefill_mvr_section.reports_grid.find { |i| i.type.include? "MVR" if i.type? }
    report.edit_report
    page.wait_for_ajax
    modal = page.auto_driver_modal
    panel = modal.accidents_and_violations.find { |i| i.panel_title.include? 'Manually Entered Accident' }
    expect(panel).not_to be_nil
    panel = modal.accidents_and_violations.find { |i| i.panel_title.include? 'Manually Entered Accident' }
    expect(panel).not_to be_nil
    panel = modal.accidents_and_violations.find { |i| i.panel_title.include? 'Manually Entered Violation' }
    expect(panel).not_to be_nil
    modal.save_and_close
    page.wait_for_ajax
  end
end

And(/^I validate the following dispute reasons$/) do |table|
  # table is a table.hashes.keys # => [:abc]
  expected = table.rows.flatten
  on(ReportsPage) do |page|
    report = page.clue_prefill_mvr_section.reports_grid.find { |i| i.type.include? "MVR" if i.type? }
    report.edit_report
    page.wait_for_ajax
    modal = page.auto_driver_modal
    panel = modal.accidents_and_violations.find { |i| i.panel_title.include? 'MVR' }
    panel.dispute = true
    select_list = panel.reason.options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found"
      end
    end
  end
end

And(/^I click on Show order history link on reports page$/) do
  on(ReportsPage) do |page|
    page.show_order_history
  end
end

Then(/^I should see history record fields headers$/) do
  on(ReportsPage) do |page|
    expect(page.inspection_type_element.text).to eq("Inspection Type")
    expect(page.supplements_element.text).to eq("Supplement(s)")
    expect(page.ordered_date_element.text).to eq("Ordered Date")
    expect(page.received_date_element.text).to eq("Received Date")
    expect(page.status_element.text).to eq("Status")
  end
end

Then(/^I order reports through actions dropdown$/) do
  on(AutoPolicySummaryPage) do |page|
    page.actions_menu
    page.view_and_order_reports
  end
  on(PolicyManagementPage) do |page|
    modal = page.order_reports_modal
    modal.order_reports
    page.wait_for_ajax
  end
  on(ReportsPage).order_reports_modal
  on(PolicyManagementPage) do |page|
    modal = page.order_reports_modal
    modal.close
    page.wait_for_ajax
    if page.premium_change_toast_close?
      page.premium_change_toast_close
    end
  end
end

And(/^I validate reports modal$/) do
  on(AutoPolicySummaryPage) do |page|
    page.actions_menu
    page.view_and_order_reports
  end
  on(PolicyManagementPage) do |page|
    modal = page.order_reports_modal
    expect(modal.order_reports?).to be_falsey
    expect(modal.close?).to be_truthy
    modal.close
    page.wait_for_ajax
  end
end

And(/^I validate details on territory protection class modal using (.*)$/) do |fixture_file|
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @geocoding_information = data_for('geocoding_information')
  @location_information = data_for('location_information')
  on(ReportsPage) do |page|
    modal = page.territory_report_modal
    expect(modal.geocoding_information_section.home_territories).to eq(@geocoding_information['home_territories']) if modal.geocoding_information_section.home_territories?
    expect(modal.geocoding_information_section.dwelling_territories).to eq(@geocoding_information['dwelling_territories']) if modal.geocoding_information_section.dwelling_territories?
    expect(modal.geocoding_information_section.geocoded_address).to eq(@geocoding_information['geocoded_address'])
    expect(modal.geocoding_information_section.distance_to_coast).to eq(@geocoding_information['distance_to_coast'])
    expect(modal.geocoding_information_section.description).to eq(@geocoding_information['description'])
    expect(modal.location_information_section.address).to eq(@location_information['address'])
  end
end

Then(/^I validate that there are no reports and referrals$/) do
  on(PolicyManagementPage).left_nav.navigate_to('Reports')
  expect(on(ReportsPage).clue_prefill_mvr_section.reports_grid_element.present?).to be_falsey
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")
  end
  expect(on(CMIEmployeesSummaryPage).empty_referrals.nil?).to be_falsey
end

Then(/^I validate that reports are not present for scheduled property$/) do
  on(ReportsPage) do |page|
    expect(page.clue_prefill_mvr_section.reports_grid_element.present?).to be_truthy
  end
end