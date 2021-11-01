# frozen_string_literal: true

class SearchResults < BaseSection
  span(:search_report_name, class: /search-results-related-item/)
  span(:primary_text, xpath: './/span[contains(@class,"ng-star-inserted")]')
  div(:address_icon, class: /fa-address-card/)
  div(:car_icon, class: /fa-car/)
  div(:umbrella_icon, class: /fa-umbrella/)
  div(:home_icon, class: /fa-home-alt/)
  div(:watercraft_icon, class: /fa-ship/)
end

class BasicSearchSection < BaseSection
  select(:account_type, id: 'accountType')
  text_field(:search_text, class: /p-inputtext/)
  i(:search_icon, class: /search-icon/)
  sections(:search_results, SearchResults, xpath: '.', item: {xpath: './/div[@class="p-grid align-items-center cursor-pointer"]'})
  b(:no_results_found_message, xpath: '//div[contains(@class,"p-autocomplete-emptymessage")]//b')
  img(:no_results_found_img, xpath: '//div[contains(@class,"p-autocomplete-emptymessage")]//img')
  span(:view_all_results, text: /View all results/)
  link(:advanced_search, xpath: '//div[contains(@class, "advanced-search") or contains(@class, "advance-search")]/a')
end