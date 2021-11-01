# frozen_string_literal: true

class WatercraftOptionalCoveragesPanel < BasePanel
  button(:modify, class: /action-icon/, default_method: :click, hooks: WFA_HOOKS)
  strong(:boating_equipment_coverage_increase, xpath: './/strong[contains(text(), "Boating Equipment Coverage Increase")]')
  strong(:emergency_service_expanded_coverage, xpath: './/strong[contains(text(), "Emergency Service Expanded Coverage")]')
  strong(:manual_coverage, xpath: './/strong[contains(text(), "Manual Coverage")]')
  strong(:personal_effects, xpath: './/strong[contains(text(), "Personal Effects")]')
  span(:boating_equipment_coverage_increase_selected, xpath: './/strong[contains(text(), "Boating Equipment Coverage Increase")]/../following-sibling::div/span')
  span(:emergency_service_expanded_coverage_selected, xpath: './/strong[contains(text(), "Emergency Service Expanded Coverage")]/../following-sibling::div/span')
  span(:manual_coverage_selected, xpath: './/strong[contains(text(), "Manual Coverage")]/../following-sibling::div/span')
  span(:personal_effects_selected, xpath: './/strong[contains(text(), "Personal Effects")]/../following-sibling::div/span')
end
