# frozen_string_literal: true

And(/^the "([^"]*)" quote option (should|should not) be highlighted$/) do |which, what|
  panel_index = {first: 0, second: 1, third: 2}[which.downcase.to_sym]

  on(QuoteOptionsPage) do |page|
    actual = page.quote_option_panels[panel_index].selected?
    expected = what == 'should'
    expect(actual).to eq(expected), "The #{which} quote option #{what} be highlighted"
  end
end

When(/^I select the "([^"]*)" quote option$/) do |which|
  panel_index = {first: 0, second: 1, third: 2}[which.downcase.to_sym]

  on(QuoteOptionsPage) do |page|
    page.quote_option_panels[panel_index].select_option
  end
end

Then(/^I should be able to expand and collapse the upsell panels for each quote option$/) do
  # RSpec.capture_assertions do
  on(QuoteManagementPage) do |page|
    page.quote_section.each do |product|
      if product.expansion_icon_up?
        product.expansion_icon_up_element.click
        Watir::Wait.until(timeout: 1) { product.expansion_icon_down? }
        expect(product.expansion_icon_down?).to be_truthy, "Panel did not collapse properly"
      end
      if product.expansion_icon_down?
        product.expansion_icon_down_element.click
        Watir::Wait.until(timeout: 1) { product.expansion_icon_up? }
        expect(product.expansion_icon_up?).to be_truthy, "Panel did not expand properly"
      end
    end
  end
end

Then(/^panel two should contain the correct upgrades$/) do
  RSpec.capture_assertions do
    on(QuoteManagementPage) do |page|
      panel_data = data_for('expected_panels')['panels'][1]
      panel = page.comparable_quote_section[0]
      expect(panel.comparable_quote_policy_name).to eq(panel_data['product_name'])
      expect(panel.liability_limit.delete(" ")).to eq(panel_data['product_liability_limit'].delete(" "))
      expect(panel.enhanced_coverage).to eq(panel_data['enhanced_coverage'])
    end
  end
end

And(/^panel three should contain the same options as panel one but be editable$/) do
  RSpec.capture_assertions do
    on(QuoteOptionsPage) do |page|
      panel_data = page.quote_option_panels[0]
      panel = page.quote_option_panels[2]
      expect(panel.product_name).to eq(panel_data.product_name)
      expect(panel.upgraded_liability_limit).to eq(panel_data.product_liability_limit)
      expected = panel_data.enhanced_coverage == 'No enhanced auto coverage form' ? 'No Enhanced Coverage' : panel_data.enhanced_coverage
      expect(panel.enhanced_auto_coverage_select).to eq(expected)
    end
  end
end

And(/^any differences between panel one and panel two should be highlighted$/) do
  RSpec.capture_assertions do
    on(QuoteManagementPage) do |page|
      src_panel = page.quote_section[0]
      panel = page.comparable_quote_section[0]

      %i[liability_limit enhanced_coverage].each do |which|
        expect(panel.send("#{which}_difference?")).to(be_truthy, "#{which} should be highlighted but it is not") if src_panel.send(which).text != panel.send(which)
        expect(panel.send("#{which}_difference?")).to(be_falsey, "#{which} should NOT be highlighted but it is") unless src_panel.send(which).text != panel.send(which)
      end
    end
  end
end

When(/^I upgrade enhanced auto coverage from the quote options page to "([^"]*)"$/) do |value|
  on(QuoteManagementPage) do |page|
    @expected_enhanced_auto = value
    page.quote_section.first.enhanced_coverage.set(value)
    page.scroll.to :top
    page.recalculate
    page.wait_for_processing_overlay_to_close
    page.save_changes
  end
end

