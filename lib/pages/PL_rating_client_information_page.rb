class PLRatingClientInformationPage < BasePage
  page_url "https://ratinguat.vertafore.com/UserInterface/Main/ClientEdit.aspx"
  text_field(:first_name, id: 'txtFirstName')
  text_field(:last_name, id: 'txtLastName')
  text_field(:dob, id: 'rdiDateofBirth')
  text_field(:ssn, name: 'rmiSocialSecurity')
  select_plrating(:marital_status, id: 'cmbMaritalStatus')
  text_field(:address_line_1, id: 'txtCurrentAddress1')
  text_field(:zip_code, id: 'rmiCurrentZipCode')
  text_field(:current_city, id: 'txtCurrentCity')
  select_plrating(:residence_type, id: 'cmbResType')
  select_plrating(:time_at_address, id: 'cmbCurrentYear')
  text_field(:home_phone, id: 'rmiHomePhone')
  text_field(:cell_phone, id: 'rmiMobilePhone')
  text_field(:work_phone, id: 'rmiWorkPhone')
  link(:save_button, id: 'btnSave')
  link(:new_auto_quote, id: 'btnNewAuto')
  link(:new_home_quote, id: 'btnNewHome')


end