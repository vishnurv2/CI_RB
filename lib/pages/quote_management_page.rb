# frozen_string_literal: true

class QMSection < BaseSection
  date_field(:effective_date, id: /effectiveDate/)
  select(:package_discount, id: /packageDiscount/)
  select(:enhanced_coverage, id: /enhancedCoverage/)
  select(:liability_limit, id: /liabilityLimit/)
  span(:status, id: /quotePolicyStatus/)
  checkbox(:quote_checkbox, id: /quoteChbox/)
  span(:quote_policy_name, id: /quotePolicyName/)
  span(:quote_premium, id: /quotePremium/)
  span(:paid_in_full, id: /quotePaidInFull/)
  span(:action, id: /action/)
  link(:view_product_quote, text: 'View Product Quote')
  link(:edit_product, text: 'Edit Product')
  link(:do_not_issue, text: 'Do Not Issue')
  link(:delete_policy_change, text: 'Delete Policy Change')
  sections(:vehicles, QOPVehicleSection, xpath: '.', item: { xpath: './/*[contains(@id,"vehicle")]/parent::div/parent::div', how: :divs })
  div(:current_annual_premium, xpath: './/span[text()="Current Annual Premium"]/../following-sibling::div')
  div(:new_annual_premium, xpath: './/span[text()="New Annual Premium"]/../following-sibling::div')
  div(:difference_in_premium, xpath: './/span[text()="Difference"]/../following-sibling::div')
  span(:premium, xpath: './/app-quote-details//span[contains(@id,"quotePremium")]')
  span(:expansion_icon_up, class: /fa-chevron-up/)
  span(:expansion_icon_down, class: /fa-chevron-down/)
  span(:package_discount_cmp, xpath: './/p-dropdown[@id="packageDiscount_30"]//span')
  span(:enhanced_coverage_cmp, xpath: './/p-dropdown[@id="enhancedCoverage_30"]//span')
  #Umbrella
  select(:umbrella_liability_limit, id: /umbrellaLiability/)
  select(:umbrella_uninsured_motorist_limit, id: /umbrellaUninsuredLimit/)
  div(:umbrella_uninsured_field_name, xpath: './/p-dropdown[contains(@id,"umbrellaUninsuredLimit")]/../preceding-sibling::div')

  #dwelling
  span(:policy_form, id: /policyForm_30_0/)
  span(:deductible, xpath: './/p-dropdown[@id="deductible_30_0"]//div[1]/span')
  #.//app-currency-input/input[@id="currency_coverageA_30_0"]/following-sibling::input
  text_field(:personal_property, id: /currency_coverageC_30_0/)
  text_field(:fair_rental_value_additional_living_expenses, id: /currency_coverageDE_30_0/)
  text_field(:fair_rental_value, id: /currency_coverageD_30_0/)
  text_field(:additional_living_expense, id: /currency_coverageE_30_0/)
  select(:personal_liability, id: /coverageL_30_0/)
  select(:medical_payments_to_others, id: /coverageM_30_0/)
  span(:policy_change_reason_message, xpath: './/div[contains(@class,"p-d-flex reason-padding")]//span')
  span(:eff_date_of_change_text, text: 'Effective Date of Change')
  div(:eff_date_of_change, xpath: './/span[text()="Effective Date of Change"]/../following-sibling::div')
end

class CQMSection < BaseSection
  button(:apply_to_quote, xpath: '//button[@id = "applyToQuote"]')
  span(:add_umbrella, xpath: './/span[@class="p-button-label"  and text()="Add Umbrella"]')
  span(:liability_limit, id: /liabilityLimit/)
  span(:enhanced_coverage, id: /enhancedCoverage/)
  span(:package_discount, id: /packageDiscount/)
  span(:effective_date, id: /effectiveDate/)
  span(:comparable_quote_policy_name, id: /compQuotePolicyName/)
  span(:quote_premium, id: /quotePremium/)
  sections(:vehicles, QOPVehicleSection, xpath: '.', item: { xpath: './/*[contains(@id,"vehicle")]/parent::div/parent::div', how: :divs })

  #Umbrella
  span(:umbrella_liability_limit, id: /umbrellaLiability/)
  span(:umbrella_uninsured_motorist_limit, id: /umbrellaUninsuredLimit/)

  #dwelling
  span(:policy_form, id: /policyForm_20_0/)
  span(:deductible, xpath: './/span[@id="deductible_20_0"]')
  span(:other_structures, xpath: './/span[@id="coverageA_20_0"]/span')
  span(:personal_property, id: /coverageC_20_0/)
  span(:fair_rental_value_additional_living_expenses, xpath: './/span[@id="coverageDE_20_0"]/span')
  span(:fair_rental_value, id: /coverageD_20_0/)
  #text_field(:additional_living_expense, id: /currency_coverageE_30_0/)
  select(:personal_liability, id: /coverageL_20_0/)
  select(:medical_payments_to_others, id: /coverageM_20_0/)

  %i[liability_limit enhanced_coverage].each do |which|
    define_method("#{which}_difference?") do
      _difference_highlighter?(which)
    end
  end

  %i[umbrella_liability_limit umbrella_uninsured_motorist_limit].each do |which|
    define_method("#{which}_difference?") do
      _difference_highlighter?(which)
    end
  end

  def _difference_highlighter?(which)
    send("#{which}_element").mark.present?
  end

end

