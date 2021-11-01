# frozen_string_literal: true

When(/^I edit the first driver$/) do
  on(AutoPolicySummaryPage) do |page|
    driver = page.driver_info_panel.drivers.first
    driver.edit
    modal = page.auto_driver_modal
    fn = modal.first_name.reverse
    ln = modal.last_name.reverse
    @edited_driver = { first_name: fn, last_name: ln }
    modal.populate_with @edited_driver
    modal.save
  end
end

Then(/^The edited driver info should display in the driver grid on the auto summary page$/) do
  on(AutoPolicySummaryPage) do |page|
    found_driver = page.driver_info_panel.find_driver_by_hash(@edited_driver)
    driver_data = '{ '
    AutoDriverInformationPanel::FIELDS.keys.each { |k| driver_data += "#{k}: \"#{@edited_driver[k]}\" " unless @edited_driver[k].nil? }
    driver_data += '}'

    expect(found_driver.nil?).to be_falsey, "Expected to find #{driver_data} in the driver grid, but the driver was not found"
  end
end

# ------ Everything below this line is unverified ------------------------------------- #

When(/^I edit the first driver using modify on the driver information modal$/) do
  expected_driver = EDSL::PageObject.fixture_cache['auto_driver_modal']
  expected_driver.delete('driver_selection')
  on(AutoPolicySummaryPage) do |page|
    %w[first_name middle_name last_name].each { |field| expected_driver[field] = "MOD#{expected_driver[field]}" }
    page.driver_info_panel.modify
    page.auto_driver_modal.populate_with expected_driver
    page.auto_driver_modal.save_and_close
  end
end

Then(/^the drivers should display in the driver grid on the auto summary page$/) do
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      @added_drivers.each do |expected_driver|
        Watir::Wait.until(timeout: 5) { !page.driver_info_panel.find_driver_by_hash(expected_driver).nil? }
        actual_driver = page.driver_info_panel.find_driver_by_hash(expected_driver)
        expect(actual_driver).not_to be_nil, "Could not find #{expected_driver.slice('name_prefix', 'first_name', 'middle_name', 'last_name', 'name_suffix').values.join(' ')}"
      end
    end
  end
end

When(/^I assign a primary driver to each vehicle$/) do
  @driver_assignments = []
  on(AutoPolicySummaryPage) do |page|
    page.driver_assignment_panel.modify unless page.driver_assignment_modal?

    Watir::Wait.until { page.driver_assignment_modal? }
    modal = page.driver_assignment_modal
    page.wait_for_ajax
    modal.vehicle_panels.each_with_index do |p, i|
      p.primary_use_driver_element.select_index(i)
      @driver_assignments << { vehicle: p.grid_key, driver: p.primary_use_driver.text, use: 'Primary' }
    end
    modal.save_and_close
  end
end

When(/^I assign the first driver to each vehicle$/) do
  @driver_assignments = []
  on(AutoPolicySummaryPage) do |page|
    page.driver_assignment_panel.modify unless page.driver_assignment_modal?
    modal = page.driver_assignment_modal
    modal.vehicle_panels.each_with_index do |p, i|
      p.primary_use_driver_element.select_index(1)
      @driver_assignments << { vehicle: p.grid_key, driver: p.primary_use_driver, use: 'Primary' }
    end
    modal.save_and_close
  end
end

Then(/^The driver assignments should be displayed in the summary$/) do
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      assigned_drivers = page.driver_assignment_panel.assigned_drivers.map { |i| { vehicle: i.vehicle_key, driver: i.driver, use: i.use } }

      @driver_assignments.each do |assignment|
        expect(assigned_drivers.any? { assignment }).to be_truthy, "Expected #{assignment[:driver]} to be have a driver role of #{assignment[:use]} on #{assignment[:vehicle]} but they do not."
      end
    end
  end
end

When(/^I open the driver assignment modal$/) do
  on(AutoPolicySummaryPage).driver_assignment_panel.modify
end

