Then(/^I save billing account details$/) do
  on(AccountSummaryPage) do |page|
    panel = page.billing_summary_panel
    @billing_account = panel.accounts.first.billing_account
    @payment_plan = panel.accounts.first.payment_plan
    applicant_name = page.applicants_panel.applicants.first.name_text.split()
    @payor_name = "#{applicant_name.first.downcase} #{applicant_name.last.downcase}"
    @payor_address = page.applicants_panel.applicants.first.name_element.span(class: /report-name/).text.downcase.remove(',')
  end
end

And(/^I navigate to "([^"]*)"$/) do |opt|
  on(AccountSummaryPage) do |page|
    panel = page.billing_summary_panel
    panel.accounts.first.action_icon
    panel.accounts.first.send("#{opt.snakecase}")
  end
end

Then(/^I validate payor and account details on billing statement$/) do
  @browser.windows.last.use
  on(BillingAccountManagementPage) do |page|
    expect(page.account_number).to eq(@billing_account)
    expect(page.bill_plan).to eq(@payment_plan.split().first)
    expect(page.client_name.downcase).to eq(@payor_name)
    expect(page.client_address.downcase.remove(',').tr("\n", " ").split('-').first).to eq(@payor_address)
  end
end

And(/^I validate credit card details on billing statement$/) do
  on(BillingAccountManagementPage).auto_card_pay
  @browser.windows.last.use
  on(BillingAccountManagementPage) do |page|
    expect(page.first_col).to eq("Currently in use for automatic payments")
    expect(page.card_ending_in).to eq("1111")
    expect(page.type).to eq("Visa")
    expect(page.expiration_date).to eq("#{Time.now.strftime('%m')}/2021")
    expect(page.cardholder_name).to eq("FAKE CARD")
  end
end

And(/^I validate checking account details on billing statement$/) do
  on(BillingAccountManagementPage).auto_card_pay
  @browser.windows.last.use
  on(BillingAccountManagementPage) do |page|
    expect(page.first_col).to eq("Currently in use for automatic payments")
    expect(page.card_ending_in).to eq("3454")
    expect(page.type).to eq("Checking")
    expect(page.routing).to eq("121042882")
    expect(page.cardholder_name).to eq("FAKE CARD")
  end
end