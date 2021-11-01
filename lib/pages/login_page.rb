# frozen_string_literal: true

class LoginPage < BasePage
  page_url "#{Nenv.base_url}/WebLogin/Login.aspx"

  # ------ Everything on this page has been VERIFIED ------------------------------------- #

  text_field(:user_id, id: 'txtbxUserId')
  text_field(:password, id: 'txtbxPass')
  # button(:login, text: 'Login', hooks: WFA_HOOKS)
  text_field(:login, xpath: '//input[@type="submit"]', default_method: :click!)
  div(:user_name_error, text: 'User ID is required')
  div(:password_error, text: 'Password is required')
  div(:toast_container, id: 'toast-container')
  div(:failed_login, id: 'divErrorMessage')
  label(:security_questions_user, xpath: '//label[@for="rbSecurityQuestion"]')
  label(:validation_code_user, xpath: '//label[@for="rbValidationCode"]')
  text_field(:security_answer, id: 'txtSecurityChallengeAnswer')

  # deprecated
  #ul(:form_errors, xpath: '//*[@id="vsFormErrors"]/ul')
  #div(:error_div, id: 'divErrorMessage')

  # def login
  #   element(xpath: '//input[@type = "submit"]').click
  #   sleep(0.5)
  # end

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
    login
    check_security_qns
    # leave_page_using(:login, false)
  end

  def populate_login(fixture_file)
    #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
    RubyExcelHelper.safe_load_fixture_file(fixture_file)
    data_from_fixture = data_for('login_page')
    populate_with(data_from_fixture)
    login
    check_security_qns
  end

  def errors?
    user_name_error? || password_error?
  end

  def self.post(client, data = nil)
    data ||= data_for_this_page
    client.post_login_page(data)
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end

  def check_security_qns
    if security_questions_user_element.present?
      security_questions_user_element.click
      security_answer_element.set('testing')
      element(xpath: '//input[@type = "submit"]').click
    end
  end

end
