Then(/^I edit policy change$/) do
  on(AccountSummaryPage) do |page|
    modal = page.edit_policy_change_modal
    modal.date.span(text: 'Specify Date').click
    modal.specific_date = Chronic.parse('2 days from now').to_date.strftime('%m/%d/%Y')
    modal.description_element.click
    modal.description = 'effective date updated'
    sleep(0.6)
    modal.save_and_close_button
    page.wait_for_ajax
  end
end