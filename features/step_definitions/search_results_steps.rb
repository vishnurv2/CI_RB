# frozen_string_literal: true

And(/^I validate search results page and its details$/) do
  # verifying the tool tip exist for both grid view and list view
  on(SearchResultsPage) do |page|
    page.grid_view_element.span.hover
    expect(page.div(class: /p-tooltip-text/).text).to eq("Grid View")
    page.grid_view
    expect(page.search_results_section.grid_view_cards.count > 0).to be_truthy
    page.list_view_element.span.hover
    expect(page.div(class: /p-tooltip-text/).text).to eq("List View")
    page.list_view
    expect(page.search_results_section.list_view_cards.count > 0).to be_truthy
  end
end

And(/^I validate filters on search results page$/) do
  on(SearchResultsPage) do |page|
    section = page.search_filter_section
    expect(section.category_section.check_disabled?('all')).to be_falsey
    expect(section.category_section.check_disabled?('commercial')).to be_truthy
    expect(section.category_section.check_disabled?('personal')).to be_falsey
    section.line_of_business_section.search_text = 'Umbrella'
    expect(section.line_of_business_section.lis.count == 1).to be_truthy
    section.regions_section.region_cro = true
    section.states_section.search_text = 'Alaska'
    expect(section.states_section.states_element.label(text: 'Alaska').parent.present?).to be_truthy
  end
end

And(/^I validate the results$/) do
  on(SearchResultsPage) do |page|
    page.list_view
    expect(page.search_results_section.list_view_cards.count > 0).to be_truthy
  end
end

And(/^I validate banner message for search results$/) do
  on(SearchResultsPage) do |page|
    expect(page.banner_message).to eq("Search results shown are only accounts that have migrated to the new Policy Administration System. Please use Enterprise Search from Agents Access to search all accounts.")
  end
end