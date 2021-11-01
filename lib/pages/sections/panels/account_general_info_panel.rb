# frozen_string_literal: true

class AccountGeneralInfoPanel < BasePanel
  span(:modify, class: /fa-pencil/, default_method: :click, hooks: WFA_HOOKS)
  #div(:agency, xpath: '//app-view-general-information/div[@class="portlet portlet-hover"]/div[@class="portlet-body"]/div[@class="row"][1]/div[@class="col-md-3"][2]', hooks: TEXT_WAIT_HOOKS)
  div(:agency, xpath: './/div/label/strong[contains(text(), "Agency")]/following::div', hooks: TEXT_WAIT_HOOKS)
  div(:agency_contact_full_name_div, xpath: './/div/label/strong[contains(text(), "Contact")]/following::div', hooks: TEXT_WAIT_HOOKS)

  def agency_contact_full_name
    return agency_contact_full_name_div_element.text.split("\n")[1] # this is used to get the name without the icon containing the initials
  end

  # ------ Everything has been VERIFIED! ------------------------------------- #

  def wait_until_visible
    wait_for_ajax
  end
end
