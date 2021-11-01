# frozen_string_literal: true
class ProductsDistribution < BaseSection
  span(:product_icon, class: /product-icon/)
  select_button_set(:distribution_type, id: /distributionType/)
  select(:send_to, id: /email/)
  select_button_set(:new_product_send_to, id: /newProductSendTo/)
  select_button_set(:renewals_send_to, id: /renewalsSendTo/)
end

class BillingInformationRow < BaseSection
  td(:actions, index: 4)
  td(:billing_account, index: 1)
  td(:product, index: 0)
  td(:bill_plan, index: 3)
  td(:payment_method, index: 2)
end

class ESignInformationRow < BaseSection
  checkbox(:e_sign)
  select(:email, id: /email/)
end

class IssWizReviewSection < BaseSection
end

class IssWizBillingSection < BaseSection
  button(:add_billing_account, xpath: './/p-button[@id="addBilling"]/button')
  button(:edit_billing_account, xpath: './/p-button[contains(@icon, "pencil")]/button')
  data_grid(:billing_accounts, BillingInformationRow)

  def navigate_defaults(billing_modal)
    return if edit_billing_account_element.present?
    Watir::Wait.until { add_billing_account_element.present? }
    add_billing_account
    Watir::Wait.until { billing_modal.present? }
    billing_modal.apply_billing_account_to_selected_products
    ex = billing_modal.expected_payor.upcase.split(/[()]/)
    billing_modal.payor = "#{ex.first}(#{ex.last.capitalize})"
    # billing_modal.payor.set(1)
    billing_modal.bill_plan_monthly.click unless billing_modal.bill_plan_monthly_element.div(class: /p-radiobutton-checked/).present?
    billing_modal.payment_method_manual.click
    billing_modal.e_billing = false
    billing_modal.save_and_close_button
    Watir::Wait.while { billing_modal.present? }
    sleep(5)
  end

  def navigate_annual_payment(billing_modal)
    return if edit_billing_account_element.present?
    Watir::Wait.until { add_billing_account_element.present? }
    add_billing_account
    Watir::Wait.until { billing_modal.present? }
    billing_modal.apply_billing_account_to_selected_products
    ex = billing_modal.expected_payor.upcase.split(/[()]/)
    billing_modal.payor = "#{ex.first}(#{ex.last.downcase})"
    # billing_modal.payor.set(1)
    billing_modal.bill_plan_annual.click
    billing_modal.payment_method_manual.click
    billing_modal.e_billing = false
    billing_modal.save_and_close_button
    Watir::Wait.while { billing_modal.present? }
    sleep(5)
  end
end

class IssWizDistributionSection < BaseSection
  select(:email)
  checkbox(:set_distribution_by_product, id: /distributionByProductChbx/)
  data_grid(:products_distribution, ProductsDistribution)
  span(:terms_and_conditions, text: /Terms and Condition through myCentral/)

  def navigate_defaults
    if products_distribution_element.present?
      products_distribution.each do |row|
        row.send_to = 1
      end
    end
    if email_element.present?
      email_element.set(1) if !products_distribution_element.present?
    end
  end
end

class IssWizSignationRequestSection < BaseSection
  sections(:e_sign_rows, ESignInformationRow, class: "tbl-prod-docs", item: { xpath: './/div[contains(@class, "p-grid") and contains(@class, "ng-star-inserted")]', how: :divs})

  def navigate_defaults
    e_sign_rows.each do |row|
      row_disabled = row.e_sign_element.div(class: /p-checkbox-box/).classes.include?('p-state-disabled')
      if !row_disabled
        if row.email?
          row.email_element.set(1)
        end
      end
    end

    # check if eligible?  need to check if the element is eligible first, maybe check if disabled?
    #  e_sign_grid.first.e_sign_element.child.attribute('class').include?('ui-state-disabled') ?? something like this?
    # if e_sign_grid.first.email?
    #   e_sign_grid.first.email_element.set(1)
    # end

  end
end

