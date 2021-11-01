# frozen_string_literal: true

Then(/^The discontinued agency modal (should|should not) be present$/) do |should_or_not|
  on(AccountSummaryPage) do |page|
    binding.pry if Nenv.cuke_debug?
    presence = (page.discontinued_agency_modal? && page.discontinued_agency_modal.present?)
    to_or_not_to = "#{should_or_not.remove 'should'} to"
    expect(presence).to eq(should_or_not == 'should'), "Expected the discontinued agency modal#{to_or_not_to} be present, but it was#{' not'.remove to_or_not_to.remove ' to'}"
  end
end

And(/^I start to add a new product$/) do
  on(PolicyManagementPage) do |page|
    page.toggle_side_navbar
    page.left_nav.navigate_to('Account Overview')
  end

  on(AccountSummaryPage).product_list.add_product
end
