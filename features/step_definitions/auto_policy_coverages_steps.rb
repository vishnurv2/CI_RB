# frozen_string_literal: true
#

And(/^I should see the following toggle options available in the auto policy coverages modal$/) do |table|
  expected = table.rows
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    RSpec.capture_assertions do
      expected.each do |value|
        field = modal.send("#{value.join.to_s}".snakecase)
        expect(field.present?).to be_truthy, "Option #{value} not found in Policy Level Coverages modal!"
      end
    end
  end
end

When(/^I select "([^"]*)" for the liability type in the auto policy coverages modal$/) do |type|
  on(AutoPolicySummaryPage).auto_policy_coverages_modal.liability_type = type
end

When(/^I modify the policy level coverages$/) do
  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :center
    page.policy_coverages_panel.modify
  end
end

Then(/^I should see the following auto liability options in the auto policy coverages modal$/) do |table|
  expected = table.rows.flatten
  field_type = table.headers.join.to_s

  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    modal.medical_payments_coverage = "true" if field_type == "medical_payments"
    modal.uninsured_underinsured_property_damage.check unless modal.uninsured_underinsured_property_damage.checked?
    select_list = modal.send("#{field_type}_element".snakecase).options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found in #{field_type}"
      end
    end
  end
end

And(/^the coverages I entered display in the auto coverages panel$/) do
  #@browser.refresh this should be updating via ajax now
  on(AutoPolicySummaryPage) do |page|
    panel = page.policy_coverages_panel
    expected = data_for('expected_auto_policy_level_coverages')

    RSpec.capture_assertions do
      expected.keys.each do |which|
        next unless expected.key?(which.to_s)

        actual = panel.send(which)
        expect(actual).to eq(expected[which.to_s]), "Expected #{which} to be #{expected[which.to_s]} but it is #{actual}"
      end
    end
  end
end

When(/^I (add|remove) the policy level optional coverage "([^"]*)"$/) do |add_or_remove, coverage|
  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :center
    page.policy_optional_coverages_panel.modify
    page.wait_for_ajax

    modal = page.auto_policy_optional_coverages_modal
    toggle = if add_or_remove == "add"
               true
             else
               false
             end

    modal.send("#{coverage.snakecase}").set toggle

    #below is old way, NOW they are toggle switches.
    #modal.handle_bool_coverage(coverage, add_or_remove == 'add')
    #modal.populate
    #@saved_driver = modal.eno_driver if coverage == 'Extended Non-Owned Coverage' && modal.eno_coverage_selection == 'Named Individual'
    modal.save
  end
end

Then(/^the "([^"]*)" should be applied$/) do |item|
  on(AutoPolicySummaryPage) do |page|
    panel = page.policy_optional_coverages_panel
    actual = panel.send("#{item.snakecase}")

    expect(actual.downcase.include? 'applie').to be_truthy, "Expected to see \"#{item}\" applied in the optional coverages panel, but it was \"#{actual}\""
  end
end

Then(/^I (should|should not) see the property damage deductible label and dropdown$/) do |should_or_not|
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      should_or_not_boolean = (should_or_not == 'should')
      modal = page.auto_policy_coverages_modal
      expect(modal.uninsured_motorist_property_damage_label? && modal.uninsured_motorist_property_damage_label_element.present?).to eq(should_or_not_boolean), 'Expected property damage deductible label to be present but it was not'
      #expect(modal.uninsured_motorist_property_deductible? && modal.uninsured_motorist_property_deductible_element.present?).to eq(should_or_not_boolean), 'Expected property damage deductible to be present but it was not'
    end
  end
end

When(/^I (check|uncheck) the decline property damage coverage checkbox$/) do |check_or_not|
  answer = (check_or_not == "check") ? false : true
  on(AutoPolicySummaryPage).auto_policy_coverages_modal.uninsured_underinsured_coverage = answer
end

############ Everything below this line is unverified #############

