And(/^I select policy change option on overrides page$/) do
  on(OverridesPage) do |page|
    panel = page.overrides_panels.first
    panel.select_policy = 1
  end
end

Then(/^the "([^"]*)" override in panel (\d+) should show as overridden$/) do |type, panel_number|
  on(OverridesPage) do |page|
    panel = page.overrides_panels[panel_number.to_i - 1]
    panel.select_policy = 1 if panel.select_policy?
    page.wait_for_ajax
    override_row = panel.overrides.find {|i|i.text.downcase.include? type.downcase}
    expect(override_row.status_element.present? && override_row.status.include?('Overridden')).to be_truthy, "Expected the #{type} panel to say \"Applies\" but it could not be found"
  end
end

Then(/^I validate "([^"]*)" override in panel (\d+)$/) do |type, panel_no|
  on(OverridesPage) do |page|
    panel = page.overrides_panels[panel_no.to_i - 1]
    override_row = panel.overrides.find { |i| i.text.downcase.include? type.downcase }
    override_row.edit
    expect(override_row.user_override_protection_class_text.present?).to be_truthy
    expect(override_row.user_override_protection_class).to eq('3 / HAMBLEN TS FPSA / HAMBLEN TS FS')
    expect(override_row.override_eff_date_element.disabled?).to be_truthy
    expect(override_row.override_eff_date).to eq(Chronic.parse('now').to_date.strftime('%m/%d/%Y'))
    expect(override_row.dropdown_label).to eq("Select")
    expect(override_row.override_protection_class_dropdown.present?).to be_truthy
  end
end

Then(/^I validate that info icon on territory premise address in panel (\d+)$/) do |panel_no|
  on(OverridesPage) do |page|
    type = "Territory - Premise Address"
    panel = page.overrides_panels[panel_no.to_i - 1]
    override_row = panel.overrides.find { |i| i.text.downcase.include? type.downcase }
    expect(override_row.info_icon_element.present?).to be_falsey
  end
end