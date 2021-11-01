# frozen_string_literal: true

Then(/^I navigate to the new personal account$/) do
  on(PolicyManagementPage) do |page|
    page.add_new_account('personal')
  end
end

And(/^I save without data on the "([^"]*)" modal$/) do |modal|
  modal = modal.downcase.gsub(' ','_')
  on(PolicyManagementPage) do |page|
    page.populate_modal(modal)
  end
end

Then(/^I perform UI edits validations on the "([^"]*)" modal$/) do |modal|
  modal = modal.downcase.gsub(' ','_')
end