And(/^I should not see the following fields in the auto policy coverages modal$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    RSpec.capture_assertions do
      table.rows.flatten.each do |field|
        expect(modal.send("#{field.snakecase}?")).to be_falsey, "#{field} was visible when it should be hidden"
      end
    end
  end
end

And(/^I should see the correct default values for the following fields in the auto policy coverages modal$/) do |table|
  rows = table.rows.to_h
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    RSpec.capture_assertions do
      rows.each do |field, expected|
        actual = modal.send(field.snakecase)
        expect(actual).to eq(expected), "The default value for #{field} should '#{expected}' but it is '#{actual}'"
      end
    end
  end
end

And(/^I select "([^"]*)" for the "([^"]*)" option in the auto policy coverages modal$/) do |opt, list|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    modal.uninsured_underinsured_coverage = true
    modal.send("#{list.snakecase}=", opt)
  end
  #on(AutoPolicySummaryPage).auto_policy_coverages_modal.send("#{list.snakecase}=", opt)
end

And(/^the "([^"]*)" should match the "([^"]*)" value in the auto policy coverages modal$/) do |field1, field2|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    expect(modal.send(field1).text).to eq(modal.send(field2).text), "#{field1} does not match #{field2}"
  end
end

Then(/^the coverages should have the correct default values in the auto coverages panel$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.policy_coverages_panel
    expected = { bodily_injury_liability: 'None Selected', medical_payments: 'No Med Pay Coverage',
                 property_damage_liability: '', enhanced_coverage: 'None' }

    RSpec.capture_assertions do
      %i[bodily_injury_liability medical_payments property_damage_liability enhanced_coverage].each do |which|
        next unless expected.key?(which.to_s)

        actual = panel.send(which)
        expect(actual).to eq(expected[which.to_s])
      end
    end
  end
end

Then(/^I should see the following auto vehicle coverages available$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    expect(modal.coverages_list.items.sort).to eq(table.rows.flatten.sort)
  end
end

And(/^I should see the following deductible options for the auto vehicle coverages$/) do |table|
  expected = {}
  table.rows.each { |r| expected[r[0]] ||= []; expected[r[0]] << r[1] }

  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    RSpec.capture_assertions do
      expected.each do |field, values|
        modal.coverages_list.select_coverage(field)
        modal.coverages_list.coverage_deductible(field).click
        deductibles = page.div(class: /p-dropdown-items-wrapper/).lis.map(&:text)
        # deductibles = modal.coverages_list.coverage_deductible(field).lis.map(&:text)
        expect(deductibles).to eq(values)
        #adding another click to clear the drop down select
        modal.coverages_list.coverage_deductible(field).click
      end
    end
  end
end

Then(/^I (.*) have the ability to set the coverage limit for extended transportation$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    modal.coverages_list.select_coverage("Extended Transportation")
    expect(modal.coverages_list.coverage_deductible("Extended Transportation").present?).to eq(which == 'should')
  end
end

And(/^I should see (.*) for the already included in personal limit for extended transportation$/) do |message|
  expect(on(AutoPolicySummaryPage).ext_trans_details.personal_limit.delete(' ').delete('.00').delete(',').delete('$').downcase).to eq(message.delete(' ').delete('.00').delete(',').delete('$').downcase)
end

And(/^I should see (.*) for the already included limit for extended transportation$/) do |enhanced_message|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    expect(page.ext_trans_details.enhanced_limit.delete(' ').delete('.00').delete(',').delete('$').downcase).to eq(enhanced_message.delete(' ').delete('.00').delete(',').delete('$').downcase) unless modal.coverages_list.coverage_deductible("Extended Transportation").present?
  end
end

Then(/^I (.*) see the extended transportation coverage$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    actual = modal.coverages_list.select_coverage("Extended Transportation").nil?
    expect(actual).to eq(which == 'should not')
  end
end

Then(/^I should see these auto policy optional coverages available$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    page.policy_optional_coverages_panel.modify unless modal.present?
    RSpec.capture_assertions do
      table.rows.flatten.sort.each { |c| expect(modal.send(c.snakecase).present?).to be_truthy, "Expected to see #{c} in the optional coverages modal, but it could not be found" }
    end
  end
end

When(/^I modify the auto policy optional coverages$/) do
  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :center
    page.policy_optional_coverages_panel.modify
    modal = page.auto_policy_optional_coverages_modal
    mexico_coverage = modal.mexico_coverage
    @modified_optional_coverages = []
    Watir::Wait.until(message: 'Timed out waiting for the corporate auto coverage check box to be present on the optional coverages modal') { modal.corporate_auto_coverage_element.present? }
    @modified_optional_coverages << ['Corporate Auto Coverage', modal.corporate_auto_coverage_element.value] if modal.corporate_auto_coverage_element.present?
    @modified_optional_coverages << ['Extended Non-Owned Coverage', modal.extended_non_owned_coverage_element.value] if modal.extended_non_owned_coverage_element.present?
    @modified_optional_coverages << ['Manual Coverage', modal.manual_coverage_element.value] if modal.manual_coverage_element.present?
    @modified_optional_coverages << ['Mexico Coverage', mexico_coverage.value] if mexico_coverage.present?
    mexico_coverage.set(!mexico_coverage.value)
    @modified_optional_coverages.each { |c| c[1] = !c[1] if c[0].include? 'exico' }
    modal.save_and_close
  end
end

Then(/^I should see the modified auto policy optional coverage selections in the panel$/) do
  on(AutoPolicySummaryPage) do |page|
    actual_coverages = page.policy_optional_coverages_panel.coverages.sort
    expected_coverages = @modified_optional_coverages.sort
    expect(actual_coverages.map { |c| c[1] }).to eq(expected_coverages.map { |c| c[1] }), "Auto Summary, Optional Coverages Panel\r\nExpected:   #{expected_coverages}\r\nActual:     #{actual_coverages}"
  end
end

Then(/^I should see the modified auto policy optional coverage selections in the modal$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    page.policy_optional_coverages_panel.modify unless modal.present?
    actual_coverages = []
    Watir::Wait.until(message: 'Timed out waiting for the corporate auto coverage check box to be present on the optional coverages modal') { modal.corporate_auto_coverage_element.present? }
    actual_coverages << ['Corporate Auto Coverage', modal.corporate_auto_coverage_element.value] if modal.corporate_auto_coverage_element.present?
    actual_coverages << ['Extended Non-Owned Coverage', modal.extended_non_owned_coverage_element.value] if modal.extended_non_owned_coverage_element.present?
    actual_coverages << ['Manual Coverage', modal.manual_coverage_element.value] if modal.manual_coverage_element.present?
    actual_coverages << ['Mexico Coverage', modal.mexico_coverage_element.value] if modal.mexico_coverage_element.present?
    expected_coverages = @modified_optional_coverages.sort
    expect(actual_coverages.map { |c| c[1] }).to eq(expected_coverages.map { |c| c[1] }), "Auto Summary, Optional Coverages Modal\r\nExpected:   #{expected_coverages}\r\nActual:     #{actual_coverages}"
  end
end

Then(/^I should see the (.*) auto policy optional coverages available$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  expected_coverages = data_for('optional_coverages_panel')['coverages'].sort.map(&:snakecase)
  on(AutoPolicySummaryPage) do |page|
    page.policy_optional_coverages_panel.modify unless page.auto_policy_optional_coverages_modal.present?
    modal = page.auto_policy_optional_coverages_modal
    actual_coverages = modal.available_coverages.sort.map(&:snakecase)
    expect(actual_coverages).to eq(expected_coverages), "Expected the optional coverages modal to contain the following coverages #{expected_coverages}, but found #{actual_coverages}"
    modal.save_and_close
    actual_optional_coverages = page.policy_optional_coverages_panel.coverage_names_applies.sort.map { |c| c[0].snakecase }
    expect(actual_optional_coverages).to eq(expected_coverages), "Expected the optional coverages panel to contain the following coverages #{expected_coverages}, but found #{actual_coverages}"
  end
end

Then(/^the policy (should|should not) have the coverage "([^"]*)"$/) do |should_or_not, coverage|
  on(AutoPolicySummaryPage) do |page|
    page.policy_optional_coverages_panel.modify
    page.wait_for_modal_or_error
    actual_optional_coverages = page.auto_policy_optional_coverages_modal.coverages_values
    if should_or_not == 'should'
      expect(actual_optional_coverages.include?([coverage, should_or_not == 'should'])).to be_truthy
    else
      expect(actual_optional_coverages.include?([coverage, should_or_not == 'should'])).to be_falsey
    end
  end
end

Then(/^the policy (should|should not) display the coverage "([^"]*)"$/) do |should_or_not, coverage|
  on(AutoPolicySummaryPage) do |page|
    page.policy_optional_coverages_panel.modify
    page.wait_for_modal_or_error
    actual_optional_coverages = page.auto_policy_optional_coverages_modal.coverages
    if should_or_not == 'should'
      expect(actual_optional_coverages.include?([coverage])).to be_truthy
    else
      expect(actual_optional_coverages.include?([coverage])).to be_falsey
    end
  end
end

When(/^I update the coverages using the (.*) fixture$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)

  @data_from_fixture = data_for('auto_policy_level_coverages_modal')

  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :center
    page.policy_coverages_panel.modify
    modal = page.auto_policy_coverages_modal
    page.wait_for_ajax
    modal.populate_with(@data_from_fixture)
    modal.save_changes
  end
end

Then(/^I enter coverage A and validate wind hail deductible values as per policy deductible value$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    modal.coverage_a_dwelling = true
    modal.coverage_a_dwelling_text = '$100000'

    modal.deductible = 1
    select_list = modal.wind_hail_deductible.options true
    expect(select_list.include?('1%')).to be_falsey
    expect(select_list.include?('$1,000')).to be_falsey

    modal.deductible = 2
    select_list = modal.wind_hail_deductible.options true
    expect(select_list.include?('1%')).to be_falsey
    expect(select_list.include?('$1,000')).to be_falsey
    expect(select_list.include?('2%')).to be_falsey
    expect(select_list.include?('$2,000')).to be_falsey

    modal.deductible = 3
    select_list = modal.wind_hail_deductible.options true
    expect(select_list.include?('1%')).to be_falsey
    expect(select_list.include?('$1,000')).to be_falsey
    expect(select_list.include?('2%')).to be_falsey
    expect(select_list.include?('$2,000')).to be_falsey
    expect(select_list.include?('5%')).to be_falsey
    expect(select_list.include?('$5,000')).to be_falsey

    modal.deductible = 4
    select_list = modal.wind_hail_deductible.options true
    expect(select_list.include?('1%')).to be_falsey
    expect(select_list.include?('$1,000')).to be_falsey
    expect(select_list.include?('2%')).to be_falsey
    expect(select_list.include?('$2,000')).to be_falsey
    expect(select_list.include?('5%')).to be_falsey
    expect(select_list.include?('$5,000')).to be_falsey
    expect(select_list.include?('7.5%')).to be_falsey
    expect(select_list.include?('$7,500')).to be_falsey

    modal.deductible = 5
    select_list = modal.wind_hail_deductible.options true
    expect(select_list.include?('1%')).to be_falsey
    expect(select_list.include?('$1,000')).to be_falsey
    expect(select_list.include?('2%')).to be_falsey
    expect(select_list.include?('$2,000')).to be_falsey
    expect(select_list.include?('5%')).to be_falsey
    expect(select_list.include?('$5,000')).to be_falsey
    expect(select_list.include?('7.5%')).to be_falsey
    expect(select_list.include?('$7,500')).to be_falsey
    expect(select_list.include?('10%')).to be_falsey
    expect(select_list.include?('$10,000')).to be_falsey
  end
end

Then(/^I (should|should not) see the property damage coverage checkbox$/) do |should_or_not|
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      should_or_not_boolean = (should_or_not == 'should')
      modal = page.auto_policy_coverages_modal
      Watir::Wait.until(timeout: 5, message: "Expected the property damage checkbox#{should_or_not.gsub('should', '')} to be present") { modal.uninsured_underinsured_property_damage? == should_or_not_boolean }
    end
  end
end

Then(/^the property damage coverage checkbox (should|should not) be checked$/) do |should_or_not|
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      should_or_not_boolean = (should_or_not == 'should')
      modal = page.auto_policy_coverages_modal
      Watir::Wait.until(timeout: 5, message: 'Timed out waiting for the property damage deductible check box to be present') { modal.uninsured_underinsured_property_damage? }
      expect(modal.uninsured_underinsured_property_damage.checked?).to eq(should_or_not_boolean), "Expected the property damage checkbox#{should_or_not.gsub('should', '')} to be checked"
    end
  end
end

When(/^I select (.*) for the enhanced auto coverage on the auto policy coverages modal$/) do |enhanced_selection|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    if (enhanced_selection.include? 'lus')
      modal.auto_plus.select
    elsif (enhanced_selection.include? 'ignature')
      modal.signature.select
    elsif (enhanced_selection.include? 'ummit')
      modal.summit.select
    else
      modal.decline_enhanced_auto_coverage.select
    end
  end
end

And(/^I provide details for auto policy optional coverages modal "([^"]*)"$/) do |coverage|
  @data_from_fixture = data_for('auto_policy_optional_coverages_modal')
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    page.wait_for_ajax
    modal.populate_with(@data_from_fixture)
    @saved_driver = modal.eno_driver.text if coverage == 'Extended Non-Owned Coverage' && modal.eno_coverage_selection.label(class: /p-radiobutton-label p-radiobutton-label-active/).text == 'Named Individual'
    modal.save
  end
end

And(/^I open and save the coverages$/) do
  on(PolicyManagementPage) do |page|
    menu_item = page.left_nav.find_option_containing('IN - ')
    menu_item.click unless menu_item.active?
  end

  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :center
    page.policy_coverages_panel.modify
    page.wait_for_ajax
    page.auto_policy_coverages_modal.save_and_close
  end
end

When(/^I add named non owned coverage with option "([^"]*)" in policy level coverages modal$/) do |opt|
  on(AutoPolicySummaryPage) do |page|
    page.policy_coverages_panel.modify
    page.wait_for_modal_or_error
    modal = page.auto_policy_coverages_modal
    modal.decline_enhanced_auto_coverage_element.click
    modal.named_non_owner = true
    modal.named_individual_resident_relatives = opt
    modal.save_and_close_btn
    page.wait_for_processing_overlay_to_close
    if modal.present?
      modal.save_and_close
    end
  end
end

And(/^I validate default values in umbrella policy coverages modal$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    expect(modal.total_limit_liability.text == '$1,000,000').to be_truthy
    expect(modal.umbrella_enhanced_coverage.checked?).to be_falsey
    expect(modal.personal_injury_coverage.checked?).to be_falsey
    expect(modal.umbrella_uninsured_underinsured.checked?).to be_falsey
    expect(modal.total_limit.present?).to be_falsey
  end
end

And(/^I validate total limit must be equal to or less than limit of liability$/) do |table|
  expected = {}
  table.rows.each { |r| expected[r[0]] ||= []; expected[r[0]] << r[1] }

  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    RSpec.capture_assertions do
      expected.each do |field, values|
        modal.total_limit_liability.select(field)
        if modal.umbrella_uninsured_underinsured.checked?
          modal.total_limit.click
        else
          modal.umbrella_uninsured_underinsured = true
          modal.total_limit.click
        end
        total_limit_values = page.div(class: /p-dropdown-items-wrapper/).lis.map(&:text)
        # total_limit_values = modal.total_limit.lis.map(&:text)
        expect(total_limit_values).to eq(values)
      end
    end
  end
end

Then(/^I validate Emergency Service Expanded Coverage when Enhanced Coverage Summit is selected$/) do
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_optional_coverages_panel.modify if !page.auto_policy_optional_coverages_modal?
    page.wait_for_modal_or_error
    modal = page.auto_policy_optional_coverages_modal
    expect(modal.emergency_service_expanded_coverage.disabled?).to be_truthy
    expect(modal.wes_limit_included?).to be_truthy
    expect(modal.wes_total_limit.disabled? && modal.wes_total_limit.text == "$1,000 (Included)").to be_truthy
  end
end

And(/^validate Personal Effects when Enhanced Coverage Summit is selected$/) do
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_optional_coverages_panel.modify if !page.auto_policy_optional_coverages_modal?
    page.wait_for_modal_or_error
    modal = page.auto_policy_optional_coverages_modal
    expect(modal.personal_effects.disabled?).to be_truthy
    expect(modal.wpe_total_limit_element.enabled? && modal.wpe_total_limit == '$1,500').to be_truthy
    expect(modal.wpe_limit_included?).to be_truthy
    # expect(modal.wpe_included?).to be_truthy
  end
end

And(/^validate Boating Equipment Coverage Increase$/) do
  @data_from_fixture = data_for('auto_policy_optional_coverages_modal')
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_optional_coverages_panel.modify if !page.auto_policy_optional_coverages_modal?
    page.wait_for_modal_or_error
    modal = page.auto_policy_optional_coverages_modal
    expect(modal.boating_equipment_coverage_increase.enabled?).to be_truthy
    if modal.boating_equipment_coverage_increase.checked?
      expect(modal.wbe_warning_msg?).to be_truthy
      expect(modal.wbe_bt0100?).to be_truthy
      expect(modal.wbe_total_limit == @data_from_fixture['wbe_total_limit'] && modal.wbe_total_limit_element.enabled?).to be_truthy
    end
  end
end

Then(/^I validate Emergency Service Expanded Coverage when Enhanced Coverage Summit is not selected$/) do
  @data_from_fixture = data_for('auto_policy_optional_coverages_modal')
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_optional_coverages_panel.modify if !page.auto_policy_optional_coverages_modal?
    page.wait_for_modal_or_error
    modal = page.auto_policy_optional_coverages_modal
    expect(modal.emergency_service_expanded_coverage.enabled?).to be_truthy
    expect(modal.wes_limit_included?).to be_falsey
    expect(modal.wes_total_limit.enabled? && modal.wes_total_limit.text == @data_from_fixture['wes_total_limit']).to be_truthy
  end
end

And(/^validate Personal Effects when Enhanced Coverage Summit is not selected$/) do
  @data_from_fixture = data_for('auto_policy_optional_coverages_modal')
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_optional_coverages_panel.modify if !page.auto_policy_optional_coverages_modal?
    page.wait_for_modal_or_error
    modal = page.auto_policy_optional_coverages_modal
    expect(modal.personal_effects.enabled?).to be_truthy
    expect(modal.wpe_total_limit_element.enabled? && modal.wpe_total_limit == @data_from_fixture['wpe_total_limit']).to be_truthy
    expect(modal.wpe_limit_included?).to be_falsey
    expect(modal.wpe_included?).to be_falsey
  end
end

And(/^I provide details for watercraft policy optional coverages modal$/) do
  @data_from_fixture = data_for('auto_policy_optional_coverages_modal')
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    page.wait_for_ajax
    modal.populate_with(@data_from_fixture)
    modal.save
  end
end

And(/^I validate default values of Boating Equipment Coverage Increase$/) do
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_optional_coverages_panel.modify if !page.auto_policy_optional_coverages_modal?
    page.wait_for_modal_or_error
    modal = page.auto_policy_optional_coverages_modal
    #expect(modal.boating_equipment_coverage_increase.enabled? && !modal.boating_equipment_coverage_increase.checked?).to be_truthy
    modal.boating_equipment_coverage_increase = true
    expect(modal.wbe_warning_msg?).to be_truthy
    expect(modal.wbe_bt0100?).to be_truthy
    expect(modal.wbe_total_limit == '$2,500' && modal.wbe_total_limit_element.enabled?).to be_truthy
    expect(modal.wbe_selected_limit_error_msg?).to be_truthy
    modal.wbe_total_limit = '$2,499' #providing value less than $2,500
    expect(modal.wbe_included_limit_error_msg?).to be_truthy

  end
end

And(/^I validate default values of uninsured underinsured coverage$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_coverages_modal
    modal.total_limit_liability = '$5,000,000'
    modal.umbrella_uninsured_underinsured = true
    expect(modal.uninsured_toggle_element.div(class: /p-highlight/).span.text == "Uninsured / Underinsured Motorist").to be_truthy
    expect(modal.total_limit.text == modal.total_limit_liability.text).to be_truthy
  end
end

And(/^I populate and (save and close|save and continue) the auto policy coverages using "([^"]*)" fixture$/) do |which, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  @data_from_fixture = data_for('auto_policy_level_coverages_modal')
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    modal.populate_with(@data_from_fixture)
    modal.send("#{which.snakecase}")
  end
end

Then(/^I verify the details present on auto policy coverages modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    if modal.water_backup_sump.checked?
      expect(modal.essential_circuit_standby_generator.checked?).to eq(@data_from_fixture['essential_circuit_standby_generator'])
      expect(modal.non_electrical_backup_sump.checked?).to eq(@data_from_fixture['non_electrical_backup_sump'])
      expect(modal.generator_portable.checked?).to eq(@data_from_fixture['generator_portable'])
    else
      expect(modal.essential_circuit_standby_generator.present?).to be_falsey
      expect(modal.non_electrical_backup_sump.present?).to be_falsey
      expect(modal.generator_portable.present?).to be_falsey
    end
  end
end

Then(/^I verify the disabled water backup details present on auto policy coverages modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    expect(modal.water_backup_sump.checked? && modal.water_backup_sump.disabled?).to be_truthy
    expect(modal.essential_circuit_standby_generator.checked?).to eq(@data_from_fixture['essential_circuit_standby_generator'])
    expect(modal.non_electrical_backup_sump.checked?).to eq(@data_from_fixture['non_electrical_backup_sump'])
    expect(modal.generator_portable.checked?).to eq(@data_from_fixture['generator_portable'])
  end
end

And(/^I validate limit included message and total limit field for personal property self storage$/) do
  @data_from_fixture = data_for('personal_property_self_storage')
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    expect(modal.property_limit_included_message).to eq(@data_from_fixture['limit_included_message'])
    modal.home_property_located_self_storage_limit = @data_from_fixture['total_limit']
    expect(modal.total_limit_error_message.include? @data_from_fixture['total_limit_error_message']).to be_truthy
  end
end

And(/^I save the coverages provided on policy level coverages modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    @medical_payment = modal.coverage_f_medical.text
    @personal_liability = modal.coverage_e_personal.text
    modal.save_and_close
  end
end

Then(/^I should see these watercraft policy optional coverages available$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    page.policy_optional_coverages_panel.modify unless modal.present?
    RSpec.capture_assertions do
      table.rows.flatten.sort.each { |c| expect(modal.send(c.snakecase).present?).to be_truthy, "Expected to see #{c} in the optional coverages modal, but it could not be found" }
    end
  end
end

Then(/^I validate all the optional coverages are present on Policy Level Optional Coverages panel$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.watercraft_optional_coverages_panel
    RSpec.capture_assertions do
      expect(panel.boating_equipment_coverage_increase_element.present?).to be_truthy, "Expected to see boating equipment coverage increase in the optional coverages panel, but it could not be found"
      expect(panel.emergency_service_expanded_coverage_element.present?).to be_truthy, "Expected to see emergency service expanded coverage in the optional coverages panel, but it could not be found"
      expect(panel.manual_coverage_element.present?).to be_truthy, "Expected to see manual coverage in the optional coverages panel, but it could not be found"
      expect(panel.personal_effects_element.present?).to be_truthy, "Expected to see personal effects in the optional coverages panel, but it could not be found"
      expect(panel.boating_equipment_coverage_increase_selected_element.present?).to be_truthy, "Expected to see SELECTED with boating equipment coverage increase in the optional coverages panel, but it could not be found"
      expect(panel.emergency_service_expanded_coverage_selected_element.present?).to be_truthy, "Expected to see SELECTED with emergency service expanded coverage in the optional coverages panel, but it could not be found"
      expect(panel.manual_coverage_selected_element.present?).to be_truthy, "Expected to see SELECTED with manual coverage in the optional coverages panel, but it could not be found"
      expect(panel.personal_effects_selected_element.present?).to be_truthy, "Expected to see SELECTED with personal effects in the optional coverages panel, but it could not be found"
    end
  end
end

Then(/^I validate "([^"]*)" present on Policy Level Optional Coverages panel$/) do |coverage|
  on(AutoPolicySummaryPage) do |page|
    panel = page.watercraft_optional_coverages_panel
    expect(panel.send("#{coverage.snakecase}")).to be_truthy, "Expected to see #{coverage} in the optional coverages modal, but it could not be found"
    expect(panel.send("#{coverage}_selected".snakecase)).to be_truthy, "Expected to see #{coverage}_selected in the optional coverages modal, but it could not be found"
  end
end

Then(/^I should see these dwelling policy optional coverages available$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    page.policy_optional_coverages_panel.modify unless modal.present?
    RSpec.capture_assertions do
      table.rows.flatten.sort.each { |c| expect(modal.send(c.snakecase).present?).to be_truthy, "Expected to see #{c} in the optional coverages modal, but it could not be found" }
    end
  end
end

Then(/^I validate all the dwelling optional coverages are present on Policy Level Optional Coverages panel$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.dwelling_optional_coverages_panel
    RSpec.capture_assertions do
      expect(panel.animal_exclusion_endorsement_element.present?).to be_truthy
      expect(panel.improvements_alterations_and_additions_element.present?).to be_truthy
      expect(panel.ordinace_or_law_increased_limit_element.present?).to be_truthy
      expect(panel.theft_of_building_materials_element.present?).to be_truthy
      expect(panel.business_pursuits_element.present?).to be_truthy
      expect(panel.canine_exclusion_endorsement_element.present?).to be_truthy
      expect(panel.earthquake_element.present?).to be_truthy
      expect(panel.equipment_breakdown_element.present?).to be_truthy
      expect(panel.functional_replacement_cost_loss_settlement_element.present?).to be_truthy
      expect(panel.limited_fungi_wet_or_dry_rot_or_bacteria_coverage_element.present?).to be_truthy
      expect(panel.loss_assessment_residence_premises_element.present?).to be_truthy
      expect(panel.manual_coverage_element.present?).to be_truthy
      expect(panel.other_structures_exclusion_endorsement_element.present?).to be_truthy
      expect(panel.replacement_cost_on_the_dwelling_additional_amount_element.present?).to be_truthy
      expect(panel.other_structures_exclusion_endorsement_element.present?).to be_truthy
      expect(panel.theft_element.present?).to be_truthy
      expect(panel.animal_exclusion_endorsement_selected_element.present?).to be_truthy
      #expect(panel.actual_cash_value_loss_settlement_element.present?).to be_truthy
    end
  end
end

And(/^I provide details for dwelling policy optional coverages modal$/) do
  @data_from_fixture = data_for('auto_policy_optional_coverages_modal')
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    page.wait_for_ajax
    modal.populate_with(@data_from_fixture)
    modal.save
  end
end

Then(/^I validate "([^"]*)" present on Policy Level Optional Coverages dwelling panel$/) do |coverage|
  on(AutoPolicySummaryPage) do |page|
    panel = page.dwelling_optional_coverages_panel
    expect(panel.send("#{coverage.snakecase}")).to be_truthy, "Expected to see #{coverage} in the optional coverages modal, but it could not be found"
    expect(panel.send("#{coverage}_selected".snakecase)).to be_truthy, "Expected to see #{coverage}_selected in the optional coverages modal, but it could not be found"
  end
end

Then(/^I should see the schedule property classes coverage$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    modal = page.scheduled_property_classes_modal
    page.schedule_property_classes_panel.modify unless modal.present?
    RSpec.capture_assertions do
      table.rows.flatten.sort.each { |c| expect(modal.send(c.snakecase).present?).to be_truthy, "Expected to see #{c} in the optional coverages modal, but it could not be found" }
    end
  end
end

And(/^I provide details for scheduled property policy optional coverages modal$/) do
  @data_from_fixture = data_for('scheduled_property_classes_modal')
  on(AutoPolicySummaryPage) do |page|
    modal = page.scheduled_property_classes_modal
    page.wait_for_ajax
    sleep 4
    modal.populate_with(@data_from_fixture)
    modal.save
  end
end

Then(/^I validate "([^"]*)" present on scheduled property classes and items coverages panel$/) do |item|
  on(AutoPolicySummaryPage) do |page|
    product = page.scheduled_property_classes_and_items_panel
    expect(product.category).to eq(item)
    expect(product.blanket_amount).to eq(+"$" + @data_from_fixture['blanket_total_amount'] + ".00")
    expect(product.blanket_deductible).to eq(@data_from_fixture['blanket_deductible'] + ".00")
    expect(product.blanket_per_item).to eq(@data_from_fixture['blanket_per_item_amount'] + ".00")
  end
end

Then(/^I validate "([^"]*)" present on scheduled property classes and items coverages panel with diff heading$/) do |item|
  on(AutoPolicySummaryPage) do |page|
    product = page.scheduled_property_classes_and_items_panel
    expect(product.category.remove(' 1')).to eq(item)
    expect(product.total_vehicle).to eq(+"$" + @data_from_fixture['amount_of_insurance'] + ".00")
    expect(product.deductible).to eq(@data_from_fixture['deductible_vehicles'] + ".00")
  end
end

And(/^I should see a validation error message "([^"]*)" in policy coverage modal$/) do |validation_message|
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    expect(modal.coverage_c_element.parent.following_sibling.text).to eq(validation_message)
  end
end

When(/^I modify the policy level coverages scrolling by property panel$/) do
  on(AutoPolicySummaryPage) do |page|
    page.property_panel_element.scroll.to
    #page.scroll.to :center
    page.policy_coverages_panel.modify
  end
end

And(/^I click on Add Item to add another category$/) do
  on(PolicyManagementPage) do |page|
    #page.scheduled_property_classes_modal.add_item_element.scroll.to
    page.scheduled_property_classes_modal.add_item
  end
end

And(/^I populate data for "([^"]*)" category$/) do |category|
  if category == 'Trailer'
    @category_data = data_for('category_trailer')
  else
    @category_data = data_for('category_equipment')
  end
  on(PolicyManagementPage) do |page|
    modal = page.scheduled_property_classes_modal
    page.wait_for_ajax
    modal.populate_with(@category_data)
  end
end

And(/^I (add|remove) and provide details for auto extended non owned coverage$/) do |add_or_remove|
  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :center
    page.policy_optional_coverages_panel.modify
    page.wait_for_ajax

    modal = page.auto_policy_optional_coverages_modal
    toggle = if add_or_remove == "add"
               true
             else
               false
             end

    modal.extended_non_owned_coverage.set toggle

    modal.eno_coverage_selection = 'Named Individual'
    modal.eno_driver = 1 if modal.eno_coverage_selection.label(class: /p-radiobutton-label p-radiobutton-label-active/).text == 'Named Individual'
    modal.save
  end
end

And(/^I validate and provide named non owner details$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    modal.named_non_owner = true
    expect(modal.named_non_owner_label).to eq("Coverage Option")
    modal.named_individual_resident_relatives = "Named Individual"
    modal.save_and_close
    page.wait_for_ajax
  end
end

And(/^I validate coverages on auto policy coverages modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_coverages_modal
    expect(modal.watercraft_personal_liability.checked?).to be_truthy
    expect(modal.watercraft_medical_payments.checked?).to be_truthy
    modal.watercraft_personal_liability = false
    modal.save_and_continue
    page.wait_for_ajax
    expect(modal.error_message_text).to eq("Medical Payment coverage requires Personal Liability coverage")
    modal.watercraft_personal_liability = true
    modal.watercraft_medical_payments = false
    modal.save_and_continue
    page.wait_for_ajax
    expect(modal.error_message_text).to eq("Personal Liability coverage requires Medical Payment coverage")
  end
end

And(/^I validate number of acres for home with farm land rented to others$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_policy_optional_coverages_modal
    modal.farmers_personal_liability = true
    modal.farmers_personal_liability_type = 'Rented to Others'
    modal.farmers_total_acres = '0'
    modal.save_and_close
    expect(modal.no_of_acres_error_message).to eq("Total Number of Acres must be at least 1")
  end
end