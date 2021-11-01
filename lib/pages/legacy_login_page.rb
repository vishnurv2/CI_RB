# frozen_string_literal: true

class LegacyLoginPage < BasePage
  page_url "https://saturn.central-insurance.com/WebLogin/Login.aspx"

  # ------ Everything on this page has been VERIFIED ------------------------------------- #

  text_field(:user_id, name: 'txtbxUserId')
  text_field(:password, name: 'txtbxPass')
  button(:login, name: 'cmdLogin')
  ul(:form_errors, xpath: '//*[@id="vsFormErrors"]/ul')
  div(:error_div, id: 'divErrorMessage')

  def user_id_dev=(uid)
    user_id_element.set(uid) if Nenv.test_env.downcase == 'dev'
  end

  def user_id_test=(uid)
    user_id_element.set(uid) if Nenv.test_env.downcase == 'test'
  end

  def user_id_uat=(uid)
    user_id_element.set(uid) if Nenv.test_env.downcase == 'uat'
  end

  def password_dev=(uid)
    password_element.set(uid) if Nenv.test_env.downcase == 'dev'
  end

  def password_test=(uid)
    password_element.set(uid) if Nenv.test_env.downcase == 'test'
  end

  def password_uat=(uid)
    password_element.set(uid) if Nenv.test_env.downcase == 'uat'
  end

  def ready?
    user_id? && password? && login?
  end

  def populate
    super
    leave_page_using(:login, false)
  end

  def errors?
    form_errors? || error_div?
  end

  def wait_for_ajax
    # The login page does not use jquery so turn this into a no op
  end

  def self.post(client, data = nil)
    data ||= data_for_this_page
    client.post_login_page(data)
  end
end
