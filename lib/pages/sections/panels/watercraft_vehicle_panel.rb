

class VehicleRowWatercraft < ::BaseSection
  td(:vehicle, data_label: /Watercraft/)
  td(:liability, data_label: /Hull/)
  td(:comp_coll, data_label: /Physical Damage/)
  td(:class_code, data_label: /Deductible/)
  #span(:edit, class: /fa-pencil/)
  button(:edit, xpath: './/p-button[@icon="fas fa-pencil"]/button')
  link(:view_motors, text: /View Motors/)
  link(:hide_motors, text: /Hide Motors/)
end


class WatercraftVehiclePanel < BasePanel
  data_grid(:vehicles, VehicleRowWatercraft)
  button(:add_trailer, xpath: './/p-button[@label="Add Trailer"]/button')
  td(:make_modal_text, xpath: './/td[@class="action-cell" and text()="1"]/following-sibling::td')
  th(:motor_deductible_column, xpath: './/th[@class="action-cell" and text()="#"]/following-sibling::th[contains(text(),"Deductible")]')
end