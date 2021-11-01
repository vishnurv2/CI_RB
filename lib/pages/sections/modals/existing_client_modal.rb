# frozen_string_literal: true

class ExistingClientModal < BaseModal
  # radio(:add_to_existing, index: 0, name: 'ExistingAccountSelection')
  # radio(:add_as_new_radio, value: 'New', name: 'ExistingAccountSelection', default_method: :set)
  radio(:add_to_existing, xpath: './/a[contains(@id, "viewAccount")]/../.././/p-radiobutton')
  radio(:add_as_new_radio, name: 'accountSelected')
  button(:save_and_continue, xpath: '//*[@id="SaveAndContinue"]/button')

  def select_existing_account
    10.times do
      begin
        add_to_existing_element.click
        break
      rescue
      end
      sleep(0.05)
    end
  end

  def add_as_new
    Watir::Wait.until { add_as_new_radio_element.present? }
    add_as_new_radio_element.click
  end

  def self.post(client, _data = nil)
    fields = client.get_existing_account_modal
    form_data = { 'SaveAndContinue' => nil, 'PreviousModal' => nil, 'ActionType' => nil,
                  'ExistingAccountSelection' => 'New', '__RequestVerificationToken' => fields['__RequestVerificationToken'] }

    client.post_existing_account_modal(form_data)
  end

  def delete_all_existing_except_one
    acc_links = as(text: 'View the Account')
    return unless acc_links.count > 5

    api = AccountAPI::DELETEApi.new
    acc_links[1..-1].each { |al| api.accounts_remove_account(al.attributes[:href].split('=').last) }
    # api = AccountAPI.new
    # acc_links[1..-1].each { |al|  api.delete_account(al.attributes[:href].split('=').last) }
  end

end
