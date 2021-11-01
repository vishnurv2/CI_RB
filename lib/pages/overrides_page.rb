# frozen_string_literal: true

class OverridesPage < PolicyManagementPage

  sections(:overrides_panels, OverridesPanel, xpath: './/app-overrides//div', item: { xpath: '//p-panel/div[contains(@class,"panel-header-background")]'})

  # li(:client_name, xpath: '//ul[@class="client-details"]//li', index: 0)
  # li(:client_address, xpath: '//ul[@class="client-details"]//li', index: 1)
  # link(:underwriting_referrals_tab, xpath: '//span[text()="Underwriting Referrals"]/..')
  # link(:overrides_tab, xpath: '//span[text()="Overrides"]/..')
  # link(:notes_tab, xpath: '//span[text()="Notes"]/..')
  # link(:underwriting_summary_tab, xpath: '//span[text()="Underwriting Summary"]/..')
  # link(:manage_forms_tab, xpath: '//span[text()="Manage Forms"]/..')

  # def overrides_panels
  #   @overrides_panels ||= overrides_tab_content.children.map { |d| OverridesPanel.new(d, self) }
  # end

  def displayed?
    browser.url.include?('PolicyManagement/Employees/Summary?accountNumber=')
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end

  def first_vehicle_panel
    overrides_panels.first.vehicle_panels.first
  end

  def expand_1st_vhcl_override_panel
    tab_strip.active_tab = 'Overrides'
    overrides_panels.first.expand
    first_vehicle_panel.expand
  end

  def edit_first_override_of_type(override_type)
    expand_1st_vhcl_override_panel
    override_row = first_vehicle_panel.overrides.find { |row| row.override_element.text.casecmp(override_type).zero? }
    override_row.edit
  end
end
