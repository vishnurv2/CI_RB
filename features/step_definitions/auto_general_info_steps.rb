# frozen_string_literal: true

When(/^I add an invalid manual loss to the auto general info$/) do
  on(AutoPolicySummaryPage) do |page|
    page.general_info_panel.modify unless page.auto_general_info_modal?
    page.wait_for_processing_overlay_to_close
    page.auto_general_info_modal.add_manual_loss
    page.auto_general_info_modal.save
  end
end

Then(/^I should see the manual loss validation messages$/) do
  on(PolicyManagementPage) do |page|
    RSpec.capture_assertions do
      first_loss = page.auto_general_info_modal.manual_losses.first
      first_loss.scroll.to
      expect(first_loss.date_validation_element.present?).to be_truthy, "Expected to see a validation on the first manual loss's date field, but it was not found"
      expect(first_loss.type_validation_element.present?).to be_truthy, "Expected to see a validation on the first manual loss's type field, but it was not found"
    end
  end
end

When(/^I enter an effective date on the auto general info$/) do
  on(AutoPolicySummaryPage) do |page|
    page.general_info_panel.modify unless page.auto_general_info_modal?
    page.auto_general_info_modal.effective_date = DataMagic.today
  end
end

Then(/^the expiration date on the auto general info is (\d+) year after the effective date$/) do |arg|
  on(PolicyManagementPage) do |page|
    effective_date_parts = page.auto_general_info_modal.effective_date_element.text.split('/')
    expiration_date_parts = page.auto_general_info_modal.expiration_date_element.text.split('/')
    RSpec.capture_assertions do
      expect(expiration_date_parts[0]).to eq(effective_date_parts[0]), "Expected the expiration date day to equal the effective date day, but the following was found, effective day: #{effective_date_parts[0]} expiration day: #{expiration_date_parts[0]}"
      expect(expiration_date_parts[1]).to eq(effective_date_parts[1]), "Expected the expiration date month to equal the effective date month, but the following was found, effective month: #{effective_date_parts[1]} expiration month: #{expiration_date_parts[1]}"
      expect(expiration_date_parts[2].to_i).to eq(effective_date_parts[2].to_i + 1), "Expected the expiration date year to equal the effective date year + 1, but the following was found, effective year: #{effective_date_parts[2]} expiration year: #{expiration_date_parts[2]}"
    end
  end
end

When(/^I add a loss to the auto general info$/) do
  on(AutoPolicySummaryPage) do |page|
    page.general_info_panel.modify unless page.auto_general_info_modal?
    page.wait_for_processing_overlay_to_close
    page.auto_general_info_modal.add_manual_loss
    page.auto_general_info_modal.manual_losses.first.date = Chronic.parse('yesterday').to_date.strftime('%m/%d/%Y')
    page.auto_general_info_modal.manual_losses.first.type = 'Glass'
    page.auto_general_info_modal.save
  end
end

Then(/^the auto general info modal (should|should not) have a loss$/) do |should_or_not|
  on(AutoPolicySummaryPage) do |page|
    page.general_info_panel.modify unless page.auto_general_info_modal?
    page.wait_for_processing_overlay_to_close
    if should_or_not == 'should'
      expect(page.auto_general_info_modal.manual_losses.count > 0 &&
                 page.auto_general_info_modal.manual_losses.first.date.to_s.length > 0 &&
                 page.auto_general_info_modal.manual_losses.first.type.text.length > 0).to be_truthy, "Expected to see a loss with no empty fields on the auto general info modal, but did not"
    else
      expect(page.auto_general_info_modal.manual_losses.count == 0).to be_truthy, "Expected not to see a loss on the auto general info modal"
    end
  end
end

When(/^I delete the losses on the auto general info modal$/) do
  on(AutoPolicySummaryPage) do |page|
    page.general_info_panel.modify unless page.auto_general_info_modal?
    page.wait_for_processing_overlay_to_close
    losses_to_delete = page.auto_general_info_modal.manual_losses.count
    for i in 1..losses_to_delete
      page.auto_general_info_modal.manual_losses.first.delete
    end
    page.auto_general_info_modal.save
  end
end

Then(/^I validate the question attach policy and its default option selected as "([^"]*)"$/) do |opt|
  on(PolicyManagementPage) do |page|
    modal = page.auto_general_info_modal
    ## Below needs updated for NG11  label is now a div - DDL
    expect(modal.question_attach_policy?).to be_falsey
    # expect(modal.attach_policy_options_disabled?).to be_falsey
    # expect(modal.default_attach_policy_option(opt)).to be_truthy
  end
end