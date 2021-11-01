# frozen_string_literal: true

class CMIEmployeesSummaryPage < PolicyManagementPage
  # section(:referrals_panel, ReferralsPanel, id: 'referralsTabContent')
  # section(:referral_modal, ReferralModal, xpath: '//div[@id="divModalContent" and .//div/h4[contains(text(), "Underwriting Referrals")]]')
  # tab_strip(:tab_strip, class: 'cmi-tabstrip')
  # div(:overrides_tab_content, id: 'overridesTabContent', default_method: nil)
  #
  # section(:vehicle_territory_override_modal, VehicleTerritoryOverrideModal, xpath: '//div[@id="divModalContent" and (.//div/h4[contains(text(), "Territory")] or .//div/h4[contains(text(), "Overrides")])]')
  # section(:vehicle_tier_override_modal, VehicleTierOverrideModal, xpath: '//div[@id="divModalContent" and .//div/h4[contains(text(), "Tier")]]')


  sections(:referrals_panel, ReferralsPanel, xpath: './/div[@class="underwriting-referrals"]', item: { xpath: './/p-panel[.//p-panel]/div', how: :divs })
  button(:contact_underwriter, xpath: '//p-button[@id="contactUnderwriter"]/button')
  span(:uw_name, xpath: './/div[contains(text()," Contact your underwriter on the following prior to binding. ")]/following-sibling::div//span')
  div(:uw_title, xpath: './/div[contains(text()," Contact your underwriter on the following prior to binding. ")]/following-sibling::div/div  ')
  a(:uw_email, xpath: './/div//span//a[contains(text(),"@central-insurance.com")]')
  span(:uw_phone, xpath: './/div[contains(text()," Contact your underwriter on the following prior to binding. ")]/following-sibling::div//div/following-sibling::div//span')

  li(:client_name, xpath: '//ul[@class="client-details"]//li', index: 0)
  li(:client_address, xpath: '//ul[@class="client-details"]//li', index: 1)
  checkbox(:referral_header_checkbox, xpath: './/div[@id="faux-table-header"]/div/div[contains(@class, "inline-flex")]/p-checkbox')
  button(:review_button, xpath: './/button[@label="Review"]')
  label(:select_count, xpath: './/label[contains(@class,"selected-Count-text")]')

  # link(:underwriting_referrals_tab, xpath: '//span[text()="Underwriting Referrals"]/..')
  # link(:overrides_tab, xpath: '//span[text()="Overrides"]/..')
  # link(:notes_tab, xpath: '//span[text()="Notes"]/..')
  # link(:underwriting_summary_tab, xpath: '//span[text()="Underwriting Summary"]/..')
  # link(:manage_forms_tab, xpath: '//span[text()="Manage Forms"]/..')

  # def overrides_panels
  #   @overrides_panels ||= overrides_tab_content.children.map { |d| OverridesPanel.new(d, self) }
  # end

  def expand_each_policy_referrals
    referrals_panel.each do |row|
      row.chevron_right_element.click if row.chevron_right?
    end
  end

  def set_all_referral_statuses_to(status)
    referrals_panel.each do |panel|
      panel.referrals.each do |referral|
        unless referral.status.downcase.include? status.downcase
          referral.click
          referral.review_section.approval_status = status
          referral.review_section.save
          wait_for_ajax
        end
      end
    end
  end

  def empty_referrals
    begin
      none = div(xpath: '//div[contains(@class, "noReferrals")]')
    rescue Exception => ex
      STDOUT.puts "Unable to locate Toast Container - #{ex}"
    end

    return true if none.present?
  end

  def wait_for_modal
    Watir::Wait.until { referral_modal.present? }
    wait_for_ajax
    raise_page_errors 'waiting for modal referral_modal to appear'
  end

  def displayed?
    browser.url.include?('PolicyManagement/Employees/Summary?accountNumber=')
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
