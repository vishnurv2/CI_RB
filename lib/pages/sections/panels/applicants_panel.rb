# frozen_string_literal: true

class ApplicantsPanel < BasePanel
  data_grid(:applicants, ApplicantRow)
  button(:add_applicant_button, xpath: './/p-button[@icon="pi pi-plus"]/button')
  div(:menu, xpath: '//div[contains(@class,"p-menu")]')
  link(:add_applicant_menu, xpath: '//span[text()="Add Applicant"]/..', default_method: :click!)
  link(:add_party_menu, xpath: '//span[text()="Add Party"]/..', default_method: :click!)
  link(:add_applicant_menu_without_click, xpath: '//span[text()="Add Applicant"]/..')
  link(:add_party_menu_without_click, xpath: '//span[text()="Add Party"]/..')
  link(:link_accounts_menu, xpath: '//span[text()="Link Accounts"]/..')
  button(:confirm_delete, xpath: './/p-button[contains(@label, "Delete")]/button')
  button(:cancel_delete, xpath: './/p-button[contains(@label, "Cancel")]/button')
  button(:delete_yes, xpath: './/p-button[contains(@label, "Delete")]/button')
  button(:delete_no, xpath: './/p-button[contains(@label, "Cancel")]/button')
  section(:add_applicant_modal, AddApplicantModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Applicant") or contains(text(), "New Party") or contains(@class, "modal-title-medium")]]')
  section(:add_party_modal, AddPartyModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Add Party")]]')

  #Parties modal headers
  th(:name_header, xpath: './/th[contains(.,"Name")]')
  th(:role_header, xpath: './/th[contains(.,"Role(s)")]')
  th(:email_header, xpath: './/th[contains(.,"Email")]')
  th(:phone_header, xpath: './/th[contains(.,"Phone")]')
  th(:account_owner_header, xpath: './/th[contains(.,"Account Owner")]')

  def delete_all_but_one
    last_applicants_count = -1
    applicants_collection = applicants
    current_applicants_count = applicants_collection.count
    while last_applicants_count != current_applicants_count && current_applicants_count > 1 # keep track of the current/last count so we don't infinitely loop
      begin
        a = applicants_collection.last
        a.scroll.to
        a.delete
        Watir::Wait.while { a.present? }
      rescue
      end
      last_applicants_count = current_applicants_count
      applicants_collection = applicants # update the list of applicants each loop so that it can find the elements
      current_applicants_count = applicants_collection.count
    end
  end

  def add_policy_applicant
    add_applicant_button_element.scroll.to :center
    add_applicant_button
    Watir::Wait.until(timeout: 30) { menu?}
    add_party_menu if add_party_menu?
    Watir::Wait.until(timeout: 30) { add_party_modal? || parent_container.errors? }
    add_party_modal.select_add_party_type = "Individual"
    add_party_modal.role = "Applicant"
    add_party_modal.next
    Watir::Wait.until(timeout: 30) { add_applicant_modal? || parent_container.errors? }
    wait_for_ajax
    parent_container.raise_page_errors 'attempting to add an applicant from the applicants panel'
  end

  def add_applicant
    # add_applicant_button_element.scroll.to :center
    # add_applicant_button
    # add_applicant_menu if add_applicant_menu?
    # Watir::Wait.until(timeout: 30) { add_applicant_modal? || parent_container.errors? }
    # wait_for_ajax
    # parent_container.raise_page_errors 'attempting to add an applicant from the applicants panel'
    add_applicant_button_element.scroll.to :center
    wait_for_ajax
    add_applicant_button
    add_party_menu if add_party_menu?
    Watir::Wait.until(timeout: 30) { add_party_modal? || parent_container.errors? }
    add_party_modal.select_add_party_type = "Individual"
    add_party_modal.role = "Applicant"
    add_party_modal.next
    Watir::Wait.until(timeout: 30) { add_applicant_modal? || parent_container.errors? }
    wait_for_ajax
    parent_container.raise_page_errors 'attempting to add an applicant from the applicants panel'
  end


  def add_party_details(party_type, role)
    add_applicant_button_element.scroll.to :center
    wait_for_ajax
    add_applicant_button
    Watir::Wait.until(timeout: 30) { menu?}
    add_party_menu if add_party_menu?
    Watir::Wait.until(timeout: 30) { add_party_modal? || parent_container.errors? }
    add_party_modal.select_add_party_type = party_type
    sleep(2)
    add_party_modal.role = role
    add_party_modal.next
    Watir::Wait.until(timeout: 30) { add_applicant_modal? || parent_container.errors? }
    wait_for_ajax
    parent_container.raise_page_errors 'attempting to add an applicant from the applicants panel'
  end

  def add_party_details_driver_trustee(party_type)
    add_applicant_button_element.scroll.to :center
    wait_for_ajax
    add_applicant_button
    Watir::Wait.until(timeout: 30) { menu?}
    add_party_menu if add_party_menu?
    Watir::Wait.until(timeout: 30) { add_party_modal? || parent_container.errors? }
    add_party_modal.select_add_party_type = party_type
    add_party_modal.role.click
    add_party_modal.driver_option_hover_over_message
    add_party_modal.trustee_option_hover_over_message
  end

  def add_party_details_dropdown_assertion
    add_applicant_button_element.scroll.to :center
    wait_for_ajax
    add_applicant_button
    Watir::Wait.until(timeout: 30) { menu?}
    #add_party_menu if add_party_menu?
    #Watir::Wait.until(timeout: 30) { add_party_modal? || parent_container.errors? }
    #add_party_modal.select_add_party_type = party_type
    #add_party_modal.role = role
    #add_party_modal.next
    #Watir::Wait.until(timeout: 30) { add_applicant_modal? || parent_container.errors? }
    #wait_for_ajax
    #parent_container.raise_page_errors 'attempting to add an applicant from the applicants panel'
  end

  def add_party_details_from_Thankyou_Modal(party_type, role)
    # add_applicant_button_element.scroll.to :center
    #wait_for_ajax
    #add_applicant_button
    #Watir::Wait.until(timeout: 30) { menu?}

    add_party_menu if add_party_menu?
    Watir::Wait.until(timeout: 30) { add_party_modal? || parent_container.errors? }
    add_party_modal.select_add_party_type = party_type
    add_party_modal.role = role
    add_party_modal.next
    Watir::Wait.until(timeout: 30) { add_applicant_modal? || parent_container.errors? }
    wait_for_ajax
    parent_container.raise_page_errors 'attempting to add an applicant from the applicants panel'
  end

  def strip_age_from_name(name)
    name.split('(').last.split(')').join
  end

  def strip_age_from_name_strip_new_line(name)
    name.split('(').last.split(')').join.split("\n").first
  end

  def find_applicant_by_name(name)
    applicants_element.find_by(:name, name.is_a?(Hash) ? name.applicant_full_name : name)
  end

  def reverse_find_applicant_by_name(name)
    applicants_element.find_by(:name_text, name.is_a?(Hash) ? name.applicant_full_name.upcase : name)
  end

  def reverse_find_applicant_by_name_stripped(name)
    applicants_element.find_by(:name_stripped, name.is_a?(Hash) ? name.applicant_full_name : name)
  end

  # ------ Everything below this line is unverified ------------------------------------- #
  div(:entries_label, class: 'dataTables_info')
end
