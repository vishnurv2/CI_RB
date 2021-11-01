# frozen_string_literal: true

class ResultsRow < ::EDSL::ElementContainer
  td(:select, index: 0)
  td(:row, index: 1)
  td(:options, index: 2)
  td(:insured_first, index: 3)
  td(:insured_last, index: 4)
  td(:effective_date, index: 5)
  td(:premium, index: 6)
  td(:quote_number, index: 0)

  link(:view_xml, xpath: './/a[contains(text(), "View XML")]', default_method: :click!)
end

class BenchmarkPanel < BasePanel
  sections(:results, ResultsRow, xpath: '//div[@id = "divResultsTable"]//tbody', how: :tbody, item: { how: :trs })
end

class BenchmarkViewerPage < BasePage
  TIME_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:send_keys).with(:tab)
  end

  page_url "https://saturn.central-insurance.com/Benchmarksmanagement"

  select_list(:quotes_to_receive, id: 'ddlQuoteType')
  select_list(:line_of_business, id: 'ddlSelectedLine')
  select_list(:state, id: 'ddlSelectedState')
  select_list(:retrieve_options, id: 'ddlSearchOptions')
  button(:retrieve, id: 'btnSubmitRetrieveBenchmarks')
  section(:results_panel, BenchmarkPanel, id: 'main')
  link(:download, id: 'lnkDownloadXml')

  def find_benchmark(policy)
    results_panel.results.find { |x| x.insured_first == policy }
  end

  def get_xml; end

end
