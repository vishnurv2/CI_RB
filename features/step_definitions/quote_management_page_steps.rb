# frozen_string_literal: true

Then(/^I provide details on quote management page$/) do
  on(QuoteManagementPage) do |page|
    page.quote_section.count
    page.comparable_quote_section.count
  end
end

Then(/^I validate and update panel one using "([^"]*)" fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  # on(PolicyManagementPage).left_navigate_to_if_not_on("Quote Management")
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage) do |page|
    panel_data = data_for('expected_quote_options')
    panel = page.quote_section[0]
    expect(panel.quote_premium?).to be_truthy
    expect(panel.umbrella_liability_limit.text).to eq(panel_data['umbrella_liability_limit'])
    expect(panel.umbrella_uninsured_motorist_limit.text).to eq(panel_data['umbrella_uninsured_motorist_limit'])
    expect(panel.umbrella_uninsured_field_name).to eq(panel_data['umbrella_uninsured_field_name'])
    data = data_for('quote_options_panel_one')
    panel.umbrella_liability_limit = data['umbrella_liability_limit']
    panel.umbrella_uninsured_motorist_limit = data['umbrella_uninsured_motorist_limit']
    page.recalculate
    page.wait_for_processing_overlay_to_close
    page.save_changes
    page.wait_for_processing_overlay_to_close
  end
end

And(/^I validate and update auto policy coverages using "([^"]*)" fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "IN - Umbrella"
      page.left_nav.navigate_to('IN - Umbrella')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on("IN - Umbrella")
  on(AutoPolicySummaryPage).umbrella_policy_coverages_panel.modify
  on(PolicyManagementPage) do |page|
    expected_data = data_for('quote_options_panel_one')
    data = data_for('auto_policy_level_coverages_modal')
    modal = page.auto_policy_coverages_modal
    expect(modal.total_limit_liability.text).to eq(expected_data['umbrella_liability_limit'])
    expect(modal.total_limit.text).to eq(expected_data['umbrella_uninsured_motorist_limit'])
    modal.populate_with(data)
    modal.save_and_close
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I verify bumped up limits of underlying products$/) do
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "IN - Auto"
      page.left_nav.navigate_to('IN - Auto')
    end
    on(AutoPolicySummaryPage).policy_coverages_panel.modify
    expect(page.auto_policy_coverages_modal.combined_single_limit.text).to eq("$300,000")
    page.auto_policy_coverages_modal.save_and_close
    unless page.page_header_text.include? "IN - Watercraft"
      page.left_nav.navigate_to('IN - Watercraft')
    end
    on(AutoPolicySummaryPage).policy_coverages_panel.modify
    expect(page.auto_policy_coverages_modal.wpl_coverage_x.text).to eq("$300,000")
    page.auto_policy_coverages_modal.save_and_close
    page.left_nav.navigate_to('IN - Homeowners')
    on(AutoPolicySummaryPage).policy_coverages_panel.modify
    expect(page.auto_policy_coverages_modal.coverage_e_personal.text).to eq("$300,000")
    page.auto_policy_coverages_modal.save_and_close
    page.left_nav.navigate_to('IN - Special Dwelling')
    on(AutoPolicySummaryPage).policy_coverages_panel.modify
    expect(page.auto_policy_coverages_modal.coverage_l_dwelling_limit.text).to eq("$300,000")
    page.auto_policy_coverages_modal.save_and_close
  end
end

And(/^I validate correct updates in auto policy coverages using "([^"]*)" fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "IN - Umbrella"
      page.left_nav.navigate_to('IN - Umbrella')
    end
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on("IN - Umbrella")
  on(AutoPolicySummaryPage).umbrella_policy_coverages_panel.modify
  on(PolicyManagementPage) do |page|
    expected_data = data_for('quote_options_panel_one')
    modal = page.auto_policy_coverages_modal
    expect(modal.total_limit_liability.text).to eq(expected_data['umbrella_liability_limit'])
    expect(modal.total_limit.text).to eq(expected_data['umbrella_uninsured_motorist_limit'])
    modal.save_and_close
    page.wait_for_processing_overlay_to_close
  end
end

And(/^I validate the following coverages$/) do |table|
  expected = table.raw.flatten
  on(QuoteManagementPage) do |page|
    panel1 = page.quote_section[0]
    panel2 = page.comparable_quote_section[0]
    actual_coverages = panel1.vehicles.first.coverage_names
    actual_coverages_panel2 = panel2.vehicles.first.coverage_names
    expect(actual_coverages).to eq(expected), "Expected \"#{expected}\" Coverages to match the list in the feature file but found \"#{actual_coverages}\""
    expect(actual_coverages_panel2).to eq(expected), "Expected \"#{expected}\" Coverages to match the list in the feature file but found \"#{actual_coverages}\""
  end
end

Then(/^the old premium should differ from the new premium$/) do
  on(QuoteManagementPage) do |page|
    new_premium = page.quote_total_premium
    expect(@premium).not_to eq(new_premium), "These two premiums should not equal! Initial Premium: #{@premium}, premium after Policy Change: #{new_premium}"
  end
end

When(/^I click on "([^"]*)" link on Thank you model after clicking on begin issuance$/) do |opt|
  on(QuoteManagementPage) do |page|
    page.wait_for_ajax
    #page.check_all_quoted
    page.scroll.to :top
    # the begin issuance is sometimes clicked too fast after selecting check box, adding a slight delay
    sleep(0.3)
    page.begin_issuance
    page.wait_for_processing_overlay
  end
  #on(PolicyManagementPage) do |page|
  # page.thank_you_modal.send("#{opt.snakecase}") if page.thank_you_modal?
  on(AutoPolicySummaryPage) do |page|
    page.message_card_panel.send("#{opt.snakecase}") if page.message_card_panel?
      #page.message_card_panel.add_a_party
  end
end

And(/^I click on "([^"]*)" from quote management page$/) do |which|
  on(QuoteManagementPage) do |page|
    page.ellipses_icon
    page.send("#{which.snakecase}")
  end
end