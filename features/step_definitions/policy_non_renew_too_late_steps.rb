Then(/^The following reasons should appear in the list for non renew$/) do |table|
  on(AccountSummaryPage) do |page|
    expect(page.cancel_non_renew_modal.non_renew_reason_dropdown_element.options.sort & table.rows.flatten.sort).to eq(table.rows.flatten.sort)
  end
end

And(/^The Date notice should be (\d+) days before the Non\-renewal effective date$/) do |days|
  on(AccountSummaryPage) do |page|
    modal = page.cancel_non_renew_modal
    actual_days = modal.calculate_notice_non_renewal_effective_day_difference
    expect(actual_days.to_i).to eq(days.to_i), "Expected Non renewal Effective Date to be \"#{days}\" days in the future, but calculated, \"#{actual_days}\"!"
  end
end

And(/^I provide a reason in the "([^"]*)" file$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  non_renew_data = data_for('cancel_non_renew_modal')
  on(AccountSummaryPage) do |page|
    page.product_list.policies_tab
    page.product_list.products.first.three_dots
    page.product_list.products.first.cancel_renew

    modal = page.cancel_non_renew_modal
    modal.populate_cancel_modal(non_renew_data)
  end
end
