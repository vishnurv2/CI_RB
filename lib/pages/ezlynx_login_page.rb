class EzlynxLoginPage < BasePage
  page_url "https://app.vtpezlynx.com/ezlynxweb/login.aspx"

  text_field(:user_id, id: 'txtUserName')
  text_field(:password, id: 'txtPassword')
  button(:login, id: 'btnLogin')

  def ready?
    user_id? && password? && login?
  end

  def populate
    super
    leave_page_using(:login, false)
  end
end