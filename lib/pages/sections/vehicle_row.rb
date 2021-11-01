# frozen_string_literal: true

class VehicleRow < EDSL::PageObject::Section

  span(:edit, class: /fa-pencil/, default_method: :click, hooks: WFA_HOOKS)
  span(:delete_button, class: /fa-trash/, default_method: :click, hooks: WFA_HOOKS)
  td(:remove_confirm_message, xpath: '../tr/td[@class = "alert-danger"]')
  #link(:delete_yes, xpath: '../tr/td[@class = "alert-danger"]/a[contains(@class, "delete-row")]', hooks: WFA_HOOKS)
  #span(:delete_no, xpath: '../tr/td[@class = "alert-danger"]/span[contains(@class, "cancel-row")]', default_method: :click, hooks: WFA_HOOKS)

  span(:delete_yes, xpath: '//span[contains(text(), "Delete")]', default_method: :click, hooks: WFA_HOOKS)
  button(:delete_no, xpath: '../tr/td[@class = "deleteConfirmationRow"]/.//button[contains(@class, "btn-danger")]', hooks: WFA_HOOKS)

  #td(:year, data_label: /Year/)
  #td(:make, data_label: /Make/)
  #td(:model, data_label: /Model/)
  #td(:vin, data_label: /Vin/)
  td(:vehicle, data_label: /Vehicle/)
  td(:liability, data_label: /Liability/)
  td(:comp_coll, data_label: /Comp\/Coll/)
  td(:class_code, data_label: /Class Code/)

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end

  def safe_delete
    delete
  rescue Exception => ex
    # Swallow this
    STDOUT.puts "#{ex.message} raised while removing vehicle"
  end

  def delete
    delete_button
    delete_yes
    wait_for_ajax
    clear_all_toasts
  end
end

class OtherVehicleRow < EDSL::PageObject::Section
  #span(:edit, title: 'Edit Vehicle', default_method: :click, hooks: WFA_HOOKS)
  #link(:edit, class: 'OtherVehicleTableEditLink', hooks: WFA_HOOKS)
  span(:edit, class: /fas fa-pencil/, default_method: :click)
  span(:delete_button, class: /fal fa-trash/, default_method: :click, hooks: WFA_HOOKS)
  div(:remove_confirm_message, xpath: './td/div[contains(@class,"deleteConfirmationRow")]')
  button(:delete_yes, xpath: './td//p-button[@label="Delete"]/button', hooks: WFA_HOOKS)
  button(:delete_no, xpath: './td//p-button[@label="Cancel"]/button', default_method: :click, hooks: WFA_HOOKS)

  td(:year, data_label: /Year/)
  td(:make, data_label: /Make/)
  td(:model, data_label: /Model/)
  td(:id, data_label: /Identification Number/)
  td(:liability, data_label: /Liability/)
  td(:comp_coll, data_label: /Comp\/Coll/)
  td(:type, data_label: /Type/)

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end

  def safe_delete
    delete
  rescue Exception => ex
    # Swallow this
    STDOUT.puts "#{ex.message} raised while removing vehicle"
  end

  def delete
    delete_button
    delete_yes
    clear_all_toasts
  end

  def matches?(row_hash)
    all_match = true
    row_hash.each { |key, value| all_match = false if (respond_to? key) && (send(key).to_s != value.to_s) }
    all_match
  end
end
