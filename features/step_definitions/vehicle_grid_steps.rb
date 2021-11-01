# frozen_string_literal: true

And(/^I delete the vehicles in the grid$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.scroll.to

    #make sure to keep one vehicle at least.
    loop do
      @found_vehicle = page.vehicle_info_panel.vehicles.last
      break if page.vehicle_info_panel.vehicles.count == 1

      @found_vehicle.delete
    end
  end
end

And(/^I add (\d+) random vehicles from the auto summary page$/) do |number_of_vehicles_to_add|
  on(AutoPolicySummaryPage) do |page|
    @added_vehicles = []
    number_of_vehicles_to_add.times do |i|
      page.vehicle_info_panel.add_button_element.scroll.to :bottom
      page.vehicle_info_panel.add_button
      page.wait_for_processing_overlay_to_close

      #rand(20) + 2000
      i2 = i+7
      random_vehicle = { vehicle_year: 2000 + (i2 % 13), vehicle_make: i2 % 31, vehicle_model: i2 % 11, vehicle_style: 0, vehicle_use: 0,
                         address: { address_line_1: "3715 KIRKLYNN DR", city: "NEW HAVEN", state: 'Indiana', zip: "46774" } }
      page.auto_vehicle_modal.populate_with random_vehicle
      page.auto_vehicle_modal.save_and_close
      @added_vehicles << random_vehicle
    end
  end
end

# ------ Everything below this line is unverified ------------------------------------- #
#

When(/^I try to delete the last (vehicle|other vehicle)$/) do |vehicle_or_other|
  on(AutoPolicySummaryPage) do |page|
    @found_vehicle = page.vehicle_info_panel.send("#{vehicle_or_other.snakecase}s").last
    @found_vehicle.delete_button
  end
end

Then(/^I should see a prompt asking me if I'm sure I want to remove the (vehicle|other vehicle)$/) do |_vehicle_or_other|
  expect(@found_vehicle.remove_confirm_message?).to be_truthy
end

When(/^I answer (.*) to the remove (vehicles|other vehicles) prompt$/) do |which, vehicle_or_other|
  on(AutoPolicySummaryPage) do |page|
    @orig_vehicle_count = page.vehicle_info_panel.send("#{vehicle_or_other.snakecase}").count
    @found_vehicle.delete_button if @found_vehicle.delete_button?
    @found_vehicle.send("delete_#{which}")
  end
end

Then(/^the (vehicles|other vehicles) should (remain in the list|be removed)$/) do |vehicle_or_other, which|
  on(AutoPolicySummaryPage) do |page|
    expected = which == 'be removed' ? @orig_vehicle_count - 1 : @orig_vehicle_count
    expect(page.vehicle_info_panel.send("#{vehicle_or_other.snakecase}").count).to eq(expected) if page.vehicle_info_panel.send("#{vehicle_or_other.snakecase}?")
  end
end

And(/^I delete all vehicles but one$/) do
  on(AutoPolicySummaryPage).vehicle_info_panel.remove_all_vehicles_but_one
end