Then(/^the auto policy will have the enhanced auto coverages we selected from the quote options$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.policy_coverages_panel
    expect(panel.enhanced_coverage).to eq(@expected_enhanced_auto)
  end
end

When(/^I select a different limit on the quote options page$/) do
  on(QuoteManagementPage) do |page|
    page.quote_section.first.liability_limit = 3
    @expected_limit = page.quote_section.first.liability_limit.text
    page.scroll.to :top
    page.recalculate
    page.wait_for_processing_overlay_to_close
    page.save_changes
  end
end

Then(/^the auto policy will have the new limit we selected from the quote options$/) do
  on(PolicyManagementPage) do |page|
    menu_item = page.left_nav.find_option_containing('IN - Auto Plus')
    menu_item.click unless menu_item.active?
  end
  on(AutoPolicySummaryPage) do |page|
    panel = page.policy_coverages_panel
    Watir::Wait.until(timeout: 5, message: 'Timed Out After 5 Seconds Waiting for Either the Combined Single Limit or the Bodily Injury Liability to Appear in the Policy Level Coverages Panel') { panel.combined_single_limit? || panel.bodily_injury_liability? }
    limit_element = ((panel.combined_single_limit?) ? 'Combined Single Limit' : 'Bodiliy Injury Liability')
    actual = nil
    Watir::Wait.while(timeout: 5, message: "Timed Out After 5 Seconds Waiting for the #{limit_element} On the Policy Level Coverages Panel Not to Be '---'") do
      #actual = panel.combined_single_limit if panel.combined_single_limit?
      #actual = panel.bodily_injury_liability if panel.bodily_injury_liability?
      actual = panel.send(limit_element.snakecase)
      actual == '---'
    end
    expect(actual).to eq(@expected_limit), "Expected #{limit_element} to Be #{@expected_limit}, but it was #{actual}"
  end
end

Then(/^Panel 2 should display upgrades for liability, collision, and other than collision$/) do
  on(QuoteManagementPage) do |page|
    expect(page.comparable_quote_section[0].liability_limit).to eq('$250,000/$500,000')
    expect(page.comparable_quote_section[0].vehicles.first.collision).to eq('$1,000')
    expect(page.comparable_quote_section[0].vehicles.first.other_than_collision).to eq('$500')
  end
end

And(/^each panel should include a premium$/) do
  on(QuoteManagementPage) do |page|

    page.quote_section.each_with_index do |panel, index|
      expect(panel.quote_premium?).to be_truthy, "The product premium is missing from panel #{index} (zero based)"
      expect(panel.quote_premium).to match(/^\$?([0-9]{1,3},([0-9]{3},)*[0-9]{3}|[0-9]+)(.[0-9][0-9])?$/), "The product premium in panel #{index} (zero based) is not a dollar amount"
    end

    page.comparable_quote_section.each_with_index do |panel, index|
      ### DDL Theres a next in this to skip the Umbrella Panel thats not included in Auto only quoting, there wont be a value here.
      # We'll need to do another step I think if we want to check for auto and umbrella?
      #
      next if index == 1

      expect(panel.quote_premium?).to be_truthy, "The product premium is missing from comparable panel #{index} (zero based)"
      expect(panel.quote_premium).to match(/^\$?([0-9]{1,3},([0-9]{3},)*[0-9]{3}|[0-9]+)(.[0-9][0-9])?$/), "The product premium in panel #{index} (zero based) is not a dollar amount"
    end
    # RSpec.capture_assertions do
    #   page.quote_option_panels.each_with_index do |panel, index|
    #     expect(panel.product_premium?).to be_truthy, "The product premium is missing from panel #{index} (zero based)"
    #     expect(panel.product_premium).to match(/^\$?([0-9]{1,3},([0-9]{3},)*[0-9]{3}|[0-9]+)(.[0-9][0-9])?$/), "The product premium in panel #{index} (zero based) is not a dollar amount"
    #   end
    # end
  end
end

And(/^panel one should include the coverages from our fixture$/) do
  on(QuoteManagementPage) do |page|
    expected = data_for 'expected_qo_vehicle_coverages'
    panel = page.quote_section.first
    vehicle_panel = panel.vehicles.first
    expect(vehicle_panel.other_than_collision_dropdown.text).to eq(expected['Other than Collision'])
    expect(vehicle_panel.collision_dropdown.text).to eq(expected['Collision'])
    expect(vehicle_panel.liability_dropdown.text).to eq(expected['Liability'])
  end
end

And(/^panel two should include upgrades for the coverages from our fixture$/) do
  on(QuoteManagementPage) do |page|
    expected = data_for 'expected_upgrades_qo_vehicle_coverages'
    panel = page.comparable_quote_section.first
    vehicle_panel = panel.vehicles.first
    expect(vehicle_panel.other_than_collision).to eq(expected['Other than Collision'])
    expect(vehicle_panel.collision).to eq(expected['Collision'])
    expect(vehicle_panel.liability).to eq(expected['Liability'])
  end
end

Then(/^panel one and two should include the (.*) driver discounts$/) do |discounts|
  expected = discounts.split(',').map(&:strip).sort
  on(QuoteOptionsPage) do |page|
    actual = page.quote_option_panels.first.driver_discounts.first.discounts.sort
    expect(actual).to eq(expected)
  end
end

And(/^panel three should show the applicable driver discounts (.*) with the selected driver discounts (.*) selected$/) do |applicable_discounts, selected_discounts|
  expected_app = applicable_discounts.split(',').map(&:strip).sort
  expected_sel = selected_discounts.split(',').map(&:strip).sort
  on(QuoteOptionsPage) do |page|
    panel = page.quote_option_panels.last.driver_discounts.first
    actual_app = panel.applicable_discounts.sort
    actual_sel = panel.selected_discounts.sort
    RSpec.capture_assertions do
      expect(actual_app).to eq(expected_app)
      expect(actual_sel).to eq(expected_sel)
    end
  end
end

When(/^I toggle the (.*)$/) do |applicable_discounts|
  discounts = applicable_discounts.split(',').map(&:strip).sort
  on(QuoteOptionsPage) do |page|
    panel = page.quote_option_panels.last.driver_discounts.first
    panel.scroll.to
    discounts.each { |d| panel.discount(d).toggle }
    page.quote_option_panels.last.rate_custom_option
    page.quote_option_panels.last.select_option
    sleep 3
    page.apply_quote
    page.wait_for_processing_overlay
  end
end

Then(/^panel three should show the selected driver discounts (.*) selected$/) do |selected_discounts|
  expected_sel = selected_discounts.split(',').map(&:strip).sort
  on(QuoteOptionsPage) do |page|
    panel = page.quote_option_panels.last.driver_discounts.first
    actual_sel = panel.selected_discounts.sort
    expect(actual_sel).to eq(expected_sel)
  end
end

Then(/^each panel should not include a premium$/) do
  on(QuoteOptionsPage) do |page|
    RSpec.capture_assertions do
      page.quote_option_panels.each_with_index do |panel, index|
        expect(panel.product_premium.delete('$ , .').include?('--')).to be_truthy, "Expected to find a non numeric value (dashes) in Quote Options due to issues to resolve, but found: \"#{page.quote_option_panels[index].product_premium}\" in panel #{index}"
      end
    end
  end
end


Then(/^I validate the correct upgrades in panel two$/) do
  RSpec.capture_assertions do
    on(QuoteManagementPage) do |page|
      panel_data = data_for('expected_panels')['panels'][1]
      panel = page.comparable_quote_section[0]
      expect(panel.umbrella_liability_limit == panel_data['umbrella_liability_limit']).to be_falsey
      expect(panel.umbrella_uninsured_motorist_limit.delete(" ")).to eq(panel_data['umbrella_uninsured_motorist_limit'].delete(" "))
    end
  end
end

And(/^difference between the panels should be highlighted$/) do
  RSpec.capture_assertions do
    on(QuoteManagementPage) do |page|
      src_panel = page.quote_section[0]
      panel = page.comparable_quote_section[0]

      %i[umbrella_liability_limit umbrella_uninsured_motorist_limit].each do |which|
        expect(panel.send("#{which}_difference?")).to(be_truthy, "#{which} should be highlighted but it is not") if src_panel.send(which).text != panel.send(which)
        expect(panel.send("#{which}_difference?")).to(be_falsey, "#{which} should NOT be highlighted but it is") unless src_panel.send(which).text != panel.send(which)
      end
    end
  end
end

And(/^I validate ui_uim total limit must be equal to or less than limit of liability$/) do |table|
  expected = {}
  table.rows.each { |r| expected[r[0]] ||= []; expected[r[0]] << r[1] }

  on(QuoteManagementPage) do |page|
    panel = page.quote_section[0]
    RSpec.capture_assertions do
      expected.each do |field, values|
        panel.umbrella_liability_limit.select(field)
        panel.umbrella_uninsured_motorist_limit.click
        total_limit_values_disabled = page.div(class: /p-dropdown-item/).lis(class: "p-disabled").map(&:text)
        total_limit_values_enabled = page.div(class: /p-dropdown-item/).lis.map(&:text) - total_limit_values_disabled
        expect(total_limit_values_enabled).to eq(values)
        panel.umbrella_uninsured_motorist_limit.click #added this so that it does not intercept the umbrella_liability_limit click
      end
    end
  end
end

Then(/^I apply to quote and validate the updates in both the panels$/) do
  on(QuoteManagementPage) do |page|
    panel1 = page.quote_section[0]
    panel2 = page.comparable_quote_section[0]
    panel2.apply_to_quote
    page.wait_for_processing_overlay_to_close
    RSpec.capture_assertions do
      panel_data = data_for('expected_panels')['panels'][1]
      @umbrella_liability_limit = panel_data['umbrella_liability_limit'].remove('$').remove(',').to_i
      expect(panel1.umbrella_liability_limit.text == panel_data['umbrella_liability_limit']).to be_falsey
      expect(panel1.umbrella_uninsured_motorist_limit.text).to eq(panel_data['umbrella_uninsured_motorist_limit'])
      expect(panel2.umbrella_liability_limit.remove('$').remove(',').to_i == @umbrella_liability_limit).to be_falsey
      expect(panel2.umbrella_uninsured_motorist_limit).to eq(panel_data['umbrella_uninsured_motorist_limit'])
    end
  end
end

When (/^I apply to quote and add umbrella$/) do
  on(QuoteManagementPage) do |page|
    $c=0
    $c = page.quote_section.count
    while $c > 0
      set = $c
      page.quote_section[set].quote_policy_name_element.click
      page.wait_for_processing_overlay_to_close
      page.comparable_quote_section[0].apply_to_quote
      page.wait_for_processing_overlay_to_close
      $c = $c - 1
    end
    page.comparable_quote_section_umbrella.add_umbrella_element.click
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I validate the correct updates in panel one$/) do
  RSpec.capture_assertions do
    on(QuoteManagementPage) do |page|
      panel_data = data_for('expected_panels')['panels'][0]
      panel = page.quote_section[0]
      expect(panel.quote_premium?).to be_truthy
      expect(panel.umbrella_liability_limit.text).to eq(panel_data['umbrella_liability_limit'])
      expect(panel.umbrella_uninsured_motorist_limit.text).to eq(panel_data['umbrella_uninsured_motorist_limit'])
    end
  end
