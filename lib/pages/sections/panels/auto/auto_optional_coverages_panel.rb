# frozen_string_literal: true

class AutoOptionalCoveragesPanel < BasePanel
  # sections(:coverage_entries, EDSL::PageObject::Section, item: { class: 'col-md-3' })
  #
  # # sections(:coverage_names, EDSL::PageObject::Section, item: { class: 'col-md-3' }) # this line  should be used if the coverage selections class changes back to col-md-2
  # # sections(:coverage_selections, EDSL::PageObject::Section, item: { class: 'col-md-2' }) # this line  should be used if the coverage selections class changes back to col-md-2
  #
  # def coverage_names_applies
  #   coverage_entries.map(&:text).each_slice(2).map { |a| [a[0].snakecase, a[1] == 'Applies'] }.sort
  # end

  div(:corporate_auto_coverage, xpath: './/div[label/strong[contains(text(), "orporate")]]/following-sibling::div')
  div(:extended_non_owned_coverage, xpath: './/div[label/strong[contains(text(), "xtended")]]/following-sibling::div')
  div(:manual_coverage, xpath: './/div[label/strong[contains(text(), "anual")]]/following-sibling::div')
  div(:mexico_coverage, xpath: './/div[label/strong[contains(text(), "exico")]]/following-sibling::div')
  button(:modify)

  def coverages
    rows = elements(xpath: './/div[contains(text(),"No Coverage") or contains(text(),"Applies") or contains(text(),"Declined")]')
    coverages = []
    ls = labels
    rows.each_with_index do |row, i|
      coverages << [ ls[i].text, !row.text.downcase.include?('declined') && !row.text.downcase.include?('no coverage') ]
    end
    return coverages
  end

end
