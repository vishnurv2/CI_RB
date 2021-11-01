# frozen_string_literal: true

class PLRatingClientSelection < BaseSection
  text_field(:new_applicant_button, xpath: './/input[@id="cmdNew"]')
end


class PLRatingManagementPage < BasePage

  section(:client_selection_modal, PLRatingClientSelection, xpath: '//div//h1[contains(text(),"Clients")]/../following-sibling::div[1]')
  #section(:client_information_modal, PLRatingClientInformation, xpath: '//div[@id="HeaderCtl1_divDescriptions"]/ancestor::tbody')

end