end

Then(/^Panel 2 should display upgrades for the premium$/) do
  on(QuoteManagementPage) do |page|
    RSpec.capture_assertions do
      expect(page.comparable_quote_section[0].quote_premium).not_to eq(page.quote_section[0].quote_premium), "Premium should be different in both the quote panels"
      expect(page.comparable_quote_section[0].package_discount).not_to eq(page.quote_section[0].package_discount_cmp), "Package discount should be different in both the quote panels"
      expect(page.comparable_quote_section[0].enhanced_coverage).to eq(page.quote_section[0].enhanced_coverage_cmp), "Premium should be different in both the quote panels"
      expect(page.comparable_quote_section[0].apply_to_quote?).to be_truthy
    end
  end
end

Then(/^the watercraft policy will not have enhanced coverage on policy level coverages panel$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.policy_coverages_panel
    expect(panel.enhanced_coverage_element.present?).to be_falsey, "Enhanced coverage should not be present on policy coverage panel"
  end
end

When(/^I upgrade package discount from the quote options page to "([^"]*)"$/) do |value|
  on(QuoteManagementPage) do |page|
    @expected_enhanced_auto = value
    page.quote_section.first.package_discount.set(value)
    page.scroll.to :top
    page.recalculate
    page.wait_for_processing_overlay_to_close
    page.save_changes
  end
