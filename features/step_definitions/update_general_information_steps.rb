# frozen_string_literal: true

Then(/^I click modify "General Information"$/) do
  on(AccountSummaryPage).account_info.modify
end

And(/^I select a random Agency Contact$/) do
  on(AccountSummaryPage) do |page|
    modal = page.account_general_info_modal
    selection_length = modal.agency_contact.options.length   ##<< unable to get the length
    reduce = selection_length - 1 # reduce by one incase theres an issue with no current selection
    random_number = rand(2..reduce)
    modal.agency_contact=random_number
    @new_agent_contact = modal.agency_contact.text
  end
end

Then(/^the Agency Contact should be present on Account Summary$/) do
  on(AccountSummaryPage) do |page|
    actual_name = page.account_info.agency_contact_full_name.upcase
    expect(@new_agent_contact.upcase).to eq(actual_name), "Expected #{@new_agent_contact} but found #{actual_name}"
  end
end

And(/^I select a underwriter$/) do
  on(AccountSummaryPage) do |page|
    modal = page.account_general_info_modal

    selection_length = modal.underwriter.options.length   ##<< unable to get the length
    reduce = selection_length - 1 # reduce by one incase theres an issue with no current selection
    random_number = rand(2..reduce)
    modal.underwriter=random_number
    modal.save
  end
end

And(/^I save and close the modal$/) do
  on(AccountSummaryPage) do |page|
    modal = page.account_general_info_modal
    modal.save
  end
end

When(/^I click modify General Information of Watercraft$/) do
  on(AccountSummaryPage) do |page|
    page.wait_for_processing_overlay_to_close
    page.watercraft_account_info.modify if !page.auto_general_info_modal?
  end
end