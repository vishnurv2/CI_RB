class PLRatingCompanySelection < BasePage
  #page_url "https://ratinguat.vertafore.com/UserInterface/USA/CommonLOB/CompanySelection.aspx?FromCoSelect=True"

  text_field(:company_select_checkbox, xpath: './/input[@id="rptrCompanies_ctl00_chkCompany"]')
  text_field(:next_button, xpath: './/input[@id="cmdOK"]')

end