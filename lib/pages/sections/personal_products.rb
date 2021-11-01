# frozen_string_literal: true

# this file has been verified for angular

class ProductCardSection < BaseSection
  # checkbox(:selected)
  div(:selected, class: /selected/)
  text_field(:how_many)

  def add(to_add = 1)
    if to_add.is_a?(Integer)
      #click if selected.checked? == to_add < 1
      click if selected? == to_add < 1
      how_many_element.set to_add
    elsif [true, false].include?(to_add)
      #click if selected.checked? != to_add
      click if selected? != to_add
    end
  end

  def add_no_num
    # selected.click!
    click!
  end
end

class PersonalProductsSelection < EDSL::PageObject::Section
  section(:automobile, ProductCardSection, assign_method: :add, how: :element, xpath: './/div[contains(@class, "box") and .//*[contains(text(), "Auto")]]')
  section(:residential, ProductCardSection, assign_method: :add, how: :element, xpath: './/div[contains(@class, "box") and .//*[contains(text(), "Home")]]')
  section(:umbrella, ProductCardSection, assign_method: :add, how: :element, xpath: './/div[contains(@class, "box") and .//*[contains(text(), "Umbrella")]]')
  section(:scheduled_property, ProductCardSection, assign_method: :add, how: :element, xpath: './/div[contains(@class, "box") and .//*[contains(text(), "Scheduled") and contains(text(), "Property")]]')
  section(:watercraft, ProductCardSection, assign_method: :add, how: :element, xpath: './/div[contains(@class, "box") and .//*[contains(text(), "Watercraft")]]')
  section(:renters, ProductCardSection, assign_method: :add, how: :element, xpath: './/div[contains(@class, "box") and .//*[contains(text(), "Renters")]]')
  section(:dwelling, ProductCardSection, assign_method: :add, how: :element, xpath: './/div[contains(@class, "box") and .//*[contains(text(), "Dwelling")]]')
end
