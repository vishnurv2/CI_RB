# frozen_string_literal: true

class DriverRow < EDSL::PageObject::Section
  span(:edit, class: /fa-pencil/, default_method: :click, hooks: WFA_HOOKS)
  span(:delete, class: 'fa-trash', default_method: :click, hooks: WFA_HOOKS)

  td(:name, data_label: 'Name')
  td(:relationship_to_applicant, data_label: 'Relationship to Applicant')
  td(:marital_status, data_label: 'Marital Status')
  td(:license, data_label: 'DriverLicense')
end

class AutoDriverInformationPanel < BasePanel
  data_grid(:drivers, DriverRow)
  span(:add_driver_button, class: /fa-plus/, default_method: :click, hooks: WFA_HOOKS)
  div(:showing_entries, class: 'dataTables_info')
  span(:no_drivers_error_message, class: /p-inline-message-text/)

  def add_driver
    add_driver_button
    Watir::Wait.until { parent_container.auto_driver_modal? || parent_container.auto_prefill_modal? }
  end

  FIELDS = { 'first_name' => 'name', 'last_name' => 'name', 'license_number' => 'license', 'license_state' => 'license' } # we don't compare relationship to applicant because to_find could contain piped values like 'Self|Child|Other'
  def find_driver_by_hash(to_find)
    return nil unless drivers_element.present?

    to_find.stringify_keys!
    
    drivers_left = drivers
    FIELDS.each do |k, v|
      drivers_left = drivers_left.select { |d| d.send(v).downcase.snakecase.include?(to_find[k].downcase.snakecase) } unless to_find[k].nil?
      return nil if drivers_left.count < 1
    end
    return drivers_left.first
  end
  # rubocop:enable Metrics/AbcSize

  def drivers_empty?
    drivers_element.show_entries?
  end

  def remove_all_drivers(remove_driver_modal)
    last_drivers_count = -1
    drivers_collection = drivers
    current_drivers_count = drivers_collection.count
    while last_drivers_count != current_drivers_count && current_drivers_count > 0 # keep track of the current/last count so we don't infinitely loop
      begin
        d = drivers_collection.last
        d.scroll.to :bottom
        d.delete
        remove_driver_modal.remove
        Watir::Wait.while(timeout: 15) { d.present? }
      rescue
      end
      last_drivers_count = current_drivers_count
      drivers_collection = drivers # update the list of applicants each loop so that it can find the elements
      current_drivers_count = drivers_collection.count
    end
  end

  def remove_extra_drivers(number_to_keep = 1)
    return unless drivers_element.present?

    drivers_to_remove = _find_drivers_to_remove
    return if drivers_to_remove.count <= number_to_keep

    puts "Removing #{drivers_to_remove.count - number_to_keep} drivers"
    api = PolicyAPI::DELETEApi.new
    drivers_to_remove[number_to_keep..-1].each do |driver|
      puts "Removing #{driver[:driver_id]}"
      api.policies_delete_driver driver[:act_id], driver[:driver_id]
    end
  end

  private

  def _find_drivers_to_remove
    found_drivers = []
    drivers.each do |item|
      driver_id, rest = item.edit_element.href.split('/').last.split('?')
      act_id = rest.split('=').last
      found_drivers << { driver_id: driver_id, act_id: act_id }
    end
    found_drivers.uniq
  end

  def _age_in_completed_years(birth_date, ref_date = Date.today)
    # Difference in years, less one if you have not had a birthday this year.
    a = ref_date.year - birth_date.year
    a -= 1 if birth_date.month > ref_date.month || (birth_date.month >= ref_date.month && birth_date.day > ref_date.day)
    a
  end

  def _to_date_with_age(value)
    dob = Chronic.parse(value).to_date
    "#{dob.strftime('%m/%d/%Y')} (#{_age_in_completed_years(dob, Date.today)})"
  end
end
