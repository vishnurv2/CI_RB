# frozen_string_literal: true

Then(/^The lease loan guard coverage "([^"]*)" be automatically selected$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    expect(modal.coverages_list.coverage_selected?('Lease / Loan Guard')).to eq(which == 'should')
  end
end

And(/^Lease loan guard "([^"]*)" can be added to the policy$/) do |option|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    modal.coverages_list.select_coverage('Lease / Loan Guard')
    button = modal.coverages_list.find_coverage('Lease / Loan Guard').div(xpath: ".//p-selectbutton/div/div[span[contains(text(), \"#{option}\")]]")
    Watir::Wait.until { button.present? }
    button.click if button.attributes[:aria_pressed] == 'false'
    modal.save_and_close
    page.wait_for_ajax
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    page.other_vehicle_modal.wait_for_loading_to_disappear
    page.other_vehicle_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    expect(modal.coverages_list.coverage_selected?('Lease / Loan Guard')).to be_truthy
    button = modal.coverages_list.find_coverage('Lease / Loan Guard').div(xpath: ".//p-selectbutton/div/div[span[contains(text(), \"#{option}\")]]")
    expect(button.attributes[:aria_pressed]).to eq('true')
  end
end

And(/^Loan guard can be added to the policy with limit "([^"]*)"$/) do |loan_limit|
  on(AutoPolicySummaryPage) do |page|
    modal = page.auto_vehicle_coverages_modal
    panel = modal.panel_obj_for_coverage('Lease / Loan Guard')
    expect(modal.coverages_list.coverage_selected?('Lease / Loan Guard')).to be_truthy
    panel.scroll.to
    panel.total_limit_loan_guard.click
    panel.total_limit_loan_guard = loan_limit
    panel1 = modal.panel_obj_for_coverage('Towing & Labor')

    ## 2/3/2021  This is automatically included in Summit
    if panel1.present? && modal.coverages_list.coverage_selected?('Towing & Labor')
      if panel1.total_limit_per_disablement?
        panel1.total_limit_per_disablement_element.click
        panel1.total_limit_per_disablement = 1
      end
    end

    modal.save_and_close
    page.wait_for_ajax
    page.vehicle_info_panel.scroll.to
    vehicle = page.vehicle_info_panel.vehicles.last
    vehicle.edit
    page.other_vehicle_modal.wait_for_loading_to_disappear
    page.other_vehicle_modal.tabs.active_tab = 'Coverage'
    page.wait_for_modal_or_error
    RSpec.capture_assertions do
      expect(modal.coverages_list.coverage_selected?('Lease / Loan Guard')).to be_truthy
      expect(panel.total_limit_loan_guard.text).to eq(loan_limit)
    end
  end
end