class IssWizSelectProductSection < BaseSection

  span(:total_account_premium, xpath: './/span[text()="Total Account Premium"]/../following-sibling::td[2]/span')
  td(:home_attached_products_spp, xpath: '//th[contains(text(),"Attached Products")]/../../..//tbody//td[contains(text(),"Scheduled Property")]')
  td(:home_attached_products_watercraft, xpath: '//th[contains(text(),"Attached Products")]/../../..//tbody//td[contains(text(),"Watercraft")]')
  span(:product_collapse, xpath: './/span[contains(@class,"pi-chevron-down")]')
  span(:product_expand, xpath: './/span[contains(@class,"pi-chevron-right")]')

  def products_to_issue_count
    tbody.trs(xpath: './/tr[.//p-checkbox]').count
  end

  def navigate_defaults
    tbody.trs(xpath: './/tr[.//p-checkbox]').each do |row|
      CentralElements::CheckBox.new(row.element(xpath: './/p-checkbox'), row).set(true)
    end
  end

  def populate(selections)
    tbody.trs(xpath: './/tr[.//p-checkbox]').each_with_index do |row, i|
      CentralElements::CheckBox.new(row.element(xpath: './/p-checkbox'), row).set(selections[i])
    end
  end
end

class IssueWizardModal < BaseModal
  button(:go_to_account_summary, xpath: './/p-button[@id="Go To Account Summary"]/button', hooks: WFA_HOOKS)
  button(:next_button, xpath: './/p-button[@id="Next"]/button', hooks: WFA_HOOKS)
  button(:submit_button, xpath: './/p-button[@id="Submit"]/button', hooks: WFA_HOOKS)
  button(:submit_btn, xpath: './/p-button[@id="Submit"]/button')
  section(:select_product_section, IssWizSelectProductSection, xpath: './/form[.//div[contains(text(), "Select Product")]]', how: :element)
  section(:distribution_section, IssWizDistributionSection, xpath: './/form[.//div[contains(text(), "Distribution")]]', how: :element)
  section(:billing_section, IssWizBillingSection, xpath: './/app-billing[.//div[contains(text(), "Billing")]]', how: :element)
  section(:review_section, IssWizReviewSection, xpath: './/form[.//div[contains(text(), "Review and Submit")]]', how: :element)
  section(:signature_request_section, IssWizSignationRequestSection, xpath: './/form[.//span[contains(text(), "Signature Requests")]]', how: :element)
  checkbox(:all_prod_selection, xpath: './/p-checkbox[@name="allChk"]')
  select(:email_option_1, xpath: '//p-dropdown[@id="email0"]')
  select(:email_option_2, xpath: '//p-dropdown[@id="email1"]')

  def navigate(billing_modal)
    section_to_navigate = get_section
    previous_section = nil
    billing_filled_out_counter = 0 # some weird loop here
    while present? && section_to_navigate != previous_section && !section_to_navigate.nil?
      # binding.pry if distribution_section.present?

      if billing_section.present?
        #put this in here to fix a loop problem. We only want to fill out billing once
        if billing_filled_out_counter == 0
          section_to_navigate.navigate_defaults(billing_modal)
        end
        billing_filled_out_counter += 1
      else
        section_to_navigate.navigate_defaults
      end
      wait_for_ajax
      next_button
      Watir::Wait.while(timeout: 120) { section_to_navigate.present? }
      # Watir::Wait.while(message: "Timed Out After 30 Seconds Waiting for #{section_to_navigate.class.to_s} to Disappear After Clicking \"Next\" Button") { section_to_navigate.present? }
      previous_section = section_to_navigate
      section_to_navigate = get_section
    end
    submit_btn_element.click
    Watir::Wait.while(timeout: 120) { submit_button_element.present? }
    # Watir::Wait.while(message: "Timed Out After 30 Seconds Waiting for the Submit Button to Appear") { submit_button_element.present? }
    go_to_account_summary
    go_to_account_summary if go_to_account_summary?
  end

  def navigate_annual(billing_modal)
    section_to_navigate = get_section
    previous_section = nil
    billing_filled_out_counter = 0 # some weird loop here
    while present? && section_to_navigate != previous_section && !section_to_navigate.nil?
      #binding.pry if signature_request_section.present?

      if billing_section.present?
        #put this in here to fix a loop problem. We only want to fill out billing once
        if billing_filled_out_counter == 0
          section_to_navigate.navigate_annual_payment(billing_modal)
        end
        billing_filled_out_counter += 1
      else
        section_to_navigate.navigate_defaults
      end
      wait_for_ajax
      next_button
      Watir::Wait.while { section_to_navigate.present? }
      previous_section = section_to_navigate
      section_to_navigate = get_section
    end
    submit_button
    Watir::Wait.while { submit_button_element.present? }
    go_to_account_summary
  end

  def get_section
    return nil if review_section.present?
    return select_product_section if select_product_section.present?
    return distribution_section if distribution_section.present?
    return billing_section if billing_section.present?
    return signature_request_section if signature_request_section.present?
    return nil
  end
end

