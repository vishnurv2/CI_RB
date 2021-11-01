# frozen_string_literal: true

class LossPayeeAddressDetailsSection < AddressDetailsSection

  # ------ Everything below this line is unverified ------------------------------------- #
  #
  text_field(:address_line_1) { |cont| cont.text_field(id: "BusinessAddressLine1_#{cont.index}_") }
  text_field(:address_line_2) { |cont| cont.text_field(id: "BusinessAddressLine2_#{cont.index}_") }
  text_field(:address_line_3) { |cont| cont.text_field(id: "BusinessAddressLine3_#{cont.index}_") }
  textarea(:description) { |cont| cont.textarea(id: "BusinessAddressDescription_#{cont.index}_") }
  text_field(:city) { |cont| cont.text_field(id: "BusinessCity_#{cont.index}_") }
  select_list(:state) { |cont| cont.select_list(id: "BusinessStateProvDropList_#{cont.index}_") }
  text_field(:zip_code) { |cont| cont.text_field(id: "BusinessZipCode_#{cont.index}_") }
  text_field(:zip4) { |cont| cont.text_field(id: "BusinessZip4_#{cont.index}_") }
  text_field(:county) { |cont| cont.text_field(id: "BusinessCounty_#{cont.index}_") }
  select_list(:country) { |cont| cont.select_list(id: "BusinessCountry_#{cont.index}_") }
  hidden(:bypass_address_scrubber) { |cont| cont.hidden(id: "BusinessAddressBypassScrubbingIndicator_#{cont.index}_") }

  toggle_button_list(:address_detail_type) { |cont| cont.div(id: "BusinessAddressDetailType[#{cont.index}]") }

  div(:address_scrubbing_alert, class: 'addressScrubbingAlert')
  radio(:scrubbed_address_selection, name: 'ScrubbedAddressSelection')
  button(:confirm_scrub, text: 'Confirm Selection')

  def index
    attribute_value(:id).split('_').last.to_i
  end

  def use_entered_address
    scrubbed_address_selection_element.click
    confirm_scrub
  end
end

class IncludedPartyRow < BaseSection
  td(:name, data_label: /Name/)
  td(:role, data_label: /Role/)
  #span(:edit, title: 'Edit', default_method: :click, hooks: WFA_HOOKS)
  link(:edit, class: 'IncludedPartiesTableEditLink', hooks: WFA_HOOKS)
  link(:edit_other, class: 'OtherPartiesTableEditLink', hooks: WFA_HOOKS)

  def contains_role?(desired_role)
    role_element.span.text.gsub(/ \[(.*?)\]/, '').split(', ').map(&:snakecase).include? desired_role.snakecase
  end

  def contains_roles?(desired_roles)
    roles = role_element.text.gsub(/ \[(.*?)\]/, '').split(', ').map(&:snakecase)
    desired_roles.all? { |desired_role| roles.include? desired_role.snakecase }
  end

  def roles
    role_element.text.gsub(/ \[(.*?)\]/, '').split(', ').map(&:snakecase)
  end
end

class PartiesPanel < BaseSection
  data_grid(:parties, IncludedPartyRow, xpath: '.', item: { xpath: './/tbody/tr[@class="ng-star-inserted"]'})# , id: /tbl(Included|Other)Parties_wrapper/, item: { xpath: './/tbody/tr' })
  link(:add_party, class: 'addPartyButton')
  span(:disabled_trashcan, class: %w[fa-trash-alt cmi-disabled])

  def find_role_checkbox(name)
    return CentralElements::CheckboxCMI.new(div(text: name), self)
  end

  def role=(role)
    find_role_checkbox(role).check!
  end

  def find_party(name, roles)
    return parties_that_start_with(name.snakecase).find { |row| row.contains_roles?(roles) } if roles.class == Array

    parties_that_start_with(name.snakecase).find { |row| row.contains_role?(roles.to_s.snakecase) }
  end

  def find_party_with_role(role)
    return parties_that_start_with(name.snakecase).find { |row| row.contains_roles?(role) } if roles.class == Array

    parties_that_start_with(name.snakecase).find { |row| row.contains_role?(roles.to_s.snakecase) }
  end

  def find_party_count_for_role(role)
    return parties.select { |row| row.role.snakecase.starts_with?(role.snakecase)}.count
  end

  def parties_that_start_with(name)
    parties.select { |row| row.name.snakecase.starts_with?(name.snakecase) }
  end
