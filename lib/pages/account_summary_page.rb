# frozen_string_literal: true

class AccountSummaryPage < PolicyManagementPage
  #h4(:account_summary_h4, xpath: '//app-cmi-header/.//h4')
  div(:account_summary_h4, xpath: '//div[contains(@class,"sub-headers")]')

  #button(:actions, id: /(a|A)ctions/)
  button(:action, xpath: '//p-button[contains(@id, "ddlActions")]/button')

  section(:product_list, AccountProductsPanel, xpath: '//app-product-list/.//div', how: :div)
  section(:account_info, AccountGeneralInfoPanel, xpath: '//app-view-general-information/div/div/p-panel/div', how: :div)
  section(:applicants_panel, ApplicantsPanel, xpath: '//app-view-personal-applicant-list/div | //app-view-party-list/div/div/p-panel/div', how: :div)
  section(:account_summary_applicants_panel, ApplicantsPanel, xpath: '//app-account-summary//app-view-applicant-list/div', how: :div)
  section(:property_info_panel, PropertyInfoPanel, xpath: '//app-view-property-info/div | //app-view-property-info/p-panel/div ', how: :div)
  section(:payment_options, PaymentOptionsPanel, xpath: '//app-billing-summary/div| //app-billing-summary/p-panel/div', how: :div)
  section(:basic_search_section, BasicSearchSection, class: 'p-inputgroup dark-hover', how: :div)
  sections(:activity_panel, ActivityPanel, xpath: './/div[@id="MainContentRouterOutlet"]//div[contains(@class,"activity-tab")]', item: { xpath: './/div[contains(@class,"activity-tab-header-text")]/../..', how: :elements })
  section(:billing_summary_panel, BillingSummaryPanel, xpath: '//app-billing-summary/div/div/p-panel/div', how: :div)

  #tabs on account summary page
  link(:activity_tab, xpath: '//span[contains(text(),"Activity")]/..')
  link(:notes_tab, xpath: '//span[contains(text(),"Notes")]/..')
  link(:emails_tab, xpath: '//span[contains(text(),"Emails")]/..')
  link(:calls_tab, xpath: '//span[contains(text(),"Calls")]/..')
  link(:tasks_tab, xpath: '//span[contains(text(),"Tasks")]/..')
  link(:summary_tab, xpath: '//span[contains(text(),"Summary")]/..')
  button(:log_activity, xpath: '//p-button[@id="logActivity"]/button')
  text_field(:search_bar_text, xpath: '//div[@id="contentSearchBar"]/input')
  button(:search, xpath: '//p-button[@label="Search"]/button')
  div(:description_displayed, class: /searchable/)

  i(:filter_account_product, xpath: '//app-filters//span[contains(text()," Account/Product(s) ")]/i')
  i(:filter_type, xpath: './/app-filters//span[contains(text()," Type ")]')
  i(:filter_user, xpath: './/app-filters//span[contains(text()," User ")]')
  button(:clear_filter, xapth: './/button[@label="Clear Filter"]')
  span(:user_me, xpath: '//div[@class="overlay-panel"]//span[contains(text()," (me)")]')

  span(:activity_type_text, class: 'bold-text searchable')
  i(:priority_restrictive_image, xpath: '//i[@class="text-gold fas fa-exclamation-triangle"]')
  link(:view_quote, xpath: '//span[text()="View Quote"]/..')

  # moved to policy management page section(:add_applicant_modal, AddApplicantModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Account Applicant - ")]]')

  #WATERCRAFT
  section(:watercraft_account_info, AccountGeneralInfoPanel, xpath: '//app-view-info//p-panel/div', how: :div)

  link(:add_party_menu, text: 'Add a Party', default_method: :click!)
  section(:add_applicant_modal, AddApplicantModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Applicant") or contains(text(), "New Party") or contains(@class, "modal-title-medium")]]')
  section(:add_party_modal, AddPartyModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "Add Party")]]')

  span(:search_result_suggested, xpath: '//span[@class="search-results ng-star-inserted"]')

  def add_policy_change_effective(effective_date)
    product_list.products.first.three_dots
    product_list.products.first.create_policy_change
    modal = add_policy_change_modal
    modal.date = 'Specify Date'
    modal.specific_date = effective_date
    # modal.specific_date_text = effective_date
    modal.description_element.click
    modal.description = "Policy Change Effective: #{effective_date}"
    modal.date.span(text: 'Specify Date').click # trying something here
    sleep(0.6)
    modal.save_and_continue_button
  end

  def displayed?
    browser.url.include?('PolicyAdminWeb/PL/account')
  end

  def _ready?
    wait_for_ajax
    return false unless account_summary_h4?

    sleep(3) if Nenv.browser_width.to_i < 993
    true
  end

  def ready?
    wait_for_ajax
  end

  def actions(arg)
    action
    link(text: "#{arg}").click
  end

  def add_party_details_from_Thankyou_Modal(party_type, role)
    # add_applicant_button_element.scroll.to :center
    #wait_for_ajax
    #add_applicant_button
    #Watir::Wait.until(timeout: 30) { menu?}

    add_party_menu if add_party_menu?
    Watir::Wait.until(timeout: 30) { add_party_modal? }
    add_party_modal.select_add_party_type = party_type
    add_party_modal.role = role
    add_party_modal.next
    Watir::Wait.until(timeout: 30) { add_applicant_modal? }
    # wait_for_ajax
    # parent_container.raise_page_errors 'attempting to add an applicant from the applicants panel'
  end

  def add_party_details_from_Message_Card(party_type, role)
    # add_applicant_button_element.scroll.to :center
    #wait_for_ajax
    #add_applicant_button
    #Watir::Wait.until(timeout: 30) { menu?}
    #add_party_menu if add_party_menu?
    #Watir::Wait.until(timeout: 30) { add_party_modal? }
    add_party_modal.select_add_party_type = party_type
    add_party_modal.role = role
    add_party_modal.next
    Watir::Wait.until(timeout: 30) { add_applicant_modal? }
    # wait_for_ajax
    # parent_container.raise_page_errors 'attempting to add an applicant from the applicants panel'
  end

  # ------ Everything below this line is unverified ------------------------------------- #

  section(:account_producers, AccountProducersPanel, id: 'accountProducers')
  section(:claims_summary, ClaimsSummaryPanel, id: 'claimsInformation')

  span(:issue_confirmation_alert, class: 'alert-title', text: 'Issue Confirmation')
  span(:policy_change_confirmation_alert, class: 'alert-title', text: 'Policy Change Confirmation')
end
