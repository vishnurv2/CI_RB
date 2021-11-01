# frozen_string_literal: true

class LeaseLoanGuardPanel < BaseSection
  radio_set(:loan_or_lease_guard, xpath: '.', item: { id: /LoanLeaseLoanLeaseToggleButton/ })
  select(:total_limit_loan_guard, id: /LoanLease_LoanLeaseOptionDropdown/)
  toggle_button_list(:loan_lease_limitation, id: /LoanLease(Signature|Summit)LoanGuardLimitationToggleButton/)
end

class TowingLaborPanel < BaseSection
  checkbox(:towing_and_labor, id: 'TowingLaborSelected')
  select(:total_limit_per_disablement, id: /TowingLabor_TotalLimitDropdown/)
end

class CustomEquipmentPanel < BaseSection
  checkbox(:custom_equipment, id: 'ExcessCustomEquipmentSelected')
  text_field(:total_coverage_limit, id: 'CurrencyWidgetCustomEquipmentTotalCoverageLimitTextbox')
end

class ManualCoveragePanel < BaseSection
  checkbox(:manual_coverage_check_box, id: 'ManualEndorsementSelected')
  button(:delete, xpath: './/span[contains(@class,"far fa-trash")]/..')
  textarea(:description_field, id: /ManualEndorsementDescription/)
  text_field(:premium, id: /urrency/, assign_method: :set!)
  link(:view_form, id: /ManualCoverageFormLink/)

  def description=(new_description)
    #parent_container.wait_for_ajax
    description_field_element.click
    description_field_element.set new_description
  end

  def description
    description_field
  end
end

class TransportationNetworkCoveragePanel < BaseSection
  checkbox(:transportation_network_coverage, id: /TransportationNetwork/)
  select(:company, id: /TransportationNetworkCompany/)
  text_field(:hours_per_week, id: /AverageHoursPerWeek/)
  select(:driver, id: /DriverAssociated/)
end

class ElectronicEquipmentPanel < BaseSection
  checkbox(:electronic_equipment_check_box, id: /ExcessElectronicEquipment/)
  select(:total_limit, id: /ExcessElectronicEquipment/)
end

class ExtendedTransportationPanel < BaseSection
  checkbox(:extended_transportation, id: /TransportationSelected/)
  select(:total_limit_extended_transportation, id: /ExtendedTransportation/)
end
class LeaseGuard < BaseSection
  checkbox(:lease_load_guard, id: /LoanLeaseSelected/)
  div(:lease_guard_button, xpath: '//span[contains(text(),"Lease Guard")]/..')
end

class AutoVehicleCoveragesModal < BaseModal
  tab_strip(:tabs, id: 'customTab')
  coverage_list_ng(:coverages_list, xpath: './/app-dynamic-coverage')
  sections(:manual_coverages, ManualCoveragePanel, xpath: '//div[contains(@class, "coveragePanel") and .//label[text()="Manual Coverage"]]', item: { xpath: './/div[contains(@class, "coverageIterationPanel")]' })
  section(:transportation_network_coverage_panel, TransportationNetworkCoveragePanel, xpath: '//div[contains(@class, "coveragePanel") and .//label[text()="Transportation Network Coverage"]]')
  checkbox(:manual_coverage, xpath: './/app-dynamic-control[.//text()[contains(., "anual")]]/.//p-checkbox')
  section(:electronic_equipment_coverage_panel, ElectronicEquipmentPanel, xpath: '//div[contains(@class, "coveragePanel") and .//label[text()="Electronic Equipment"]]')
  section(:extended_transportation_panel, ExtendedTransportationPanel, xpath: '//div[contains(@class, "coveragePanel") and .//label[text()="Extended Transportation"]]')
  section(:lease_guard, LeaseGuard, xpath: '//div[contains(@class, "coveragePanel") and .//label[text()="Lease / Loan Guard"]]')
  section(:custom_equipment_panel, CustomEquipmentPanel, xpath: '//div[contains(@class, "coveragePanel") and .//label[text()="Custom Equipment"]]')
  section(:towing_and_labor_panel, TowingLaborPanel, xpath: '//div[contains(@class, "coveragePanel") and .//label[text()="Towing & Labor"]]')
  checkbox(:other_than_collision, id: 'OtherThanCollisionSelected')
  checkbox(:collision, id: 'CollisionSelected')
  # rubocop:disable Metrics/AbcSize
  # This is only .39 over the metric, not going to refactor.
  def populate_with(data)
    data ||= data.fetch(populate_key, data)
    data ||= data.fetch(populate_key.to_sym, data)

    data.each do |k, v|
      handle_coverage_with_hash(k, v) if v.is_a?(Hash)
      handle_coverage_with_value(k, v) if v.is_a?(String)
      handle_bool_coverage(k, v) unless v.is_a?(String)

    rescue Exception => ex

      raise "#{ex.message} raised while setting #{k}"
    end
  end
  # rubocop:enable Metrics/AbcSize

  def available_coverages
    coverage_list.coverages.map(&:label)
  end

  def save_and_close
    save_and_close_button
  end

  def handle_bool_coverage(coverage, enable)
    method = enable ? 'select_coverage' : 'remove_coverage'
    coverages_list.send(method, coverage)
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
  end

  def handle_coverage_with_value(coverage, data)
    coverages_list.add_coverage(coverage)
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
    self.deductible = data
  end

  def handle_coverage_with_hash(coverage, data)
    coverages_list.select_coverage(coverage)
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
    name = coverage.is_a?(String) ? coverage : coverage.source
    panel = panel_obj_for_coverage(name)
    panel.populate_with data
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
  end

  def panel_obj_for_coverage(name)
    return panel_class_for_coverage(name).new(div(id: 'RightCoverageDetails'), self) if name.include? 'Manual'
    obj = label(text: name).parent.parent.parent.parent.parent
    panel_class_for_coverage(name).new(obj,self)
  end

  def panel_class_for_coverage(name)
    classname = name.tr('/', ' ').tr('&', ' ').snakecase.camelcase(:upper)
    panel_class = "#{classname}Panel"
    Object.const_get(panel_class)
  end

  def select_coverage(coverage)
    coverages_list.select_coverage(coverage)
    panel_obj_for_coverage(coverage)
  end
end
