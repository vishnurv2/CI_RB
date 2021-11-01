# frozen_string_literal: true

class ScheduledPropertyPolicyLevelCoveragesModal < BaseModal

  checkbox(:smoke_detectors_on_all_floors, id: /ProtectiveDevices_SmokeDetectorsAllFloors/)
  select(:construction_location, id: /constructionCode/)
  select(:family_numbers, id: /numFamilies/)


  def next_modal
    save_and_continue

    ### this was in the old next modal - it was selecting the coverages tab?
    # tabs.active_tab = 'Coverage'
  end

  def save_and_close
    save_and_close_button
  end
end
