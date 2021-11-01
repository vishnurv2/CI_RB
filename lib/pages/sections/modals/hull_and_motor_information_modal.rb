# frozen_string_literal: true

class HullAndMotorInformationModal < BaseModal
  tab_strip(:tabs, id: 'customTab')
  coverage_list_ng(:coverages_list, xpath: './/app-dynamic-coverage')
  select(:hull, name: 'hulltype')
  text_field(:year, id: 'year')
  text_field(:make, id: 'make')
  text_field(:model, id: 'model')
  text_field(:length, id: 'length')
  text_field(:serial_number, name: 'serialNumber')
  text_field(:registration_number, name: 'registrationnumber')
  text_field(:physical_damage_limit, id: /physicalDamageLimit/)
  button(:save_and_close_button, xpath: './/p-button[@id="SaveandClose"]/button')
  i(:notice_icon, class: 'pi pi-exclamation-triangle ui-message-icon')
  radio(:has_motor_no, name: /hasMotorno/)
  radio(:has_motor_yes, name: /hasMotoryes/)
  select(:motor_type, id: /motortype/)
  text_field(:engine_size, id: /enginesize/)
  select(:hull_deductible, id: /Hull_HullDeductible/)
  button(:save_and_add_another_watercraft, xpath: './/p-button[@id="SaveAndAddAnother"]/button')
  text_field(:motor_year, id: /motoryear/)
  text_field(:motor_make, id: /motormake/)
  text_field(:motor_model, id: /motormodel/)
  text_field(:motor_serial_number, id: /motorserialnumber/)

  def has_motor=(text)
    send("has_motor_#{text.snakecase}").select
  end

  def next_modal
    save_and_continue

    ### this was in the old next modal - it was selecting the coverages tab?
    # tabs.active_tab = 'Coverage'
  end

  def save_and_close
    save_and_close_button_element.click
    wait_for_ajax
    save_and_close_button_element.click if notice_icon?
    wait_for_ajax
  end
end
