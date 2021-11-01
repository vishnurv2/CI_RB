# frozen_string_literal: true

class OverrideRow < BaseSection
  # td(:override, data_label: /Override/)
  # span(:edit, class: 'fa-pencil-alt', default_method: :click, hooks: WFA_HOOKS)
  # td(:actions, data_label: /Actions/)
  # td(:status, data_label: /Status/)
  # td(:applies, data_label: /Applies/)
  # td(:effective_date, data_label: /Effective/)
  # td(:reviewed, data_label: /Reviewed/)
  # td(:notes, data_label: /Notes/)
  # link(:modify, href: /OverrideModal/)

  button(:override, xpath: './/p-button[@label="Override"]/button')
  button(:save, xpath: './/p-button[@name="Save"]/button')
  button(:cancel, xpath: './/p-button[@name="Cancel"]/button')
  button(:remove_override, xpath: './/p-button[@name="RemoveOverride"]/button')
  date_field(:effective_date, id: /effectiveDt/)
  textarea(:notes, name: /comments/)
  select(:customer_loyalty, xpath: './/div[text()="Customer Loyalty"]/following-sibling::p-dropdown')
  select(:override_territory, xpath: './/p-dropdown[contains(@id, "Territory")]')
  select(:override_tier, xpath: './/p-dropdown[contains(@id, "Tier")]')
  select(:package_discount_applied, id: /PackageDiscount/)
  #select(:override_tier)
  span(:status, text: /Overridden/)
  div(:override_effective_date, id: /effectiveDt/)
  i(:review_icon_right, class: /review-icon fas fa-angle-right/)
  i(:review_icon_down, class: /review-icon fas fa-angle-down/)
  span(:override_type, class: /bold-text/)

  button(:edit, xpath: './/button[@icon="fas fa-pencil"]')
  div(:user_override_protection_class_text, text: /User Override Protection Class/)
  div(:user_override_protection_class, xpath: '//div[contains(text(),"User Override Protection Class")]/following-sibling::div')
  text_field(:override_eff_date, name: /effectivDate/)
  select(:override_protection_class_dropdown, id: /overrideDropdown/)
  span(:dropdown_label, class: /p-dropdown-label/)
  span(:info_icon, xpath: '//p-button[contains(@icon,"fa-info-circle")]/button/span[contains(@class,"fa-info-circle")]')
  i(:overridden_info_icon, xpath: '//i[contains(@class,"fa-info-circle")]')

  def set_effective_date
    effective_date_element.set DateTime.now.strftime("%d/%m/%Y")
  end

end

class OverrideVehiclePanel < BasePanel
  # data_grid(:overrides, OverrideRow) # was "overrides_grid" prior to Angular 1-22-2020 # , id: /^DataTables_Table_\d+_wrapper/)
  # div(:collapse_button, role: 'button', data_target: /VehicleOverridePanel_/)
  #
  # def expand
  #   collapse_button_element.click if collapse_button_element.attributes[:aria_expanded] == 'false'
  # end
end

class OverridesPanel < BasePanel
  # data_grid(:overrides, OverrideRow) # was "overrides_grid" prior to Angular AMN 1-22-2020 # , id: /^DataTables_Table_\d+_wrapper/)
  link(:collapse_button, role: 'tab')

  sections(:overrides, OverrideRow, xpath: '.', item: { xpath: './/app-override-details', how: :elements })
  sections(:vehicle_panels, OverrideRow, xpath: './/div[.//div[contains(text(), "Tier")]]', item: { xpath: './/app-override-details//p-panel[.//div[contains(text(), "Tier")]]', how: :elements })
  accordion(:territory_panels, OverrideRow, xpath: './/div[.//span[contains(text(), "Territory")]]', item: { xpath: './/p-accordiontab[.//span[contains(text(), "Territory")]]' })
  accordion(:protection_class, OverrideRow, xpath: '//div[.//span[contains(text(), "Protection Class")]]', item: { xpath: '//p-accordiontab[.//span[contains(text(), "Protection Class")]]' })

  span(:status, id: /alue/)

  select(:customer_loyalty, id: /CustomerLoyalty/)
  date_field(:effective_date)
  textarea(:notes, name: 'comments')

  button(:save, xpath: './/p-button[@name="Save"]/button')
  select(:select_policy, class: /hide-on-small-medium/)

  def vehicle_count
    return overrides.select { |o| o.text.downcase.include? 'tier' }.count
  end

  def overrides_with_text(override_text)
    overrides.select { |o| o.text.downcase.include? override_text.downcase }
  end

  def expand
    collapse_button_element.click if collapse_button_element.attributes[:aria_expanded] == 'false'
  end
end
