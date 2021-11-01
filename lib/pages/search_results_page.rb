# frozen_string_literal: true


class ListViewCards < BaseSection
  td(:account, data_label: 'Account')
  td(:agency_code, data_label: 'Agency Code')
end

class GridView < BaseSection
  link(:name, xpath: './/div[@class="ui-card-content"]//a')
  span(:address, xpath: './/div[@class="ui-card-content"]//br/following-sibling::span')
end

class SearchResultsSection < BaseSection
  data_grid(:list_view_cards, ListViewCards)
  sections(:grid_view_cards, GridView, xpath: '.', item: {xpath: './/div[contains(@class,"search-result-card")]'})
end

class CategorySection < BaseSection
  radio(:category_type_all, id: /CategoryTypeAll/)
  radio(:category_type_personal, id: /CategoryTypePersonal/)
  radio(:category_type_commercial, id: /CategoryTypeCommercial/)
  button(:category_accordion, class: /accordion/)

  def category_type=(text)
    send("category_type_#{text.snakecase}").select
  end

  def check_disabled?(element)
    send("category_type_#{element}_element").div(role: 'radio').classes.include? 'p-disabled'
  end
end

class LineOfBusinessSection < BaseSection
  button(:line_of_business_accordion, class: /accordion/)
  text_field(:search_text, class: /p-inputtext/)
  checkbox(:line_of_business_auto, id: /PersonalAuto/)
  checkbox(:line_of_business_home, id: /Homeowners/)
  checkbox(:line_of_business_umbrella, id: /PersonalUmbrella/)
  checkbox(:line_of_business_watercraft, id: /ScheduledProperty/)
  checkbox(:line_of_business_scheduled_property, id: /Watercraft/)
end

class RegionsSection < BaseSection
  button(:regions_accordion, class: /accordion/)
  checkbox(:region_cro, id: /regionCro/)
  checkbox(:region_nero, id: /regionNero/)
  checkbox(:region_sero, id: /regionSero/)
  checkbox(:region_swro, id: /regionSwro/)
end

class StatesSection < BaseSection
  button(:regions_accordion, class: /accordion/)
  text_field(:search_text, class: /p-inputtext/)
  checkbox(:states, name: /states/)
end

class SearchFilterSection < BaseSection
  section(:category_section, CategorySection, id: 'categorySection', how: :div)
  section(:line_of_business_section, LineOfBusinessSection, id: 'lineOfBusinessSection', how: :div)
  section(:regions_section, RegionsSection, id: 'regionSection', how: :div)
  section(:states_section, StatesSection, id: 'stateSection', how: :div)
end

class SearchResultsPage < PolicyManagementPage
  i(:list_view, class: /fa-th-list/)
  i(:grid_view, class: /fa-th-large/)
  div(:tooltip_text, class: 'ui-tooltip-text ui-shadow ui-corner-all')
  section(:search_results_section, SearchResultsSection, id: 'searchresultsBody', how: :div)
  section(:search_filter_section, SearchFilterSection, class: 'searchfilter-body', how: :div)
  span(:banner_message, class: 'custom-message')
end