end

Then(/^premium should be same on both the Quote panels$/) do
  on(QuoteManagementPage) do |page|
    RSpec.capture_assertions do
      expect(page.comparable_quote_section[0].quote_premium).to eq(page.quote_section[0].quote_premium), "Premium should be same in both the quote panels"
      expect(page.comparable_quote_section[0].package_discount).to eq(page.quote_section[0].package_discount_cmp), "Package discount should be same in both the quote panels"
      expect(page.comparable_quote_section[0].enhanced_coverage).to eq(page.quote_section[0].enhanced_coverage_cmp), "Premium should be different in both the quote panels"
    end
  end
end

Then(/^Panel 2 should display upgrades for the premium and others for dwelling$/) do
  on(QuoteManagementPage) do |page|
    RSpec.capture_assertions do
      expect(page.comparable_quote_section[0].quote_premium).not_to eq(page.quote_section[0].quote_premium), "Premium should be different in both the quote panels"
      expect(page.comparable_quote_section[0].package_discount).not_to eq(page.quote_section[0].package_discount_cmp), "Package discount should be different in both the quote panels"
      expect(page.comparable_quote_section[0].deductible).not_to eq(page.quote_section[0].deductible), "Premium should be different in both the quote panels"
      expect(page.comparable_quote_section[0].apply_to_quote?).to be_truthy
    end
  end
end

When(/^I upgrade deductible from the quote options page to "\$5,000"$/) do |value|
  on(QuoteManagementPage) do |page|
    @expected_enhanced_auto = value
    page.quote_section.first.deductible.set(value)
    page.scroll.to :top
    page.recalculate
    page.wait_for_processing_overlay_to_close
    page.save_changes
  end
end

Then(/^premium should be same on both the Quote panels in dwelling$/) do
  on(QuoteManagementPage) do |page|
    RSpec.capture_assertions do
      expect(page.comparable_quote_section[0].quote_premium).to eq(page.quote_section[0].quote_premium), "Premium should be same in both the quote panels"
      expect(page.comparable_quote_section[0].package_discount).to eq(page.quote_section[0].package_discount_cmp), "Package discount should be same in both the quote panels"
    end
  end
end

Then(/^Panel 2 should display upgrades for the premium and others for scheduled property$/) do
  on(QuoteManagementPage) do |page|
    RSpec.capture_assertions do
      expect(page.comparable_quote_section[0].quote_premium).not_to eq(page.quote_section[0].quote_premium), "Premium should be different in both the quote panels"
      expect(page.comparable_quote_section[0].package_discount).not_to eq(page.quote_section[0].package_discount_cmp), "Package discount should be different in both the quote panels"
      expect(page.comparable_quote_section[0].apply_to_quote?).to be_truthy
    end
  end
end