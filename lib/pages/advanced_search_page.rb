# frozen_string_literal: true

class SearchPanel < BaseSection
  text_field(:first_name, id: 'FirstName')
  text_field(:last_name, id: 'LastName')
  text_field(:middle_name, id: 'MiddleName')
  text_field(:account, id: 'QuoteNumber')
  text_field(:email, id: 'Email')
  button(:search, class: ["btn", "btn-primary"], hooks: WFA_HOOKS)
end

class ResultsPanel < BaseSection
  def find_first_link
    links.find.first.href
  end

  def find_links; end

  def has_results?
    links.any?
  end
end

class AdvancedSearchPage < PolicyManagementPage
  section(:search_panel, SearchPanel, class: 'LeftCoverageNav')
  section(:results_panel, ResultsPanel, class: 'RightCoverageNav')

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end
