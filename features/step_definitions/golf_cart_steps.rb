# frozen_string_literal: true

When(/^I add a golf cart to my policy$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_other_vehicle
    modal = page.other_vehicle_modal
    modal.populate
    modal.save_and_close
  end
end

Then(/^I should see the golf cart on the auto summary screen$/) do
  on(AutoPolicySummaryPage) do |page|
    expect(page.vehicle_info_panel.other_vehicle_grid.items.count).to eq(1)
  end
end

When(/^I add a golf cart to my policy and view the coverages available$/) do
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_button
    modal = page.other_vehicle_modal
    modal.populate
    modal.next_modal
  end
end
