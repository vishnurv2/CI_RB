Then(/^I validate contact agent details$/) do
  on(MyCentralHomePage) do |page|
    expect(page.agency_service_name_element.text).to eq(DataMagic.yml["contact_agent_details"]["agency_service_name"])
    expect(page.telephone_number_element.text).to eq(DataMagic.yml["contact_agent_details"]["telephone_number"])
    expect(page.mail_element.text).to eq(DataMagic.yml["contact_agent_details"]["mail"])
    expect(page.agency_service_link_element.text).to eq(DataMagic.yml["contact_agent_details"]["agency_service_link"])
  end
end

And(/^I validate view my policy details$/) do
  on(MyCentralHomePage).view_my_policy
  on(MyCentralViewPolicyPage) do |page|
    page.policy_details_expand_element.click
    Watir::Wait.until { page.policy_status_element.present? }
    expect((page.policy_status_element.text).include?(DataMagic.yml["view_my_policy_details"]["policy_status"])).to be_truthy
    expect(page.policy_history_date_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_date"])
    expect(page.policy_history_type_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_type"])
    expect(page.policy_history_amended_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_amended"])
    expect(page.policy_history_pdf_icon?).to be_truthy
    page.back_button_element.click
  end
end

And(/^I validate billing and payments details$/) do
  on(MyCentralHomePage).billing_and_payments
  on(MyCentralBillingAndPaymentsPage) do |page|
    expect(page.card_name_element.text).to eq(DataMagic.yml["billing_and_payments_details"]["card_name"])
    expect(page.policy_element.text).to eq(DataMagic.yml["billing_and_payments_details"]["policy"])
    expect(page.term_element.text).to eq(DataMagic.yml["billing_and_payments_details"]["term"])
    expect(page.balance_element.text).to eq(DataMagic.yml["billing_and_payments_details"]["balance"])
    expect(page.current_due_element.text).to eq(DataMagic.yml["billing_and_payments_details"]["current_due"])
    expect(page.current_amount_due_element.text).to eq(DataMagic.yml["billing_and_payments_details"]["current_amount_due"])
    page.back_button_element.click
  end
end

And(/^I validate view my policy details for umbrella$/) do
  on(MyCentralHomePage).view_my_policy
  on(MyCentralViewPolicyPage) do |page|
    page.policy_details_expand_element.click
    Watir::Wait.until { page.policy_status_element.present? }
    expect((page.policy_status_element.text).include?(DataMagic.yml["view_my_policy_details"]["policy_status"])).to be_truthy
    expect(page.policy_history_date_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_date"])
    expect(page.policy_history_type_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_type"])
    expect(page.policy_history_amended_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_amended"])
    expect(page.policy_history_pdf_icon?).to be_truthy
    expect(page.policy_history_date_1_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_date_1"])
    expect(page.policy_history_type_1_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_type_1"])
    expect(page.policy_history_amended_1_element.text).to eq(DataMagic.yml["view_my_policy_details"]["policy_history_amended_1"])
    expect(page.policy_history_pdf_icon_1?).to be_truthy
    page.back_button_element.click
  end
end