class QuoteManagementPage < PolicyManagementPage

  def displayed?
    browser.url.include?('PolicyAdminWeb/PL/quotes')
  end

  li(:client_name, xpath: '//ul[@class="client-details"]//li', index: 0)
  li(:client_address, xpath: '//ul[@class="client-details"]//li', index: 1)
  span(:quote_total_premium, id: 'quotePremium')
  span(:quote_paid_in_full, id: 'quotePaidInFull')
  span(:comparable_total_premium, id: 'compQuotePremium')
  span(:comparable_quote_paid_in_full, id: 'compQuotePaidInFull')
  button(:recalculate, text: 'Recalculate')
  button(:save_changes, text: 'Save Changes')
  link(:discard_changes, text: 'Discard Changes')
  button(:begin_issuance, text: 'Begin Application')
  button(:preparing_application, xpath: '//button[span[contains(text(), "Preparing Application")]]')
  sections(:quote_section, QMSection, xpath: './/app-quote-management/div', item: { xpath: './/p-panel[.//p-header]/../parent::div[contains(@class,"bg-white")]' })
  sections(:comparable_quote_section, CQMSection, xpath: './/app-quote-management/div', item: { class: /quote-body-border/, xpath: './/div[.//p-panel and .//span[contains(@id,"compQuotePolicyName")]]' })
  button(:submit_change, xpath: '//p-button[@id="submitChange"]/button')
  section(:policy_change_quote_section, QMSection, xpath: './/app-quote-management/div//p-panel[.//p-header]/../parent::div[contains(@class,"bg-white quote-inside-border")]')
  section(:policy_change_summary_section, QMSection, xpath: './/app-quote-management/div//p-panel[.//p-header]/../parent::div[contains(@class,"bg-gray-100 quote-inside-border")]')

  link(:quote_options_tab, xpath: '//div[contains(text(),"Quote Options")]/..')
  link(:underwriting_questions_tab, xpath: '//span[contains(text(),"Underwriting Questions")]/..')
  link(:rating_details_tab, xpath: '//span[contains(text(),"Rating Details")]/..')
  link(:proposals_tab, xpath: '//span[contains(text(),"Proposals")]/..')

  link(:view_underwriting_referrals, id: 'viewUnderwritingReferrals')
  div(:uw_referrals_error_message, class: /p-message-error/)

  # the below xpath is not ideal but for some reason nesting within enough divs is causing the xpath search to terminate
  button(:issue, xpath: './/div[contains(@class, "header-section")]/div/div/div/div//p-button[@id="issueQuotes"]/button')

  button(:submit, xpath: './/p-button[@id="Submit"]/button')
  checkbox(:product_checkbox, xpath: './/p-checkbox[contains(@id, "product_0")]/div/div[2]')
  button(:go_to_account_summary, xpath: './/p-button[@id="Go To Account Summary"]/button')
  button(:ellipses_icon, xpath: './/p-button[@icon="pi pi-ellipsis-h"]/button')
  link(:save_quote, xpath: '//span[text()="Save Quote"]/..')

  def begin_issuance_on_all
    wait_for_ajax
    check_all_quoted
    scroll.to :top
    begin_issuance
    msg = "Timed out waiting to enable the Preparing Application"
    Watir::Wait.while(timeout: 120) { preparing_application_element.present? }
    wait_for_ajax
    issues_to_resolve_modal.close if issues_to_resolve_modal?
    thank_you_modal.close if thank_you_modal.present?
  end

  def submit_changes
    wait_for_ajax
    check_all_quoted
    scroll.to :top
    # the begin issuance is sometimes clicked too fast after selecting check box, adding a slight delay
    sleep(0.3)
    submit_change
    wait_for_ajax
  end

  def products_has_items
    quote_section.count
  end

  def check_all(statuses_to_check = [])
    quote_section.each do |product|
      if statuses_to_check.empty?
        product.quote_checkbox_element.check
      else
        statuses_to_check.each do |status|
          if product.status == status
            product.quote_checkbox_element.check
            break
          end
        end
      end
    end
  end

  def check_all_quoted
    quote_section.each do |product|
      if product.quote_checkbox?
        product.quote_checkbox_element.check if product.status == "Quoted" || product.status == "Pending Approval" || product.status == "Incomplete Quote" || product.status == "Incomplete Issue" || product.status == "Application" || product.status == "CHANGE PENDING"
      end
    end
  end

  def check_first_quoted
    checked = false
    quote_section.each do |product|
      if product.status == "Quoted"
        if !checked
          product.quote_checkbox_element.check
          checked = true
        else
          product.quote_checkbox_element.uncheck
        end
      end
    end
  end

  def resolve_issues_to_resolve
    wait_for_ajax
    check_all_quoted
    scroll.to :top
    sleep(0.3)
    begin_issuance

    msg = "Timed out waiting to enable the Preparing Application"
    Watir::Wait.while(timeout: 120) { preparing_application_element.present? }
    wait_for_ajax
    # msg = "Timed out waiting on BEGIN ISSUANCE\n\n"
    # Watir::Wait.until(timeout: 40, message: msg) { thank_you_modal.present? }
    issues_to_resolve_modal.close if issues_to_resolve_modal?
    thank_you_modal.close if thank_you_modal.present?
  end

  def review_and_submit_policy
    wait_for_ajax
    check_all_quoted
    scroll.to :top
    # the begin issuance is sometimes clicked too fast after selecting check box, adding a slight delay
    sleep(0.3)
    submit
    wait_for_ajax
  end
end
