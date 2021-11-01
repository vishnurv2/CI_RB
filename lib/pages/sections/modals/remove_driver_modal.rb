# frozen_string_literal: true

class RemoveDriverModal < BaseModal
  select(:reason)
  button(:cancel, xpath: './/p-button[@label="Cancel"]/button')
  button(:remove_driver_button, xpath: './/button[span[contains(text(), "Remove Driver")]]')

  def remove_driver
    remove_driver_button
    Watir::Wait.while(message: 'Timed Out After 30 Seconds Waiting for the Remove Driver Modal to Disappear') { present? }
  end

  def remove(reason_for_removal = 'Excluded Driver')
    reason_element.select(reason_for_removal)
    remove_driver
  end
end
