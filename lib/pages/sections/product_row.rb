# frozen_string_literal: true

class ProductRow < ::BaseSection

  td(:product, data_label: 'Name')
  td(:status, data_label: 'Status')
  td(:effective_date, data_label: 'Effective Date')
  td(:expiration_date, data_label: 'Expiration Date')
  td(:actions, data_label: 'Options')
  #button(:policy_info_btn, id: 'quotedPoliciesInfoBtn')
  button(:policy_info_btn, class: /action-icon/)
  link(:delete_product, text: 'Delete Policy')
  link(:do_not_issue, text: 'Do Not Issue')
  link(:issue, text: 'Issue')
  div(:remove_confirm_message, xpath: "//td[@class = 'deleteConfirmationRow']/div[contains(text(),'delete')]")
  button(:delete_yes, xpath: "//div[contains(@class,'deleteConfirmationRow')]//p-button[@label = 'Delete']/button")
  button(:delete_no, xpath: "//div[contains(@class,'deleteConfirmationRow')]//p-button[@label = 'Cancel']/button")
  link(:create_policy_change, xpath: '//span[text()="Create Policy Change"]/..')
  link(:cancel_renew, xpath: '//span[text()="Cancel/Non-Renew" or text() = "Edit Cancel" or text()="Cancel"]/..')
  span(:right_arrow, class: 'pi-chevron-right')
  div(:product_cell, class: /textUnderline/)
  link(:reinstate, xpath: '//span[text()="Reinstate"]/..')

  span(:three_dots, class: ['pi-ellipsis-h'], default_method: :click!)
  span(:info_circle, class: /fa-info-circle/)
  link(:renew, xpath: '//span[text()="Cancel/Non-Renew"]/..')
  link(:edit_policy_change, xpath: '//span[text()="Edit Policy Change"]/..')

  def expand
    s = span(class: 'pi-chevron-right')
    s.click if s.present?
  end

  # ------ Everything below this line is unverified ------------------------------------- #

  span(:id_card, title: 'View Id Card')
  span(:view_pdf, title: 'View PDF')

  def product_link
    product_cell_element.link
  end

  def product_name
    product_link.text.strip
  end

  def open_product
    product_link.click
  end
end