end

class AppliesToVehicleRow < BaseSection
  def applies=(checkbox_selection)
    CentralElements::CheckboxCMI.new(div(class: 'checkbox'), self).set(checkbox_selection)
  end
end

class AddRoleTab < BaseSection
  select_list(:role, id: 'NewRoleDropdown')
  button(:add_role, id: 'btnAddRole')
end

class AppliesToVehicleRoleInfoTab < BaseSection
  data_grid(:vehicles, AppliesToVehicleRow) # , id: /DataTables_Table_[0-9]*_wrapper/, item: { xpath: './/tbody/tr' })
  select_list(:address_selection, id: /AddressIndex_[0-9]*_/)
  section(:address, AddressDetailsSection, id: 'divAddressDetailsContainer')

  def vehicle_selections=(selections)
    vehicles.each_with_index { |v, i| v.applies = selections[i] }
  end
end

class TrustRoleInfoTab < BaseSection
  select_list(:address_selection, id: /AddressIndex_/)
end

class ApplicantRoleInfoTab < BaseSection
  label(:account_level_applicant, xpath: './/label/input[@name="AccountProductCheckbox[0]"]/..', default_method: :click)
  label(:policy_applicant, xpath: './/label/input[@name="AccountProductCheckbox[1]"]/..', default_method: :click)
  select_list(:applicant_primary_address, id: /^AddressIndex_/)

  def account_level_applicant=(t_or_f)
    account_level_applicant if (account_level_applicant_element.classes.include? 'active') != t_or_f
  end

  def policy_applicant=(t_or_f)
    policy_applicant if (policy_applicant_element.classes.include? 'active') != t_or_f
  end
end

class AdditionalInterestRoleInfoTab < BaseSection
  select_list(:primary_address, id: /^AddressIndex_/)

  def products
    divs(class: 'checkbox')
  end

  def products=(selections)
    products.each_with_index { |checkbox, i| checkbox.click if i < selections.count && checkbox.label().attribute('class').include?('active') != selections[i] }
  end
end

class JointOwnershipRoleInfoTab < BaseSection
  data_grid(:vehicles, AppliesToVehicleRow) # , id: /DataTables_Table_[0-9]*_wrapper/ , item: { xpath: './/tbody/tr' })
  select_list(:primary_address, id: /^AddressIndex_/)

  def vehicle_selections=(selections)
    vehicles.each_with_index { |v, i| v.applies = selections[i] }
  end

  def products
    divs(class: 'checkbox')
  end

  def products=(selections)
    products.each_with_index { |checkbox, i| checkbox.click if i < selections.count && checkbox.label().attribute('class').include?('active') != selections[i] }
  end
end

class RoleInformationModal < BaseModal
  tab_strip(:tabs, class: 'cmi-tabstrip')
  section(:corporate_auto_role_info, AppliesToVehicleRoleInfoTab, class: 'tab-content', id: 'CorporateAutoTabContent')
  section(:trust_role_info, TrustRoleInfoTab, class: 'tab-content', id: 'TrustTabContent')
  section(:lessor_role_info, AppliesToVehicleRoleInfoTab, class: 'tab-content', id: 'LessorTabContent')
  section(:applicant_role_info, ApplicantRoleInfoTab, class: 'tab-content', id: 'InsuredTabContent')
  section(:add_role_tab, AddRoleTab, class: 'tab-content', id: 'addRoleTabContent')
  section(:loss_payee_role_info, AppliesToVehicleRoleInfoTab, class: 'tab-content', id: 'LossPayeeTabContent')
  section(:additional_interest_role_info, AdditionalInterestRoleInfoTab, class: 'tab-content', id: 'AdditionalInterestTabContent')
  section(:joint_ownership_role_info, JointOwnershipRoleInfoTab, class: 'tab-content', id: 'JointOwnershipTabContent')
  select(:existing_party, id: 'ExistingPartyDropdown', hooks: WFA_HOOKS)

  def add_role(role, role_info)
    tabs.active_tab = 'Add Role'
    add_role_tab.role = role
    add_role_tab.add_role
    send("#{role.snakecase}_role_info").populate_with(role_info)
    save_and_close
    Watir::Wait.while { present? }
  end
