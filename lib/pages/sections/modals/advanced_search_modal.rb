# frozen_string_literal: true

class SearchCriteriaRows < BaseSection
  select(:search_criteria, id: /searchCriteria/)
  select(:condition, id: /searchCondition/)
  text_field(:value_text, id: /searchValue/)
  select(:value_dropdown, id: /searchValue/)
  text_field(:condition_text, id: /searchCondition/)
end

class AdvancedSearchModal < BaseModal
  sections(:search_criteria_rows, SearchCriteriaRows, xpath: '.', item: {xpath: './/form[@id="issuePolicy"]//div[@class="p-grid ng-star-inserted"]', how: :divs})
  radio(:all_of_the_following, id: 'searchConstraintY')
  radio(:any_of_the_following, id: 'searchConstraintN')
  button(:add_more_criteria, xpath: '//p-button[@id="addmoreCriteria"]/button')
  button(:search_button, xpath: '//p-button[@id = "searchAccount"]/button')
end
