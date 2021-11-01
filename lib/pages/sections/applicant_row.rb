# frozen_string_literal: true

class ApplicantRow < EDSL::PageObject::Section
  span(:delete_button, class: /fa-trash/, default_method: :click, hooks: WFA_HOOKS)
  span(:edit, class: /fa-pencil/, default_method: :click)

  td(:name, data_label: /Name/)
  b(:name_text, xpath: '//td[@data-label="Name"]//b')
  td(:address, data_label: /Primary Address/)
  td(:email, data_label: 'E-mail')
  td(:phone, data_label: /Phone/)
  td(:contact, data_label: /Role/)
  td(:policy_contact, data_label: /Contact/)
  td(:roles, data_label: /Roles/)

  td(:remove_confirm_message, xpath: '../tr/td[@class = "deleteConfirmationRow"]')

  button(:delete_yes, xpath: '../tr/td[@class = "deleteConfirmationRow"]/.//button[contains(@class, "ui-button-default")]', hooks: WFA_HOOKS)
  button(:delete_no, xpath: '../tr/td[@class = "deleteConfirmationRow"]/.//button[contains(@class, "ui-button-danger")]', hooks: WFA_HOOKS)

  div(:delete_confirmation_message, xpath: './/div[contains(@class,"deleteConfirmationRow")]')

  def is_contact?
    contact.strip.casecmp('yes').zero?
  end

  def name_stripped
    name.split("\n").first
  end

  def address_stripped
    name.split("\n").last
  end

  # ------ Everything below this line is unverified ------------------------------------- #

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end

  def safe_delete
    delete
    Watir::Wait.while { present? }
  rescue Exception => ex
    # Swallow this
    STDOUT.puts "#{ex.message} raised while removing applicant"
  end

  def delete
    delete_button
    delete_yes
    clear_all_toasts
  end
end
