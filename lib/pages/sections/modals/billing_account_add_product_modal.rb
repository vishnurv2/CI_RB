# frozen_string_literal: true

class BillingAccountAddProductModal < BaseModal
  select(:billing_account, name: 'billingAccountNumber')
  select(:payor, name: 'payor', hooks: WFA_HOOKS)
  #select(:billing_address, ng_reflect_name: /selectedAddress/, hooks: WFA_HOOKS)
  select(:billing_address, xpath: './/p-dropdown[.//input[contains(@id, "addresslist_0")]]', hooks: WFA_HOOKS)
  div(:apply_billing_acc_to_products, text: 'Apply Billing Account to Selected Products')
  section(:address_details, AddressDetailsSection, id: /addressFields/)
  text_field(:new_first_name, id: 'givenName')
  text_field(:new_last_name, id: 'surname')

  # new address
  text_field(:new_address_line1, id: 'addr1_0')
  text_field(:new_city, id: 'city_0')
  select(:new_state, xpath: './/div[text()="State"]//following-sibling::p-dropdown')
  text_field(:new_zip, name: /postalCode/)
  text_field(:new_county, id: /county/)

  radio(:bill_plan_annual, xpath: './/p-radiobutton[.//input[contains(@id, "billPlan+0")]]', hooks: WFA_HOOKS)
  radio(:bill_plan_semiannual, xpath: './/p-radiobutton[.//input[contains(@id, "billPlan+1")]]', hooks: WFA_HOOKS)
  radio(:bill_plan_quarterly, xpath: './/p-radiobutton[.//input[contains(@id, "billPlan+2")]]', hooks: WFA_HOOKS)
  radio(:bill_plan_monthly, xpath: './/p-radiobutton[.//input[contains(@id, "billPlan+3")]]', hooks: WFA_HOOKS)

  #radio(:payment_method_eft, id: 'paymentMethod+0', hooks: WFA_HOOKS)
  radio(:payment_method_eft, xpath: './/p-radiobutton[.//input[contains(@id, "paymentMethod+0")]]', hooks: WFA_HOOKS)
  #radio(:payment_method_credit, id: 'paymentMethod+1', hooks: WFA_HOOKS)
  radio(:payment_method_credit, xpath: './/p-radiobutton[.//input[contains(@id, "paymentMethod+1")]]', hooks: WFA_HOOKS)
  #radio(:payment_method_manual, id: 'paymentMethod+2', hooks: WFA_HOOKS)
  radio(:payment_method_manual, xpath: './/p-radiobutton[.//input[contains(@id, "paymentMethod+2")]]', hooks: WFA_HOOKS)

  select(:payment_due_date, name: 'dueDay')
  toggle_switch(:e_billing_toggle, name: 'isEBillingChecked')
  select(:billing_email, name: 'eBillingAddressList')
  text_field(:new_billing_email, id: 'email')

  button(:add_card, xpath: '//p-button[@label="Add Card"]/button')
  button(:add_bank_account, xpath: '//p-button[@label="Add Bank Account"]/button')
  #divs(:no_product_validation, class: 'invalid')

  # New Payor stuff will go below here

  def bill_plan=(text)
    send("bill_plan_#{text}").scroll.to
    send("bill_plan_#{text}").select
  end

  def payment_method=(method)
    send("payment_method_#{method}").scroll.to
    send("payment_method_#{method}").select
  end

  def e_billing=(value)
    if value == true
      e_billing_toggle.click unless e_billing_toggle_element.div.classes.include? 'p-inputswitch-checked'
    else
      e_billing_toggle.click if e_billing_toggle_element.div.classes.include? 'p-inputswitch-checked'
    end
  end

  # in progress
  def field_required_error_elements
    divs(class: 'required', visible: true)
    #count positive?
  end

  def available_payors
    payor.options
  end

  def available_addresses
    billing_address.options
  end

  def expected_payor(type = 'applicant')
    data_used = EDSL::PageObject.fixture_cache['new_personal_account_modal']
    expected_name = "#{data_used['first_name']} #{data_used['middle_name']} #{data_used['last_name']} (#{type})"
    expected_name
  end

  # HACK for pat4963 bug
  def expected_payor_temp
    data_used = EDSL::PageObject.fixture_cache['new_personal_account_modal']
    expected_name = "#{data_used['first_name']} #{data_used['last_name']}"
    expected_name
  end

  def expected_billing_address
    data_used = EDSL::PageObject.fixture_cache['account_entry_page']['applicants'].first['address_details']
    expected_addr = "#{data_used['address_line_1']}, #{data_used['city']}, #{STATE_NAME_TO_ABBR[data_used['state']]} #{data_used['zip_code']}"
    expected_addr
  end

  def field_validation_error_elements
    divs(class: 'invalid', visible: true)
  end

  def validation_messages?
    return true if field_validation_error_elements.count >= 1
  end

  def apply_billing_account_to_selected_products
    wait_for_ajax
    products = apply_billing_acc_to_products_element.parent.children(class: 'productCheckbox')
    products.each do |item|
      item_checkbox = item.div(class: /p-checkbox-box/).classes.include?('p-highlight')
      item_disabled = item.div(class: /p-checkbox-box/).classes.include?('p-state-disabled')  ## NG 11 didnt have a disabled state that i could find.
      if !item_disabled
        if !item_checkbox
          item.div(class: /p-checkbox-box/).click
          wait_for_ajax
        end
      end
    end
  end

  def populate_billing_modal(fixture)
    apply_billing_account_to_selected_products
    self.payor = if fixture.key?('payor')
                   ## This may need fixed to accomidate the uppercase crap from api
                   fixture['payor']
                 else
                   ex = expected_payor.upcase.split(/[()]/)
                   "#{ex.first}(#{ex.last.capitalize})"
                 end
    billing_address.select 1 #expected_billing_address

    populate_with(fixture)
  end


  # ------ Everything below this line is unverified ------------------------------------- #

  toggle_button_checklist(:unassociated_products, id: 'dlsBillingUnassociatedProducts')
  select(:bank_account, id: 'ddlBankAccount')


  text_field(:new_middle_name, id: 'PayorMiddleName')

  span(:recommended_down_payment, name: 'RecommendedDownPaymentPrimaryDiv')
  span(:affiliate_errors, xpath: '//*[@class="col-md-12 alert alert-danger"]')

  button(:save_and_close_button_no_hooks, name: 'SaveAndClose')

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end

  def next_modal
    save_and_close
  end

  def toggle_all_products(value)
    unassociated_products_element.toggles.each { |product| product.set(value) }
    wait_for_ajax
  end

  def set_toggle_by_name(desired_name, bool)
    unassociated_products_element.toggles.each { |product| product.set(bool) if product.text.include?(desired_name) }
  end

  def down_payment_rounded(value)
    value.split(' ').select { |n| n[/\$/] }.first.delete("$").to_f
  end

end
