# frozen_string_literal: true

When(/^I modify the auto general info$/) do
  on(PolicyManagementPage) do |page|
    menu_item = page.left_nav.find_option_containing(' - ')
    menu_item.click unless menu_item.active?
  end
  on(AutoPolicySummaryPage) do |page|
    page.general_info_panel.modify
    affiliate_discount = page.auto_general_info_modal.affiliate_discount
    si = affiliate_discount.selected_index
    number_of_elements = affiliate_discount.option_elements.length

    expect(number_of_elements > 0).to be_truthy, "Expected the affiliate discount drop down on the general info modal to have options, but it was empty"
    si = si.nil? ? 0 : si
    si = (si + 1) % number_of_elements
    affiliate_discount.select(si)
    @option_text = affiliate_discount.text
    page.auto_general_info_modal.save_and_close_button
    # there might be a premium change here
    page.wait_for_processing_overlay_to_close
    page.premium_change_modal.close if page.premium_change_modal?
    Watir::Wait.while(message: 'Expected not to see the auto general info modal, but it was found') { page.auto_general_info_modal.present? }
  end
end

Then(/^I should see the new auto general info$/) do
  on(AutoPolicySummaryPage) do |page|
    page.premium_change_modal.close if page.premium_change_modal?

    actual = page.general_info_panel.affiliate_discount
    expect(actual.snakecase).to eq(@option_text.snakecase), "Auto General Info: Expected an affiliate discount of \"#{@option_text}\", but \"#{actual}\" was found"
  end
end

And(/^I click on modify umbrella coverage information$/) do
  on(AutoPolicySummaryPage) do |page|
    page.umbrella_policy_coverages_panel.modify
  end
end

