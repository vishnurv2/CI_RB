# frozen_string_literal: true

class VehicleOverrideModal < BaseModal
  text_field(:effective_date, class: 'datePicker')
  textarea(:notes)
  select_list(:override_selection)

  def modify_override_details
    change_override_select_list
    change_effective_date
    change_notes
  end

  def change_effective_date
    date = (Chronic.parse(effective_date) + 86_400) # one day prior, subtracting 24 hours worth of seconds
    effective_date_element.set date.to_date.strftime('%m/%d/%Y')
  end

  def change_notes
    notes.length < 100 ? notes_element.set("#{notes}more notes") : notes_element.set('notes')
  end

  def select_next_index
    override_selection_element.select_index next_index
  end

  def next_index
    (override_selection_element.selectedindex % max_selection_index) + 1 # we don't want 0 because that's '--Select--'
  end
end

class VehicleTerritoryOverrideModal < VehicleOverrideModal
  span(:selected_territory, name: 'SelectedTerritory')
  span(:system_generated_territory_field, name: 'SystemGeneratedValue')
  select_list(:territory_override, id: 'OverrideTerritoryValue')
  textarea(:note, id: 'Note')

  def change_override_select_list
    original_index = override_selection_element.selectedindex
    select_next_index
    select_next_index while should_select_next_index?(override_selection_element.selectedindex, original_index)
    raise 'Could not find a valid new index to change the territory override select list to' if next_index == original_index
  end

  def system_generated_territory
    system_generated_territory_field.split(' ').first
  end

  def should_select_next_index?(original_index, next_index)
    next_index != original_index && (override_selection == selected_territory || override_selection == system_generated_territory)
  end

  def max_selection_index
    10
  end
end

class VehicleTierOverrideModal < VehicleOverrideModal
  def change_override_select_list
    select_next_index
  end

  def max_selection_index
    6
  end
end
