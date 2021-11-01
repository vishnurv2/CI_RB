# frozen_string_literal: true

class DocumentRow < BaseSection

  td(:name, data_label: /Name/)
  checkbox(:order, name: /chkItem/)

  td(:date_created, data_label: /Date Created/)
  td(:status, data_label: /Status/)
  td(:tag, data_label: /Tag/)
  button(:action_icon, class: /action-icon/)
  link(:view_document, xpath: '//span[text() = "View"]/..', default_method: :click!)
end

class PolicyDocRow < BaseSection
  i(:chevron_right, class: /pi-chevron-right/)
  i(:chevron_down, class: /pi-chevron-down/)
end

class DocumentsSection < BaseSection

  data_grid(:documents_grid, DocumentRow)
  sections(:policy_doc_row, PolicyDocRow, xpath: '.', item: { xpath: './/tbody[@class="p-datatable-tbody"]/tr', how: :elements })

  def find_document_by_type(type)
    documents_grid.find { |x| x.name.include? type if x.name? }
  end

  def expand_each_policy_documents
    policy_doc_row.each do |row|
      row.chevron_right_element.click if row.chevron_right?
    end
  end

end