And(/^I click on modify (watercraft optional coverages|watercraft coverages) information$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    page.send("#{which.snakecase}_panel").modify
  end
end

Then(/^I validate products displayed in exposures insured with another carrier panel$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    products = []
    page.exposures_insured_with_another_carrier_panel.products.each do |product|
      if product.category?
        products << product.category.split("\n").first
      end
    end
    expect(products).to eq(table.rows.flatten)
  end
end

When(/^I click on edit on (\d+) product in exposures insured with another carrier panel$/) do |num|
  on(AutoPolicySummaryPage) do |page|
    prods = page.exposures_insured_with_another_carrier_panel.products.find_all { |x| x.edit? }
    prods[num - 1].edit
    page.wait_for_modal_or_error
  end
end

And(/^I validate all the values displayed in the exposures insured with another carrier panel for product (\d+)$/) do |num|
  on(AutoPolicySummaryPage) do |page|
    product = page.exposures_insured_with_another_carrier_panel.products[num - 1]
    expect(product.policy).to eq(@data['policy_number'])
    expect(product.limits == (@data['limits'] + ".00") || product.limits == @data['limits'])
    expect(product.carrier).to eq(@data['carrier'])
    expect((product.effective_date == Chronic.parse(@data['effective_date']).to_date.strftime('%m/%d/%Y')) || (product.effective_date == (Chronic.parse(@data['effective_date']).to_date - 2).strftime('%m/%d/%Y'))).to be_truthy
    expect((product.expiration_date == (Chronic.parse(@data['effective_date']).to_date + 365).strftime('%m/%d/%Y')) || (product.expiration_date == (Chronic.parse(@data['effective_date']).to_date + 363).strftime('%m/%d/%Y'))).to be_truthy
    # expect(product.effective_date).to eq((Chronic.parse(@data['effective_date']).to_date - 2).strftime('%m/%d/%Y'))
    # expect(product.expiration_date).to eq((Chronic.parse(@data['effective_date']).to_date + 363).strftime('%m/%d/%Y'))
  end
end

And(/^I validate all the values displayed in the exposures insured with another carrier panel for all the products$/) do
  on(AutoPolicySummaryPage) do |page|
    product = page.exposures_insured_with_another_carrier_panel.products
    counter = product.count
    item = 0
    counter.times do
      expect(product[item].policy).to eq(@data[item]['policy_number'])
      expect(product[item].limits.remove('$').remove(',').remove('.00')).to eq(@data[item]['limit'].remove('$').remove(',').remove('.00'))
      expect(product[item].carrier).to eq(@data[item]['carrier'])
      expect((product[item].effective_date == Chronic.parse(@data[item]['effective_date']).to_date.strftime('%m/%d/%Y')) || (product[item].effective_date == (Chronic.parse(@data[item]['effective_date']).to_date - 1).strftime('%m/%d/%Y')) || (product[item].effective_date == (Chronic.parse(@data[item]['effective_date']).to_date - 2).strftime('%m/%d/%Y'))).to be_truthy
      expect((product[item].expiration_date == (Chronic.parse(@data[item]['effective_date']).to_date + 365).strftime('%m/%d/%Y')) || (product[item].expiration_date == (Chronic.parse(@data[item]['effective_date']).to_date + 364).strftime('%m/%d/%Y')) || (product[item].expiration_date == (Chronic.parse(@data[item]['effective_date']).to_date + 363).strftime('%m/%d/%Y'))).to be_truthy
      #expect(product[item].effective_date).to eq((Chronic.parse(@data[item]['effective_date']).to_date - 1).strftime('%m/%d/%Y'))
      #expect(product[item].expiration_date).to eq((Chronic.parse(@data[item]['effective_date']).to_date + 364).strftime('%m/%d/%Y'))
      item = item + 1
    end
  end
end

And(/^I click on modify auto policy coverages panel$/) do
  on(AutoPolicySummaryPage).policy_coverages_panel.modify
end

Then(/^I check the premium displayed$/) do
  on(AutoPolicySummaryPage) do |page|
    @premium = page.quote_premium.remove('$').remove(',').to_i
  end
end


When(/^I verify premium snapshot labels for ([^"]*)$/) do |opt|
  on(AutoPolicySummaryPage) do |page|
    if opt == 'Quote'
      expect(page.premium_snapshot_total_premium.present?).to be_truthy
      expect(page.premium_snapshot_view_quote.present?).to be_truthy
      expect(page.premium_snapshot_paid_in_full.present?).to be_truthy
      expect(page.premium_snapshot_begin_application.present?).to be_truthy
      expect(page.quote_number.present?).to be_truthy
    elsif opt == 'Application'
      expect(page.premium_snapshot_total_premium.present?).to be_truthy
      expect(page.premium_snapshot_view_quote.present?).to be_truthy
      expect(page.premium_snapshot_paid_in_full.present?).to be_truthy
      expect(page.premium_snapshot_issue_policy.present?).to be_truthy
      expect(page.quote_number.present?).to be_truthy
    elsif opt == 'Inforce'
      #expect(page.premium_snapshot_total_premium.present?).to be_truthy
      expect(page.premium_snapshot_payment_history.present?).to be_truthy
      expect(page.premium_snapshot_current_payment_due.present?).to be_truthy
      expect(page.premium_snapshot_current_payment_due_date.present?).to be_truthy
      expect(page.premium_snapshot_make_payment.present?).to be_truthy
    elsif opt == 'policy_change'
      expect(page.premium_snapshot_endorsement.present?).to be_truthy
      expect(page.premium_snapshot_current_annual_premium.present?).to be_truthy
      expect(page.premium_snapshot_difference.present?).to be_truthy
      expect(page.premium_snapshot_issue_policy_change.present?).to be_truthy
      expect(page.premium_snapshot_view_changes_summary.present?).to be_truthy
    end
  end
end

Then(/^I check the premium displayed and verify that it got changed$/) do
  on(AutoPolicySummaryPage) do |page|
    new_premium = page.quote_premium.remove('$').remove(',').to_i
    diff = @premium - new_premium
    expect(diff != 0).to be_truthy, "Expected the premium to change, but the difference was #{diff}"
  end
end

Then(/^I check the premium displayed and verify that it is same$/) do
  on(AutoPolicySummaryPage) do |page|
    new_premium = page.quote_premium.remove('$').remove(',').to_i
    expect(new_premium).to eq(@premium)
  end
end

And(/^I click on "([^"]*)" from Actions dropdown$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    page.actions_menu
    page.send("#{which.snakecase}")
  end
end

Then(/^I validate the delete button should be disabled for Prefill Driver not added$/) do
  on(AutoPolicySummaryPage) do |page|
    delete_button = page.applicants_panel.applicants.last.delete_button_element
    expect(delete_button.click!).to be_falsey
  end
end

And(/^I validate the hover over message on delete button "([^"]*)"$/) do |message|
  on(AutoPolicySummaryPage) do |page|
    page.applicants_panel.applicants.last.delete_button_element.hover
    expect(page.div(class: 'p-tooltip-text').text).to eq(message)
  end
end

And(/^I validate all the values displayed in the exposures insured with another carrier panel for product (\d+) on umbrella summary screen$/) do |num|
  on(AutoPolicySummaryPage) do |page|
    product = page.exposures_insured_with_another_carrier_panel.products[num - 1]
    expect(product.policy).to eq(@data['policy_number'])
    expect(product.limits.remove('$').remove(',').remove('.00')).to eq(@data['limit'].remove('$').remove(','))
    expect(product.carrier).to eq(@data['carrier'])
    expect((product.effective_date == Chronic.parse(@data['effective_date']).to_date.strftime('%m/%d/%Y')) || (product.effective_date == (Chronic.parse(@data['effective_date']).to_date - 2).strftime('%m/%d/%Y'))).to be_truthy
    expect((product.expiration_date == (Chronic.parse(@data['effective_date']).to_date + 365).strftime('%m/%d/%Y')) || (product.expiration_date == (Chronic.parse(@data['effective_date']).to_date + 363).strftime('%m/%d/%Y'))).to be_truthy
    # expect(product.effective_date).to eq((Chronic.parse(@data['effective_date']).to_date - 2).strftime('%m/%d/%Y'))
    # expect(product.expiration_date).to eq((Chronic.parse(@data['effective_date']).to_date + 363).strftime('%m/%d/%Y'))
  end
end

Then(/^I validate Review and Submit Policy Change Modal$/) do
  on(AutoPolicySummaryPage) do |page|
    page.review_and_submit_policy_change.present?
    modal = page.review_and_submit_policy_change
    expect(modal.product_header_element.text).to eq("Product")
    expect(modal.current_annual_header_element.text).to eq("Current Annual Premium")
    expect(modal.new_annual_header_element.text).to eq("New Annual Premium")
    expect(modal.difference_header_element.text).to eq("Difference")
    expect(modal.effective_date_header_element.text).to eq("Effective Date")
    # modal.policy_change_product.present?
    expect(modal.policy_change_product[1].product_name).not_to be_nil
    expect(modal.policy_change_product[1].current_annual_premium).not_to be_nil
    expect(modal.policy_change_product[1].new_annual_premium).not_to be_nil
    expect(modal.policy_change_product[1].difference).not_to be_nil
    expect(modal.policy_change_product[1].effective_date).not_to be_nil
    expect(modal.policy_change_product[1].pdf_element.present?).to be_truthy
    #summary for the policy change
    expect(modal.policy_change_product[2].text).not_to be_nil
    #hover_over
    modal.info_icon_element.hover
    expect(page.hover_changed_timestamp_element.text).not_to be_nil
    expect(page.hover_changedBy_element.text).not_to be_nil
  end
end

And(/^I review and submit policy change modal$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.review_and_submit_policy_change
    modal.submit
    page.wait_for_ajax
  end
  on(PolicyManagementPage) do |page|
    modal = page.policy_change_issued_modal
    modal.go_to_account_summary
  end
end

And(/^I click on modify "([^"]*)" information$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    page.send("#{which.snakecase}_panel").modify
  end
end

And(/^I click submit on review and submit policy change modal$/) do
  on(AutoPolicySummaryPage) do |page|
    modal = page.review_and_submit_policy_change
    modal.submit
    page.wait_for_ajax
  end
end

Then(/^I validate Policy Changes Issued Successfully modal$/) do
  on(PolicyManagementPage) do |page|
    page.policy_change_issued_modal.present?
    modal = page.policy_change_issued_modal
    expect(modal.policy_issued_title_element.text).to eq("Policy Changes Issued Successfully")
    expect(modal.policy_issued_sub_header_element.text).to eq("You have successfully issued the following changes. Thank you for choosing Central!")
    expect(modal.product_header_element.text).to eq("Product")
    expect(modal.new_annual_header_element.text).to eq("New Annual Premium")
    expect(modal.effective_date_header_element.text).to eq("Effective Date")
    expect(modal.product_name_element).not_to be_nil
    #expect(modal.new_annual_premium).not_to be_nil
    #expect(modal.effective_date).not_to be_nil
    #expect(modal.make_a_payment.present?).to be_truthy
    expect(modal.go_to_account_summary_element.present?).to be_truthy
    expect(modal.view_policy_documents_element.present?).to be_truthy
    expect(modal.close_button_element.present?).to be_truthy
  end
end

Then(/^I click on Actions button from top right corner of policy summary page$/) do
  on(AutoPolicySummaryPage) do |page|
    page.actions_menu
  end
end

And(/^I validate the options under Actions dropdown$/) do |table|
  on(AutoPolicySummaryPage) do |page|
    page.action_menu_list?
    RSpec.capture_assertions do
      table.rows.flatten.sort.each { |c| expect(page.send("#{c.snakecase}_element").present?).to be_truthy, "Expected to see #{c} in the actions dropdown list, but it could not be found" }
    end
  end
end

When(/^I modify the property information modal$/) do
  on(AutoPolicySummaryPage) do |page|
    #page.property_panel_element.scroll.to
    page.scroll.to :center
    page.property_panel.edit_element.click
  end
end

And(/^I modify the roof type to "([^"]*)" in property modal and save and close$/) do |value|
  on(PolicyManagementPage) do |page|
    modal = page.property_info_modal
    modal.roof_type_element.set(value)
    modal.save_and_close_button
  end
end

Then(/^I click on Prefill Property Info button$/) do
  on(PolicyManagementPage) do |page|
    page.property_info_modal.prefill_property_element.click
    #page.wait_for_processing_overlay_to_close
  end
end

Then(/^I fill the number of units as "([^"]*)"$/) do |number_of_units|
  on(PolicyManagementPage) do |page|
    modal = page.exposures_insured_with_another_carrier_modal
    modal.number_of_units = number_of_units
    modal.save_and_close
  end
end

Then(/^I validate comment regarding fees$/) do
  on(AutoPolicySummaryPage) do |page|
    expect(page.message_regarding_fees).to eq('* Does not include fees, if applicable. Go to the billing system for additional information.')
  end
end

And(/^I provide affiliate discount on general information modal$/) do
  on(AutoPolicySummaryPage) do |page|
    page.general_info_panel.modify
  end
  on(PolicyManagementPage) do |page|
    modal = page.auto_general_info_modal
    modal.affiliate_discount = 1
    modal.save_and_close
    page.wait_for_ajax
  end
end

And(/^I click on add watercraft driver$/) do
  on(AutoPolicySummaryPage).watercraft_operators_panel.add_watercraft_operator
end

Then(/^I validate edit icon (should|should not) be disabled on general information modal$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    if which == 'should'
      expect(page.general_info_panel.modify_element.disabled?).to be_truthy
      page.general_info_panel.modify_element.hover
      expect(page.div(class: 'p-tooltip-text').text).to eq("This information cannot be modified from here. Please visit the Home product to make changes.")
    elsif which == 'should not'
      expect(page.general_info_panel.modify_element.disabled?).to be_falsey
    end
  end
end

Then(/^I should see the Open Policy Changes page after navigation$/) do
  on(AutoPolicySummaryPage) do |page|
    expect(page.open_policy_changes_heading?).to be_truthy
  end
end