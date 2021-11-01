Then(/^I add and upload "([^"]*)" and validate proposal$/) do |pdf_file|
  on(QuoteManagementPage).proposals_tab
  on(ProposalsPage) do |page|
    page.create_proposal
    page.wait_for_ajax
    modal = page.new_proposal_modal
    modal.prepared_for = 0
    modal.prepared_by = 1
    modal.select_products = true
    modal.insert_file
  end
  on(PolicyManagementPage) do |page|
    attach_modal = page.insert_file_modal
    attach_modal.upload_new
    attach_modal.wait_for_ajax
    filename = File.join(Dir.pwd, "fixtures/#{pdf_file}.pdf")
    attach_modal.file_to_upload = filename
    Watir::Wait.until { attach_modal.related_to_element.present? }
    page.wait_for_ajax
    attach_modal.account_level = true
    attach_modal.insert_button
    page.wait_for_ajax
  end
  on(ProposalsPage) do |page|
    modal = page.new_proposal_modal
    modal.save
    modal.save_and_close
    page.wait_for_ajax
    expect(page.proposals.count > 0).to be_truthy
  end
end


When(/^I create proposal with customized and recommended quotes and validate premium summary$/) do
  on(QuoteManagementPage).proposals_tab
  on(ProposalsPage) do |page|
    page.create_proposal
    page.wait_for_ajax
    modal = page.new_proposal_modal
    modal.prepared_for = 0
    modal.prepared_by = 1
    modal.select_umbrella_product = true
    modal.select_home_product = true
    modal.select_auto_product = true
    modal.recommended_quote = true
    modal.premium_summary = true
    expect(modal.recommended_umbrella_summary).to eq('Umbrella')
    expect(modal.recommended_auto_summary).to eq('Auto')
    expect(modal.recommended_home_summary).to eq('Home')
  end
end

When(/^I create a proposal$/) do
  on(QuoteManagementPage).proposals_tab
  on(ProposalsPage) do |page|
    page.create_proposal
    page.wait_for_ajax
    modal = page.new_proposal_modal
    modal.prepared_for = 0
    @prepared_for = modal.prepared_for.text.split("\n").last
    modal.prepared_by = 1
    @prepared_by = modal.prepared_by.text.split("\n").last
    modal = page.new_proposal_modal
    modal.save
    modal.save_and_close
    page.wait_for_ajax
    expect(page.proposals.count > 0).to be_truthy
  end
end