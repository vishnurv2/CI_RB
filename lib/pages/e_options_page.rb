# frozen_string_literal: true

class EOptionsSection < BaseSection
  link(:modify, class: 'showAutoGeneralInfo')

  def subscriptions
    s = Hash.new()
    s['e_policy'] = (span(name: 'EPolicyEmailAddress').text.downcase != 'not enrolled')
    s['e_signature'] = (span(name: 'ESignatureEmailAddress').text.downcase != 'not enrolled')
    # E-billing Account HTML not the same as the above, myCentral Security also not only "Not Enrolled" AMN 11-4-2019
    return s
  end
end

class TextEOptionsPage < PolicyManagementPage
  h2(:text_e_options_h2, text: 'Text & E-Options')

  section(:e_options_panel, EOptionsSection, class: 'panel-primary', xpath: '//*[@id="divMainContent"]/div/div/div[.//div/a[contains(@class, "showAutoGeneralInfo")]]')
  section(:text_messages_panel, TextMessagesPanel, class: 'panel-primary', xpath: '//*[@id="textMessagesPanel"]/parent::div')
  section(:text_message_modal, TextMessageModal, xpath: '//div[@id="divModalContent" and .//div/h4 = "Text Message"]')

  def subscriptions
    e_options_panel.subscriptions
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end
