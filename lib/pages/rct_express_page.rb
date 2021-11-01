# frozen_string_literal: true

class ConfirmationModal < BaseModal
  button(:save, id: 'SaveValuationButton')
end

class EditBuildingModal < BaseModal
  link(:home_style, xpath: './/a[text()="Home Style"]/../following-sibling::td//a')
  text_field(:year_built, xpath: '//input[@title="Year Built"]')
  text_field(:finished_living_area, xpath: '//input[@title="Finished Living Area"]')
  text_field(:wall_height, name: /WallHeights/)
  text_field(:save_building_button, xpath: '//input[@id="saveBuildingButton"]')

  def select_home_style=(opt)
    home_style_element.click
    dropdown_option = lis(xpath: '//div[@id="select2-drop"]/ul/li').find{|option|option.div.text == opt}
    dropdown_option.click
  end
end

class RCTExpressPage < BasePage
  page_url "https://rcttest7.msbexpress.net/central/ValuationEditor/Index/"

  text_field(:finish, xpath: '//input[@class="save-or-discard-valuation"]')
  span(:processing_overlay, xpath: '//span[@class="wait-big"]')

  def wait_for_loading_overlay_to_close
    sleep 0.5
    Watir::Wait.until { !processing_overlay? }
  end

  def displayed?
    browser.url.include?('https://rcttest7.msbexpress.net/central/ValuationEditor')
  end

  section(:edit_building_modal, EditBuildingModal, id: 'EditBuildingWindow')
  section(:confirmation_modal, ConfirmationModal, id: 'ConfirmationWindow')
end
