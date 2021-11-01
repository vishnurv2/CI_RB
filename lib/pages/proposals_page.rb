# frozen_string_literal: true

class Products < ::BaseSection
  checkbox(:quote_checkbox, id: /quoteChbox/)
end

class Proposals < ::BaseSection
  td(:type, data_label: /Type/)
  td(:name, data_label: /Name/)
  td(:prepared_by, data_label: /Prepared By/)
  td(:last_modified, data_label: /Last Modified/)
  checkbox(:proposal_chkbox, xpath: './/tbody//p-checkbox')
end

class NewProposalModal < BaseModal
  select(:prepared_for, id: /preparedForContacts/)
  select(:prepared_by, id: /preparedByContacts/)
  checkbox(:select_products, xpath: './/thead//p-checkbox')
  checkbox(:select_umbrella_product, xpath: '//td//b[contains(text(),"Umbrella")]/ancestor::tr//p-checkbox')
  checkbox(:select_home_product, xpath: '//td//b[contains(text(),"Homeowners")]/ancestor::tr//p-checkbox')
  checkbox(:select_auto_product, xpath: '//td//b[contains(text(),"Auto")]/ancestor::tr//p-checkbox')
  checkbox(:recommended_quote, xpath: './/p-checkbox[@id="recommendedChkbox"]')
  checkbox(:premium_summary, xpath: './/p-checkbox[@id="proposalChbox_premiumSummary"]')
  span(:recommended_umbrella_summary, xpath: './/b[contains(text(),"Summary of your recommended quote from Central")]/following::div//span[contains(text(),"Umbrella")]')
  span(:recommended_auto_summary, xpath: './/b[contains(text(),"Summary of your recommended quote from Central")]/following::div//span[contains(text(),"Auto")]')
  span(:recommended_home_summary, xpath: './/b[contains(text(),"Summary of your recommended quote from Central")]/following::div//span[contains(text(),"Home")]')
  data_grid(:products, Products)
  button(:insert_file, xpath: './/p-button[@id="insertFile"]/button')
  button(:save, xpath: './/p-button[@icon="pi pi-chevron-down"]/button')
  link(:save_and_close, xpath: '//span[contains(text(),"Save and close")]/..')
end

class ProposalsPage < PolicyManagementPage
  button(:create_proposal, xpath: '//p-button[contains(@label, "Create Proposal")]/button')

  data_grid(:proposals, Proposals)

  section(:new_proposal_modal, NewProposalModal, xpath: '//div[@role="dialog" and .//div/span[contains(text(), "New Proposal")]]')
end
