class PLRatingLoginPage < BasePage
  page_url "https://ratinguat.vertafore.com/UserInterface/main/login.aspx"

  text_field(:account_id, id: 'txtAccountID')
  text_field(:user_id, id: 'txtUsername')
  text_field(:password, id: 'txtPassword')
  button(:login, xpath: './/input[@id="cmdOk"]')
  button(:accept_button, xpath: './/input[@id="cmdIAccept"]')


  def ready?
    account_id? && user_id? && password? && login?
  end

  def populate
    super
    leave_page_using(:login, false)
  end
end