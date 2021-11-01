# frozen_string_literal: true

Then(/^I should see a "([^"]*)" in override panel (\d+)$/) do |type, panel_no|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    # page.left_navigate_to_if_not_on('Overrides')
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
  end
  on(OverridesPage) do |page|
    #page.overrides_tab
    page.wait_for_processing_overlay_to_close
    panel = page.overrides_panels[panel_no.to_i - 1]
    page.wait_for_ajax
    expect(panel.text.include? type).to be_truthy, "Could not find a #{type} override in panel #{panel_no}"
  end
end

Then(/^the "([^"]*)" override in panel (\d+) should show as applied$/) do |type, panel_number|
  on(PolicyManagementPage) do |page|
    page.left_nav.navigate_to('Account Overview')
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text == "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
  end
  on(OverridesPage) do |page|
    #page.overrides_tab
    panel = page.overrides_panels[panel_number.to_i - 1]
    override_row = panel.overrides.find {|i|i.text.downcase.include? type.downcase}
    # panel.expand
    expect(override_row.status_element.present? && override_row.status.include?('Overridden')).to be_truthy, "Expected the #{type} panel to say \"Applies\" but it could not be found"
  end
end

Then(/^I should see a "([^"]*)" in override panel for tier (\d+)$/) do |type, panel_no|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    #page.overrides_tab
    page.wait_for_processing_overlay_to_close
    panels = page.overrides_panels.first.vehicle_panels
    panel = panels.find{|panel|panel.text.include?type}
    page.wait_for_ajax
    expect(panel.text.include? type).to be_truthy, "Could not find a #{type} override in panel #{panel_no}"
  end
end

Then(/^I should see a "([^"]*)" in override panel (\d+) for home$/) do |type, panel_no|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  on(OverridesPage) do |page|
    #page.overrides_tab
    page.wait_for_processing_overlay_to_close
    panel = page.overrides_panels[panel_no.to_i - 1]
    page.wait_for_ajax
    expect(panel.text.include? type).to be_truthy, "Could not find a #{type} override in panel #{panel_no}"
  end
end

Then(/^I should not see a "([^"]*)" in override panel (\d+)$/) do |type, panel_no|
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Overrides").scroll.to
    # page.left_navigate_to_if_not_on('Overrides')
    unless page.page_header_text.include? "Overrides"
      page.left_nav.navigate_to('Overrides')
    end
  end
  on(OverridesPage) do |page|
    #page.overrides_tab
    page.wait_for_processing_overlay_to_close
    panel = page.overrides_panels[panel_no.to_i - 1]
    page.wait_for_ajax
    expect(panel.text.include? type).to be_falsey, "Found a #{type} override in panel #{panel_no}"
  end
end

Then(/^I validate info icon on overridden status in panel (\d+)$/) do |panel_number|
  on(OverridesPage) do |page|
    panel = page.overrides_panels[panel_number.to_i - 1]
    override_row = panel.overrides.find {|i|i.text.downcase.include? "package discount"}
    override_row.overridden_info_icon_element.hover
    expect(page.span(class: /override-info-timestamp/).text.include? 'Override Applied').to be_truthy
  end
end