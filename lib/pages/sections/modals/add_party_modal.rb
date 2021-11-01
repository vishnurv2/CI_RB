# frozen_string_literal: true

class AddPartyModal < BaseModal
  toggle_button_list(:add_new_party_type, xpath: '//p-selectbutton[@id="addNewPartyPartyTypeSelectButton"]/div')
  select(:role, id: /addNewPartyRoleDropdown/)
  button(:next, xpath: '//p-button[@id="Next"]/button')
  div(:driver_role_option, id: 'DriverRoleOption')
  div(:trustee_role_option, id: 'TrusteeRoleOption')
  i(:close_button, xpath: './/span[contains(text(),"Add Party")]//following::i')




  def select_add_party_type=(txt)
    add_new_party_type_element.span(text: txt).click
  end

  def driver_option_hover_over_message
    driver_role_option_element.div(title: 'Add driver on the Auto Summary screen')
  end

  def trustee_option_hover_over_message
    trustee_role_option_element.div(title: 'Trust is required to add a Trustee')
  end

end

