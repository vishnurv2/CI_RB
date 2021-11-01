class PLRatingHomeGenInfo < BasePage
  #page_url "https://ratinguat.vertafore.com/UserInterface/USA/PA/GeneralEdit.aspx?FromCoSelect=True"

  link(:today_eff_date, id: 'lBtnTodayEffective')
  select_plrating(:credit_check, id: 'CmbCreditCheck')
  select_plrating(:prior_insurance, id: 'cmbPriorCompany')
  select_plrating(:gender, id: 'cmbSex')
  select_plrating(:industry, id: 'cmbIndustry')
  select_plrating(:occupation, id: 'cmbOccupation')
  text_field(:next_button, id: 'cmdOK')
end