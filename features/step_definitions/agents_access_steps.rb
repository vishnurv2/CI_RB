And(/^I provide agent code and continue$/) do
  on(AgentsAccessPage) do |page|
    page.pl_quote
    modal = page.agent_code_modal
    modal.agent_code = '04218'
    modal.continue_element.click
  end
end

Then(/^I validate that it navigates to new interface application$/) do
  Watir::Wait.until { @browser.windows.count > 1 }
  expect(@browser.windows.count > 1).to be_truthy, 'Expected the browser to have a new tab, but it could not be found'
  @browser.windows.last.use
  on(PolicyManagementPage) do |page|
    expect(page.displayed?).to be_truthy
  end
end