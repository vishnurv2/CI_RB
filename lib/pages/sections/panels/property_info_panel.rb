# frozen_string_literal: true

class PropertyInfoPanel < BasePanel
  div(:address, xpath: './/div/strong[contains(text(), "Address")]/following::div', hooks: TEXT_WAIT_HOOKS)
  div(:year_built, xpath: './/div/strong[contains(text(), "Year Built")]/following::div', hooks: TEXT_WAIT_HOOKS)
  div(:construction, xpath: './/div/strong[contains(text(), "Construction")]/following::div', hooks: TEXT_WAIT_HOOKS)
  div(:dwelling_use, xpath: './/div/strong[contains(text(), "Dwelling Use")]/following::div', hooks: TEXT_WAIT_HOOKS)
  div(:protection_class, xpath: './/div/strong[contains(text(), "Protection Class")]/following::div', hooks: TEXT_WAIT_HOOKS)
  div(:form_type, xpath: './/div/strong[contains(text(), "Form Type")]/following::div', hooks: TEXT_WAIT_HOOKS)
  button(:modify, xpath: './/p-button[@icon="fas fa-pencil"]/button')
end
