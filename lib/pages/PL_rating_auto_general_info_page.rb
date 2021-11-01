class PLRatingAutoGenInfo < BasePage
  #page_url "https://ratinguat.vertafore.com/UserInterface/USA/PA/GeneralEdit.aspx?FromCoSelect=True"

  text_field(:eff_date, xpath: './/input[@id="rdiEffectiveDate"]')
  select_plrating(:credit_check, id: 'cmbCreditAuth')
  select_plrating(:billing_plan, id: 'cmbBillingPlan')
  select_plrating(:payment_option, id: 'cmbPaymentOption')
  select_plrating(:prior_insurance, id: 'cmbPriorType')
  select_plrating(:no_insurance_detail, id: 'cmbNoNeedDetails')
  text_field(:next_button, xpath: './/input[@id="cmdNext"]')

end