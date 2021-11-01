class PLRatingHomePropertyInfo < BasePage
  #page_url "https://ratinguat.vertafore.com/UserInterface/USA/PA/GeneralEdit.aspx?FromCoSelect=True"
  text_field(:year_built, id: 'rniYearBuilt')
  select_plrating(:construction, id: 'cmbConstruction')
  text_field(:no_of_families, id: 'rniNumberOfFamilies')
  text_field(:purchase_date, id: 'rdiPurchasedDate')
  select_plrating(:roof_type, id: 'cmbRoofType')
end