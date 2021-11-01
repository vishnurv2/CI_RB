# frozen_string_literal: true

class BaseModal < BaseSection
  button(:save_and_close_button,  xpath: './/p-button[@id="SaveandClose"]/button | .//button[@id="SaveandClose"]')
  button(:save_and_close, xpath: './/div[contains(@class,"hide-on-sm")]/p-button[@id="SaveandClose"]/button')
  span(:save, text: /Save/, default_method: :click!)
  #button(:save_and_close_button, text: /(S|s)ave.*(C|c)lose/)
  #button(:save_and_continue, text: /(S|s)ave.*(C|c)ontinue/, hooks: WFA_HOOKS)

  #button(:save_and_continue, id: 'SaveAndContinue', hooks: WFA_HOOKS) #Save and Continue
  span(:save_and_continue, text: 'Save and continue', default_method: :click!)

  button(:save_changes_button, text: /Save/)
  i(:dismiss_button, xpath: './/div[contains(@class, "header")]/.//*[contains(@class, "times")]', default_method: :click) # this should work for both modals and slideouts
  span(:modal_section_title, xpath: '//div[@class="modal-header"]/div/span[@class="section-title"]')
  span(:modal_sub_section_title, xpath: '//div[@class="modal-header"]/div/span[@class="sub-section-title"]')
  i(:clear, class: /clear-icon pi pi-times/)
  i(:close_button, class: /pi pi-times cursor-pointer/)

  ## sometimes this section title is missing!
  def title
    "#{modal_section_title if modal_section_title?} #{modal_sub_section_title if modal_sub_section_title?}".lstrip.chop
  end

  def dismiss
    dismiss_button_element.double_click if present?
    parent_container.wait_for_modal_masker
  end

  def save_and_close_ignore_validation
    save_changes_button
    wait_for_ajax
    dismiss if present?
  end

  def self.form_data_template
    ERB.new(File.open("templates/#{post_key}_form_data.erb", &:read))
  end

  def self.post_key
    to_s.snakecase
  end

  def self.data_for_this_page
    DataMagic.data_for(to_s.snakecase)
  end

  def save_changes
    #save_and_close_button
    if save_and_close_button?
      save_and_close_button
    elsif save?
      save
    end

    parent_container.wait_for_modal_masker
  end

  def save_and_close
    save_and_close_button
    parent_container.wait_for_modal_masker
  end

  # ------ Everything below this line is unverified ------------------------------------- #

  #button(:dismiss, class: 'close')
  #h4(:title, class: 'modal-title')

  def next_modal
    parent_container.send_keys :tab
    parent_container.wait_for_ajax
    save_and_continue
  end

end
