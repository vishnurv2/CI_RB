And(/^I edit scheduled classes and items$/) do
  on(AutoPolicySummaryPage) do |page|
    page.scheduled_property_classes_and_items_panel.modify
    page.wait_for_ajax
    modal = page.scheduled_property_classes_modal
    modal.agreed_value_coverage = 'Yes'
    modal.bicycles_agreed_amount = "5000000"
    modal.bicycles_agreed_deductible = '$5,000'
    modal.bicycles_item_name = 'Item'
    modal.bicycles_item_description = 'Test'
    modal.bicycles_item_amount = '5000000'
    modal.save_and_close
  end
end

Then(/^I update agreed value and verify Negative amount remaining$/) do
  on(AutoPolicySummaryPage) do |page|
    page.scheduled_property_classes_and_items_panel.modify
    page.wait_for_ajax
    modal = page.scheduled_property_classes_modal
    #modal.agreed_value_coverage = 'Yes'
    modal.bicycles_agreed_amount = "1000"
    modal.bicycles_agreed_deductible = '$250'
    modal.bicycles_item_name = 'Item'
    modal.bicycles_item_description = 'Test'
    modal.bicycles_item_amount = '2000'
    expect(modal.negative_agreed_value_element.style('color')).to eq("rgba(211, 47, 47, 1)")
    expect(modal.negative_agreed_value).to eq("-$1,000.00")
  end
end

Then(/^I verify label for VIN on summary page$/) do
    on(AutoPolicySummaryPage) do |page|
      page.right_arrow_element.click
      page.view_vehicle_element.click
      expect(page.identification_num).to eq("Identification Number")
    end
end

And(/^I verify VIN label on SPP classes modal for "([^"]*)" vehicle$/) do |vehicle|
  on(AutoPolicySummaryPage) do |page|
    page.scheduled_property_classes_and_items_panel.modify
    page.wait_for_ajax
    modal = page.scheduled_property_classes_modal
    if vehicle == 'motorized'
      modal.category_motorized_element.select('Trailer')
      expect(modal.identification_number_motorized).to eq("Identification Number")
      modal.category_motorized_element.select('Vehicle')
      expect(modal.identification_number_motorized).to eq("Identification Number")
    elsif vehicle == 'ground_maintenance'
      modal.category_element.select('Trailer')
      expect(modal.identification_number).to eq("Identification Number")
      modal.category_element.select('Vehicle')
      expect(modal.identification_number).to eq("Identification Number")
    end
    modal.save_and_close
    page.wait_for_ajax
  end
end

Then(/^I verify type popularity is removed from Sort by dropdown on SPP classes modal$/) do
  on(AutoPolicySummaryPage) do |page|
    page.scheduled_property_classes_and_items_panel.modify
    page.wait_for_ajax
    modal = page.scheduled_property_classes_modal
    select_list = modal.sort_by_filter.options true
    expect(select_list.include?('Populate')).to be_falsey
  end
end