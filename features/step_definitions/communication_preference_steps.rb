Then(/^I should see at (\d+) tabs$/) do |expected_tabs, table|
  on(CommunicationPreferencePage) do |page|
    actual_tabs = page.tabs.lis(role: 'presentation').count { |t| t.attributes[:hidden].nil? }
    expect(actual_tabs).to be == expected_tabs, "Expected the number of tabs in the clue prefill mvr section to equal #{expected_tabs} (to match the number of products on the policy), but it was #{actual_tabs}"

    expected = table.raw.flatten
    expected.each do |message|
      actual = page.tabs.lis(role: 'presentation').map { |e| e.text.downcase }.reject { |e| e.empty? }
      found = actual.include? message.downcase
      expect(found).to be_truthy, "Expected to find \"#{message}\" validation error on the page/modal!"
    end
  end
end

Then(/^I validate details on the policy distribution tab$/) do
  on(CommunicationPreferencePage) do |page|
    page.policy_distribution_tab
    page.policy_distribution_rows.each do |row|
      expect(row.product?).to be_truthy
      row.e_policy_element.hover
      expect(page.div(class: 'p-tooltip-text').text).to eq("E-Policy Terms and Conditions accepted by insured ")
      expect(row.notices_sent_to?).to be_truthy
    end
  end
end

Then(/^I validate details on the text notification tab$/) do
  on(CommunicationPreferencePage) do |page|
    page.text_notification_tab
    page.wait_for_ajax
    page.text_notification_sections.each do |section|
      expect(section.mobile_phone_element.present?).to be_truthy
      expect(section.trash_icon?).to be_truthy
      expect(section.statement_available_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.due_date_reminder_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.payment_confirmation_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.automatic_credit_card_about_to_expire_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.automatic_credit_card_declined_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.reinstatement_notice_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.clain_reported_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.claim_representative_assigned_to_claim_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.payment_issued_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.rental_car_reserved_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.representative_appointment_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.representative_appointment_reminder_element.div.classes.include? 'p-checkbox-checked').to be_truthy
      expect(section.automatically_enroll_element.div.classes.include? 'p-checkbox-checked').to be_truthy
    end
  end
end

Then(/^I provide details on the e signature tab$/) do
  on(CommunicationPreferencePage) do |page|
    page.e_signature_tab
    page.wait_for_ajax
    page.select_all_products = true
    page.email = "Add New"
    modal= page.add_emails_modal
    modal.email = "abc@gmail.com"
    modal.save_email_button
    page.wait_for_ajax
  end
end

Then(/^I should not see the e signature tab in Communication Preference tab$/) do
  on(CommunicationPreferencePage) do |page|
    expect(page.e_signature_tab_element.present?).to be_falsey
  end
end