# frozen_string_literal: true

class AccountProductsPanel < BasePanel

  data_grid(:products, ProductRow)
  #button(:add_product, xpath: './/button[.//i[contains(@class, "fa-plus")]]')
  #button(:add_product)
  button(:add_product, xpath: './/p-button[@icon="pi pi-plus"]/button')
  # ------ Everything below this line is unverified ------------------------------------- #

  link(:add_policy_change, text: 'Add Policy Change', hooks: WFA_HOOKS)
  #section(:add_policy_change_modal, AddPolicyChangeModal, xpath: '//div[@id="divModalContent" and .//div/h4[contains(text(), " - Policy Change")]]')
  link(:policies_tab, text: /Policies/, hooks: WFA_HOOKS)
  link(:policy_changes_tab, data_toggle: 'tab', text: /Policy Changes/, hooks: WFA_HOOKS)
  link(:quotes_tab, text: /Quotes/, hooks: WFA_HOOKS)
  td(:empty_table, class: 'dataTables_empty')

  def select_tab(tab_text)
    send("#{tab_text.snakecase}_tab_element").scroll.to
    send("#{tab_text.snakecase}_tab_element").click!
  end
end