Then(/^The applicants will be listed in the driver assignment modal$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.driver_assignment_modal
    expected_drivers = EDSL::PageObject.fixture_cache['auto_driver_modal']['drivers'].map { |d| "#{d.applicant_full_name.downcase.split(' (').first if d.applicant_full_name.match?(/\(\d+\)$/) }" }
    RSpec.capture_assertions do
      modal.vehicle_panels.each do |panel|
        options = panel.primary_use_driver_element.options.map { |i| i = i.downcase }
        delta = expected_drivers - options
        expect(delta).to be_empty, "One or more applicant is missing from the driver assignment list.\nMissing applicants are: #{delta.join(', ')}"
      end
    end
  end
end

When(/^I add a blank driver assignment$/) do
  on(AutoPolicySummaryPage) do |page|
    page.driver_assignment_panel.modify
    modal = page.driver_assignment_modal
    modal.save_and_close
  end
end

When(/^I assign a primary and secondary driver to each vehicle$/) do
  @driver_assignments = []

  on(AutoPolicySummaryPage) do |page|
    page.driver_assignment_panel.modify
    page.wait_for_modal_or_error
    modal = page.driver_assignment_modal
    modal.vehicle_panels.each do |p|
      p.primary_use_driver_element.select_index(0)
      @driver_assignments << { vehicle: p.grid_key, driver: p.primary_use_driver.text, use: 'Primary' }

      p.add_occasional_use_driver
      p.occasional_use_drivers.first.driver_element.select_index(1)
      @driver_assignments << { vehicle: p.grid_key, driver: p.occasional_use_drivers.first.driver.text, use: 'Occasional' }
    end
    modal.save_and_close
  end
end

When(/^I assign a primary driver to each vehicle without saving$/) do
  @driver_assignments = []

  on(AutoPolicySummaryPage) do |page|
    page.driver_assignment_panel.modify unless page.driver_assignment_modal?
    modal = page.driver_assignment_modal
    modal.vehicle_panels.each_with_index do |p, i|
      p.primary_use_driver_element.select_index(i + 1)
      @driver_assignments << { vehicle: p.grid_key, driver: p.primary_use_driver.text, use: 'Primary' }
    end
  end
end

Then(/^The drop downs for the primary and occasional use drivers should include all drivers$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.driver_assignment_modal
    expected_drivers = EDSL::PageObject.fixture_cache['auto_driver_modal']['drivers'].map { |d| "#{d.applicant_full_name.downcase.split(' (').first if d.applicant_full_name.match?(/\(\d+\)$/) }" }
    RSpec.capture_assertions do
      modal.vehicle_panels.each do |panel|
        panel.add_occasional_use_driver unless panel.occasional_use_drivers.count.positive?
        options = panel.occasional_use_drivers.first.driver_element.options.map { |i| i = i.downcase }
        delta = expected_drivers - options
        expect(delta).to be_empty, "One or more applicant is missing from the occasional driver assignment list.\nMissing applicants are: #{delta.join(', ')}"
        options = panel.primary_use_driver_element.options.map { |i| i = i.downcase }
        delta = expected_drivers - options
        expect(delta).to be_empty, "One or more applicant is missing from the primary driver assignment list.\nMissing applicants are: #{delta.join(', ')}"
      end
    end
  end
end

Then(/^The drop down for the occasional driver should not include the primary driver$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.driver_assignment_modal.vehicle_panels.first
    panel.occasional_use_drivers.first.driver_element.select(panel.primary_use_driver.text)
    expect(panel.occasional_use_drivers.first.driver.text != panel.primary_use_driver.text).to be_truthy, 'Occasional use drivers includes the primary driver which is enabled'
  end
end

When(/^I edit the driver assignments, by swapping the primary and occasional use drivers$/) do
  @driver_assignments = []

  on(AutoPolicySummaryPage) do |page|
    page.driver_assignment_panel.modify
    page.wait_for_modal_or_error
    modal = page.driver_assignment_modal
    modal.vehicle_panels.each do |p|
      p.occasional_use_drivers.first.remove
      p.primary_use_driver_element.select_index(1)
      @driver_assignments << { vehicle: p.grid_key, driver: p.primary_use_driver.text, use: 'Primary' }
      p.add_occasional_use_driver
      p.occasional_use_drivers.first.driver_element.select_index(0)
      @driver_assignments << { vehicle: p.grid_key, driver: p.occasional_use_drivers.first.driver.text, use: 'Occasional' }
    end
    modal.save_and_close
  end
end

When(/^I attempt to remove the occasional use driver assignments$/) do
  @driver_assignments = []

  on(AutoPolicySummaryPage) do |page|
    page.driver_assignment_panel.modify
    modal = page.driver_assignment_modal
    modal.vehicle_panels.each do |p|
      @driver_assignments << { vehicle: p.grid_key, driver: p.primary_use_driver, use: 'Primary' }
      p.occasional_use_drivers.each(&:remove)
    end
    modal.save_and_close_button
    @drivers_validation_appeared = page.driver_assignment_modal? && page.driver_assignment_modal.present? && page.driver_assignment_modal.all_drivers_assigned_validation? && page.driver_assignment_modal.all_drivers_assigned_validation_element.present?
    @vehicles_validation_appeared = page.driver_assignment_modal? && page.driver_assignment_modal.present? && page.driver_assignment_modal.all_vehicles_assigned_validation? && page.driver_assignment_modal.all_vehicles_assigned_validation_element.present?
  end
end

Then(/^The following reasons to remove a driver should appear in the list for the first driver$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.drivers.first.delete
    actual = page.remove_driver_modal.reason.options.sort
    expected = table.rows.flatten.sort
    expect(actual.map(&:downcase)).to eq(expected.map(&:downcase)), "Remove Driver Modal: Expected the Reason for Removal Drop Down to Contain These Options; #{expected}, But It Contained These Options #{actual}"
  end
end

When(/^I remove the first driver for the following reason, "([^"]*)"$/) do |reason_for_removal|
  on(AutoPolicySummaryPage) do |page|
    @deleted_driver = page.driver_info_panel.drivers.first.name
    page.driver_info_panel.drivers.first.scroll.to
    page.driver_info_panel.drivers.first.delete
    # page.remove_driver_modal.reason = reason_for_removal
    page.remove_driver_modal.remove_driver
  end
end

When(/^I remove the first driver$/) do
  on(AutoPolicySummaryPage) do |page|
    @deleted_driver = page.driver_info_panel.drivers.first.name
    page.driver_info_panel.drivers.first.scroll.to
    page.driver_info_panel.drivers.first.delete
    # page.remove_driver_modal.reason = reason_for_removal
    page.remove_driver_modal.remove_driver
  end
end

Then(/^I should see the driver assignment validation messages$/) do
  on(PolicyManagementPage) do |page|
    modal_present = page.driver_assignment_modal? && page.driver_assignment_modal.present?
    RSpec.capture_assertions do
      @drivers_validation_appeared = modal_present && page.driver_assignment_modal.all_drivers_assigned_validation? && page.driver_assignment_modal.all_drivers_assigned_validation_element.present?
      expect(@drivers_validation_appeared).to be_truthy, 'Expected to see the message validating that all drivers have been assigned but the element was not present'
      @vehicles_validation_appeared = modal_present && page.driver_assignment_modal.all_vehicles_assigned_validation? && page.driver_assignment_modal.all_vehicles_assigned_validation_element.present?
      expect(@vehicles_validation_appeared).to be_truthy, 'Expected to see the message validating that all vehicles have been assigned but the element was not present'
    end
  end
end

When(/^I add a duplicate driver$/) do
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.add_driver
    modal = page.auto_driver_modal
    modal.populate
    modal.save_and_close
  end
end

And(/^I start adding a driver on the policy summary page$/) do
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.add_driver
    if page.auto_prefill_modal?
      page.auto_prefill_modal.deselect_all
      page.auto_prefill_modal.save_and_continue
    end
  end
end

Then(/^The driver from the data for "([^"]*)" should appear in the add driver dropdown$/) do |expected_driver|
  hashes = expected_driver.split('/')
  driver = data_for(hashes.first.snakecase)
  hashes.shift
  #hashes.each { |hash_name| driver = driver[hash_name.snakecase] }
  expect(on(AutoPolicySummaryPage).auto_driver_modal.existing_parties_include?([driver['first_name'], driver['last_name']])).to be_truthy, "Expected the driver drop down on the add driver modal to contain a name containing #{[driver['first_name'], driver['last_name']]}, but it could not be found"
end

When(/^I delete all drivers$/) do
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.remove_all_drivers(page.remove_driver_modal)
  end
end

When(/^I modify the driver assignment$/) do
  on(AutoPolicySummaryPage).driver_assignment_panel.modify
end

When(/^I add a blank driver$/) do
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.add_driver
    page.auto_driver_modal.existing_party = "New Party"
    page.auto_driver_modal.save_changes
  end
end

When(/^I add (\d+) random drivers? from the auto summary page$/) do |number_of_drivers_to_add|
  on(AutoPolicySummaryPage) do |page|
    @added_drivers = []
    number_of_drivers_to_add.times do
      page.driver_info_panel.add_driver
      page.wait_for_processing_overlay_to_close
      if page.auto_prefill_modal?
        page.auto_prefill_modal.deselect_all
        page.auto_prefill_modal.save_and_continue
      end

      random_driver = { existing_party: 'New Party', first_name: DataMagic.last_name, last_name: DataMagic.last_name, gender: 'Male', date_of_birth: DataMagic.full_adult_birth_date, marital_status: 'Single', relationship_to_applicant: 'Other Relative', license_state: 'Indiana', license_number: '0123456789' }
      page.auto_driver_modal.populate_with random_driver
      page.auto_driver_modal.save_and_close
      page.wait_for_ajax
      @added_drivers << random_driver
    end
  end
end

Then(/^The deleted driver should not display in the driver grid$/) do
  on(AutoPolicySummaryPage) do |page|
    found = page.driver_info_panel.drivers.find { |d| d.name.snakecase == @deleted_driver.snakecase }
    expect(found).to be_nil, "Expected not to find #{@deleted_driver} in the driver grid, but it was found"
  end
end

And(/^I attempt to add a blank accident and a blank violation$/) do
  on(AutoPolicySummaryPage) do |page|
    page.driver_info_panel.drivers.first.edit
    if page.auto_prefill_modal?
      page.auto_prefill_modal.deselect_all
      page.auto_prefill_modal.save_and_continue
    end
    modal = page.auto_driver_modal
    modal.tab_strip = 'Accidents & Violations'
    ## add a wait in between modals
    on(PolicyManagementPage).wait_for_ajax
    modal.add_accident
    modal.add_violation
    modal.save
  end
end

Then(/^There should be (\d+) accidents and violations$/) do |number|
  on(PolicyManagementPage) do |page|
    actual_count = page.auto_driver_modal.accidents_and_violations.count
    expect(actual_count).to eq(number), "Expected there to be #{number} accidents and violations, but there were #{actual_count}"
  end
end

Then(/^All accident and violation validations should be visible$/) do
  on(PolicyManagementPage) do |page|
    RSpec.capture_assertions do
      page.auto_driver_modal.accidents_and_violations.each_with_index do |av, i|
        expect(av.date_validation_element.present?).to be_truthy, "Expected the date validation to be present on the accident and validation at index #{i}, but it could not be found"
        expect(av.type_validation_element.present?).to be_truthy, "Expected the type validation to be present on the accident and validation at index #{i}, but it could not be found"
        expect(av.description_validation_element.present?).to be_truthy, "Expected the description validation to be present on the accident and validation at index #{i}, but it could not be found"
      end
    end
  end
end

Then(/^I open the modals$/) do
  on(AutoPolicySummaryPage) do |page|
    page.general_info_panel.modify
    page.wait_for_processing_overlay_to_close
  end
end

Then(/^I provide drivers details followed by (save and close|save and continue|dismiss) button$/) do |button|
  @drivers_data = data_for("auto_driver_modal")['drivers']
  on(PolicyManagementPage) do |page|
    number_of_drivers_to_add = @drivers_data.count
    i = 0
    modal = page.auto_driver_modal
    number_of_drivers_to_add.times do
      modal.populate_with @drivers_data[i]
      modal.save_and_add_another_driver unless i == number_of_drivers_to_add - 1
      i = i + 1
    end
    modal.send(button.snakecase)
  end
end

And(/^I assign the primary driver to each vehicle$/) do
  @driver_assignments = []
  on(AutoPolicySummaryPage) do |page|
    page.driver_assignment_panel.modify unless page.driver_assignment_modal?
    Watir::Wait.until { page.driver_assignment_modal? }
    modal = page.driver_assignment_modal
    page.wait_for_ajax
    modal.vehicle_panels.each do |p|
      p.primary_use_driver_element.select_index(0)
      @driver_assignments << { vehicle: p.grid_key, driver: p.primary_use_driver, use: 'Primary' }
    end
    modal.save_and_close
  end
end

Then(/^I validate error message on drivers panel$/) do
  on(AutoPolicySummaryPage) do |page|
    expect(page.driver_info_panel.no_drivers_error_message).to eq("At least one driver must be specified for quote. No driver specified in the request.")
  end
end

And(/^I add a blank accident and a blank violation$/) do
  on(PolicyManagementPage) do |page|
    modal = page.auto_driver_modal
    modal.tab_strip = 'Accidents & Violations'
    ## add a wait in between modals
    page.wait_for_ajax
    modal.add_accident
    modal.add_violation
    modal.save
    page.scroll.to :bottom
  end
end

When(/^I click on edit the first driver$/) do
  on(AutoPolicySummaryPage) do |page|
    driver = page.driver_info_panel.drivers.first
    driver.edit
  end
end

Then(/^I validate the following options (should|should not) display on the driver modal$/) do |which, table|
  expected = table.rows.flatten
  on(PolicyManagementPage) do |page|
    modal = page.auto_driver_modal
    if which == 'should'
      expected.each do |value|
        expect(modal.send("#{value.snakecase}_element").present?).to be_truthy, "Option #{value} not found"
      end
    else
      expected.each do |value|
        expect(modal.send("#{value.snakecase}_element").present?).to be_falsey, "Option #{value} not found"
      end
    end
  end
end

And(/^I select "([^"]*)" on drivers modal$/) do |opt|
  on(PolicyManagementPage) do |page|
    modal = page.auto_driver_modal
    modal.send("#{opt.snakecase}").set(true)
  end
end