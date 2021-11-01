# frozen_string_literal: true

Then(/^I should see my expected drivers and vehicles in the auto prefill modal$/) do
  data = data_for 'auto_prefill_modal'
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_prefill_modal
    #Watir::Wait.until { modal.drivers.count.positive? }
    #### Drivers have been removed from this screen
    #actual_drivers = modal.drivers.map(&:to_h)
    #actual_drivers.each { |d| d[:full_name] = d[:full_name].split(' (').first if d[:full_name].match?(/\(\d+\)$/) }

    Watir::Wait.until { modal.vehicles.count.positive? }
    actual_vehicles = modal.vehicles.map(&:to_h)

    if Nenv.use_excel_data.include? 'true'
      data[:expected_vehicles] = data['expected_vehicles'].map{|x| x.transform_keys(&:to_sym)}
      data.delete('expected_vehicles')
    end

    #Currently driver name is applicant name and so it changes and therefore could not match it with data in fixture file
    #expect(actual_drivers).to eq(data[:expected_drivers])
    expect(actual_vehicles).to eq(data[:expected_vehicles])
  end
end

When(/^I populate the auto prefill modal$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_prefill_modal
    modal.populate
    #@selected_prefill_drivers = modal.drivers.select(&:select).map(&:to_h)
    #@selected_prefill_drivers.each { |d| d[:full_name] = d[:full_name].split(' (').first if d[:full_name].match?(/\(\d+\)$/) }
    @selected_prefill_vehicles = modal.vehicles.select(&:select).map(&:to_h)
    modal.next_modal
  end
end

Then(/^I should see a vehicle modal for each of the vehicles I prefilled$/) do
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      @selected_prefill_vehicles.each do |vehicle|
        if vehicle[:selected]
          modal = page.auto_vehicle_modal
          expected_title_without_slashes = vehicle[:full_name]
          expect(modal.div(id: 'modal-header').text.gsub(' / ', ' ')).to eq(expected_title_without_slashes)
          modal.vehicle_use = 1
          modal.performance = 1
          modal.purchase_date = Date.today.to_date.strftime('%m/%d/%Y') unless modal.purchase_date_unknown.checked? == true
          modal.annual_miles = '100'
          modal.next_modal
          page.wait_for_processing_overlay_to_close
          #page.auto_vehicle_coverages_modal.next_modal
        end
      end
    end
    expect(page.auto_driver_modal?).to be_truthy, 'We should be on the auto driver modal but we are not, did too many vehicles get prefilled?'
  end
end

And(/^I should see a driver modal for each of the drivers prefilled$/) do
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      @selected_prefill_drivers.each do |driver|
        if driver[:selected]
          modal = page.auto_driver_modal
          expected_title = "Auto / Drivers / #{driver[:full_name]}"
          expect(modal.div(id: 'modal-header').text).to eq(expected_title)
          modal.marital_status = 'Single'
          modal.relationship_to_applicant = 'Other'
          modal.gender = 'Male'
          modal.next_modal
        end
      end
    end
    expect(page.driver_assignment_modal?).to(be_truthy, 'We should be on the driver assignment modal but we are not, did too many drivers get prefilled?') if @selected_prefill_drivers.count > 1
  end
end

And(/^each driver should show up in the driver assignment modal$/) do
  on(AutoPolicySummaryPage) do |page|
    RSpec.capture_assertions do
      if @selected_prefill_drivers.count > 1
        modal = page.driver_assignment_modal
        modal.vehicle_panels.each do |panel|
          drivers = panel.primary_use_driver_element.options.map(&:text)
          @selected_prefill_drivers.each do |driver|
            expect(drivers).to include(driver.driver_dropdown_name_with_age)
          end
          panel.primary_use_driver = 1
        end
      else
        expect(page.driver_assignment_modal?).to be_falsey, "Expected the driver assignment modal to be skipped because there was only 1 driver, but it was present.  The prefilled drivers were: #{@selected_prefill_drivers}"
      end
    end
  end
end

When(/^I (check|uncheck) the first prefill driver$/) do |check_or_not|
  # Took out the checkbox(), now simply calling the default click
  on(AutoPolicySummaryPage).auto_prefill_modal.drivers.first.select_checkbox.send(check_or_not)
end

And(/^I select (.*) as the first prefill remove reason$/) do |reason|
  on(AutoPolicySummaryPage).auto_prefill_modal.drivers.first.reason = reason
end

Then(/^I (should|should not) see a text area below the first reason select list$/) do |should_or_not|
  on(AutoPolicySummaryPage) do |page|
    actual_remarks_presence = page.auto_prefill_modal.drivers.first.other_remarks_element.present?
    expect(actual_remarks_presence).to eq(should_or_not == 'should')
  end
end

Then(/^I validate vehicles message tailored to NNO followed by (save and close|save and continue|dismiss) button$/) do |button|
  on(PolicyManagementPage) do |page|
    modal = page.auto_prefill_modal
    expect(modal.vehicles_message).to eq("No Vehicles apply to a Named Non Owner policy")
    modal.send(button.snakecase)
  end
end

Then(/^I validate message tailored to NNO followed by (save and close|save and continue|dismiss) button$/) do |button|
  on(PolicyManagementPage) do |page|
    modal = page.auto_prefill_modal
    expect(modal.drivers_message).to eq("Only one driver applies when Named Individual coverage selected")
    expect(modal.vehicles_message).to eq("No Vehicles apply to a Named Non Owner policy")
    modal.send(button.snakecase)
  end
end