end

class OrganizationModal < RoleInformationModal
  text_field(:name, id: 'OrganizationName')
  text_field(:also_known_as, id: 'AlsoKnownAs')
  text_field(:email, id: /^EmailAddress_/)
  text_field(:phone_number, id: /^PhoneNumber_/)
end

class PersonPartyModal < RoleInformationModal
  text_field(:first_name, id: 'FirstName')
  text_field(:last_name, id: 'LastName')
  toggle_button_list(:gender, id: 'Gender')
  text_field(:date_of_birth, id: 'DateOfBirth')
  select_list(:occupation, id: 'Occupation')
  text_field(:occupation_title, id: 'OccupationTitle')
  text_field(:employer, id: 'EmployerName')
  text_field(:email, id: /EmailAddress/)

  def date_of_birth=(dob)
    date_of_birth_element.set! Chronic.parse(dob).to_date.strftime('%m/%d/%Y')
  end
end

class LossPayeePartyModal < OrganizationModal
  text_field(:loan_number, id: /^VehicleLoanNumber_/)
  select_list(:loan_vehicle, id: /^VehicleName_/)

  def loan_vehicle_index=(index)
    loan_vehicle_element.select(index)
  end
end

class PartyInformationSummaryPage < PolicyManagementPage
  #section(:included_parties_panel, PartiesPanel, id: 'includedPartiesSummary')
  section(:included_parties_panel, PartiesPanel, xpath: '//p-table[@id="grdPartyInformation"]/div')
  section(:other_parties_panel, PartiesPanel, id: 'otherPartiesSummary')
  section(:loss_payee_party_modal, LossPayeePartyModal, xpath: '//div[@id="divModalContent" and .//form/input[@value="LossPayeePartyScreen"]]')
  section(:applicant_party_modal, PersonPartyModal, xpath: '//div[@id="divModalContent" and .//form/input[@value="ApplicantPartyScreen"]]')
  section(:lessor_party_modal, OrganizationModal, xpath: '//div[@id="divModalContent" and .//form/input[@value="LessorPartyScreen"]]')
  section(:trust_party_modal, OrganizationModal, xpath: '//div[@id="divModalContent" and .//form/input[@value="TrustPartyScreen"]]')
  section(:corporate_auto_party_modal, OrganizationModal, xpath: '//div[@id="divModalContent" and .//form/input[@value="CorporateAutoPartyScreen"]]')
  section(:additional_interest_party_modal, PersonPartyModal, xpath: '//div[@id="divModalContent" and .//form/input[@value="AdditionalInterestPartyScreen"]]')
  section(:joint_ownership_party_modal, PersonPartyModal, xpath: '//div[@id="divModalContent" and .//form/input[@value="JointOwnershipPartyScreenScreen"]]')
  section(:prefill_driver_not_added_party_modal, PersonPartyModal, xpath: '//div[@id="divModalContent" and .//form/input[@value="PrefillDriverNotAddedPartyScreen"]]')

  def add_party(role)
    included_parties_panel.populate_with data_for('included_parties_panel')
    included_parties_panel.add_party
    modal = send("#{role.snakecase}_party_modal")
    modal.populate_with(data_for("#{role.snakecase}_party_modal"))
    modal.save_and_close
    wait_for_modal_masker
  end

  def start_to_add_party
    included_parties_panel.populate_with data_for('included_parties_panel')
    included_parties_panel.add_party
  end
end
