# frozen_string_literal: true

class AutoGeneralInfoPanel < BasePanel
  button(:modify)

  div(:state, xpath: './/div[not(label) and ../div[label/strong[contains(text(), "tate")]]]')
  div(:effective_date, xpath: './/strong[contains(text(),"Effective Date")]//following::div')
  div(:expiration_date, xpath: './/strong[contains(text(),"Expiration Date")]//following::div')
  div(:address, xpath: './/strong[contains(text(),"Policy Mailing Address")]//following::div')
  div(:named_non_owner, xpath: './/div[not(label) and ../div[label/strong[contains(text(), "amed")]]]')

  #This below is working, the above xpaths I have not verified
  div(:affiliate_discount, xpath: '//div/label/strong[contains(text(), "Affiliate")]/following::div')
end
