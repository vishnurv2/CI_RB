
class DwellingOptionalCoveragesPanel < BasePanel
  button(:modify, class: /action-icon/, default_method: :click, hooks: WFA_HOOKS)
  strong(:actual_cash_value_loss_settlement_roof_surface, xpath: './/strong[contains(text(), "Actual Cash Value Loss Settlement - Roof Surface")]')
  strong(:actual_cash_value_loss_settlement, xpath: './/strong[contains(text(), "Actual Cash Value Loss Settlement")]')
  strong(:animal_exclusion_endorsement, xpath: './/strong[contains(text(), "Animal Exclusion Endorsement")]')
  strong(:improvements_alterations_and_additions, xpath: './/strong[contains(text(), "Improvements, Alterations and Additions")]')
  strong(:ordinace_or_law_increased_limit, xpath: './/strong[contains(text(), "Ordinance or Law - Increased Limit")]')
  strong(:theft_of_building_materials, xpath: './/strong[contains(text(), "Theft of Building Materials")]')
  strong(:business_pursuits, xpath: './/strong[contains(text(), "Business Pursuits")]')
  strong(:canine_exclusion_endorsement, xpath: './/strong[contains(text(), "Canine - Exclusion Endorsement")]')
  strong(:earthquake, xpath: './/strong[contains(text(), "Earthquake")]')
  strong(:equipment_breakdown, xpath: './/strong[contains(text(), "Equipment Breakdown")]')
  strong(:functional_replacement_cost_loss_settlement, xpath: './/strong[contains(text(), "Functional Replacement Cost Loss Settlement")]')
  strong(:limited_fungi_wet_or_dry_rot_or_bacteria_coverage, xpath: './/strong[contains(text(), "Limited Fungi Wet or Dry Rot or Bacteria Coverage")]')
  strong(:loss_assessment_residence_premises, xpath: './/strong[contains(text(), "Loss Assessment - Residence Premises")]')
  strong(:manual_coverage, xpath: './/strong[contains(text(), "Manual Coverage")]')
  strong(:other_structures_exclusion_endorsement, xpath: './/strong[contains(text(), "Other Structures Exclusion Endorsement")]')
  strong(:replacement_cost_on_the_dwelling_additional_amount, xpath: './/strong[contains(text(), "Replacement Cost on the Dwelling-Additional Amount")]')
  strong(:other_structures_specifically_insured_on_premise, xpath: './/strong[contains(text(), "Other Structures - Specifically Insured - On Premise")]')
  strong(:theft, xpath: './/strong[contains(text(), "Theft")]')
  strong(:course_of_construction, xpath: './/strong[contains(text(), "Course of Construction")]')

  span(:actual_cash_value_loss_settlement_roof_surface_selected, xpath: './/strong[contains(text(), "Actual Cash Value Loss Settlement - Roof Surface")]/../following-sibling::div/span')
  span(:actual_cash_value_loss_settlement_selected, xpath: './/strong[contains(text(), "Actual Cash Value Loss Settlement")]/../following-sibling::div/span')
  span(:animal_exclusion_endorsement_selected, xpath: './/strong[contains(text(), "Animal Exclusion Endorsement")]/../following-sibling::div/span')
  span(:business_pursuits_selected, xpath: './/strong[contains(text(), "Business Pursuits")]/../following-sibling::div/span')
  span(:canine_exclusion_endorsement_selected, xpath: './/strong[contains(text(), "Canine - Exclusion Endorsement")]/../following-sibling::div/span')
  span(:earthquake_selected, xpath: './/strong[contains(text(), "Earthquake")]/../following-sibling::div/span')
  span(:equipment_breakdown_selected, xpath: './/strong[contains(text(), "Equipment Breakdown")]/../following-sibling::div/span')
  span(:functional_replacement_cost_loss_settlement_selected, xpath: './/strong[contains(text(), "Functional Replacement Cost Loss Settlement")]/../following-sibling::div/span')
  span(:limited_fungi_wet_or_dry_rot_or_bacteria_coverage_selected, xpath: './/strong[contains(text(), "Limited Fungi Wet or Dry Rot or Bacteria Coverage")]/../following-sibling::div/span')
  span(:loss_assessment_residence_premises_selected, xpath: './/strong[contains(text(), "Loss Assessment - Residence Premises")]/../following-sibling::div/span')
  span(:improvements_alterations_and_additions_selected, xpath: './/strong[contains(text(), "Improvements, Alterations and Additions")]/../following-sibling::div/span')
  span(:ordinace_or_law_increased_limit_selected, xpath: './/strong[contains(text(), "Ordinance or Law - Increased Limit")]/../following-sibling::div/span')
  span(:other_structures_specifically_insured_on_premise_selected, xpath: './/strong[contains(text(), "Other Structures - Specifically Insured - On Premise")]/../following-sibling::div/span')
  span(:manual_coverage_selected, xpath: './/strong[contains(text(), "Manual Coverage")]/../following-sibling::div/span')
  span(:theft_of_building_materials_selected, xpath: './/strong[contains(text(), "Theft of Building Materials")]/../following-sibling::div/span')
  span(:theft_selected, xpath: './/strong[contains(text(), "Theft")]/../following-sibling::div/span')
  span(:other_structures_exclusion_endorsement_selected, xpath: './/strong[contains(text(), "Other Structures Exclusion Endorsement")]/../following-sibling::div/span')
  span(:replacement_cost_on_the_dwelling_additional_amount_selected, xpath: './/strong[contains(text(), "Replacement Cost on the Dwelling-Additional Amount")]/../following-sibling::div/span')
  span(:course_of_construction_selected, xpath: './/strong[contains(text(), "Course of Construction")]/../following-sibling::div/span')
end