# frozen_string_literal: true

Then(/^I should see the following values in the customer loyalty dropdown$/) do |table|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    panel = page.overrides_panels.first
    override_row = panel.overrides.find {|i|i.text.downcase.include? 'customer loyalty'}
    override_row.edit
    actual = override_row.customer_loyalty.options
    expect(actual).to eq(table.rows.flatten)
  end
end
