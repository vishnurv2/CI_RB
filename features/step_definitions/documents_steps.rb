# frozen_string_literal: true

Then(/^I should see documents listed in Policy Documents section$/) do
  on(DocumentsPage) do |page|
    found_doc = page.docs_list.has_items
    expect(found_doc).not_to be_nil, "Expected to find a header with a document count > 0, but none were found"
  end
end

Then(/^I (should|should not) see "([^"]*)" document in "([^"]*)" section$/) do |which, document, section|
  on(DocumentsPage) do |page|
    page.documents_section.expand_each_policy_documents
    if which == 'should'
      expect(page.documents_section.find_document_by_type(document).present? && page.documents_section.find_document_by_type(document).tag.downcase == section.downcase).to be_truthy, "Expected#{which.gsub('should', '')} to find \"#{document}\" in the \"#{section}\" section"
    end
    if which == 'should not'
      expect(page.documents_section.find_document_by_type(document).nil?).to be_truthy, "Expected#{which.gsub('should', '')} to find \"#{document}\" in the \"#{section}\" section"
    end
  end

  #   if page.docs_list.present?
  #     item = page.docs_list.headers.find { |e| e.text.include? section }
  #     header_text = page.docs_list.headers.find { |e| e.text.include? section }
  #
  #     counter = if header_text.nil?
  #                 0
  #               else
  #                 page.docs_list.item_count_from_header(header_text.text).to_i
  #               end
  #
  #     documents = []
  #     doc_count = 0
  #     counter.times do
  #       if item.following_sibling.td.child(name: 'chkItem').present?
  #         documents << item.following_sibling.div(class: 'documentNameText').text
  #         item = item.following_sibling
  #         doc_count = doc_count + 1
  #       end
  #       doc_count
  #       documents
  #     end
  #     expect(documents.include?(document)).to eq(which == 'should'), "Expected#{which.gsub('should', '')} to find \"#{document}\" in the \"#{section}\" section"
  #   else
  #     expect(page.docs_list.present?).to eq(which == 'should'), "Expected#{which.gsub('should', '')} to find \"#{document}\" in the \"#{section}\" section"
  #   end
  # end
end

Then(/^I should see documents listed in both sections of the documents page$/) do
  on(DocumentsPage) do |page|
    page.documents_section.expand_each_policy_documents
    RSpec.capture_assertions do
      expect(page.documents_section.documents_grid.find_all { |x| x.tag.include? "FORWARD TO CENTRAL" }.count).to be_positive, "Expected Forward to Central on the Documents page to contain at least 1 document but 0 were found"
      expect(page.documents_section.documents_grid.find_all { |x| x.tag.include? "RETAIN IN AGENCY" }.count).to be_positive, "Expected Forward to Central on the Documents page to contain at least 1 document but 0 were found"
      # expect(page.docs_list.headers_with_count[0][:count].to_i).to be_positive, "Expected Forward to Central on the Documents page to contain at least 1 document but 0 were found"
      # expect(page.docs_list.headers_with_count[1][:count].to_i).to be_positive, "Expected Retain in Agency on the documents page to contain at least 1 document but 0 were found"
    end
  end
end

When(/^I upload the "([^"]*)" as an other document$/) do |pdf_file|
  on(DocumentsPage) do |page|
    page.add_other_document
    modal = page.other_documents_modal
    filename = File.join(Dir.pwd, "fixtures/#{pdf_file}.pdf")
    modal.file_to_upload = filename
    Watir::Wait.until { modal.related_to_element.present? }
    page.wait_for_ajax
    modal.populate
    modal.upload
    page.wait_for_ajax
    modal.upload
    page.wait_for_ajax
  end
end

Then(/^the other document should be displayed with a status of "(.*)"$/) do |status|
  on(DocumentsPage) do |page|
    form_name = "#{data_for('other_documents_validation')['document_title']}.pdf"
    page.documents_section.expand_each_policy_documents
    actual = page.documents_section.find_document_by_type(form_name).status
    # actual = page.docs_list.items.find { |item| item.document_name == form_name }.document_status
    expect(actual.include? status).to be_truthy, "Other document \"#{form_name}\" has not been uploaded"
  end
end

Then(/^I should see a new tab$/) do
  Watir::Wait.until { @browser.windows.count > 1 }
  expect(@browser.windows.count > 1).to be_truthy, 'Expected the browser to have a new tab, but it could not be found'
end

When(/^I click the PDF Icon for the (.*) document$/) do |document_name|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Documents"
      page.left_nav.navigate_to('documents')
    end
    # page.left_navigate_to_if_not_on('Overrides')
  end
  # on(PolicyManagementPage).left_navigate_to_if_not_on('documents')
  on(DocumentsPage) do |page|
    page.documents_section.expand_each_policy_documents
    sleep(0.5)
    document = page.documents_section.find_document_by_type(document_name)
    document.action_icon
    document.view_document
    page.wait_for_processing_overlay_to_close
    sleep(5)
    # if page.toast_container?
    if @browser.windows.count == 1
      document.action_icon
      document.view_document
      page.wait_for_processing_overlay_to_close
      sleep(5)
    end
    # end
    # page.docs_list.items.each do |row|
    #   if row.document_name?
    #     if row.document_name.downcase.include? document_name.downcase
    #       row.documents_checkbox = true
    #       row.three_dots_action
    #       sleep(0.5)
    #       row.view_document
    #       sleep(3)
    #     end
    #   end
    # end
  end
end

# ------ Everything below this line is unverified ------------------------------------- #

When(/^I upload the "([^"]*)" as the "([^"]*)"$/) do |pdf_file, form_name|
  on(DocumentsPage) do |page|
    page.forms_to_forward_grid.find_by(:document, form_name).edit
    filename = File.join(Dir.pwd, "fixtures/#{pdf_file}.pdf")

    modal = page.documents_forward_modal
    modal.file_to_upload = filename
    modal.dismiss
  end
end

Then(/^the "([^"]*)" should show as "([^"]*)"$/) do |form_name, status|
  on(DocumentsPage) do |page|
    actual = page.forms_to_forward_grid.find_by(:document, form_name).status
    expect(actual).to eq(status)
  end
end

Then(/^The documents should have merged into a new window$/) do
  on(DocumentsPage) do |page|
    page.create_pdf
    expect(page.wait_for_pdf_window('CreateMergedPdf')).to be_truthy, 'Expected a new tab with the merged PDF to open!'
  end
end

When(/^I check all of the "([^"]*)" documents$/) do |document|
  on(DocumentsPage) do |page|
    grid = "#{document.snakecase}_grid"
    page.send(grid).scroll.to :center
    page.check_all(grid)
  end
end

Then(/^I click "([^"]*)" button of "([^"]*)" document$/) do |btn, document|
  on(DocumentsPage) do |page|
    page.documents_section.expand_each_policy_documents
    page.documents_section.documents_grid.find { |x| x.name.include? document }.action_icon
    # doc = page.docs_list.items.find { |item| item.document_name.include? document }
    # doc.document_actions_element.button.span.click
    page.send(btn)
    page.wait_for_processing_overlay_to_close
    sleep(5)
    if page.applicant_error_message?
      if page.applicant_error_message == "Currently creating document"
        if page.applicant_error_message.downcase.include? "error in downloading"
          page.documents_section.documents_grid.find { |x| x.name.include? document }.action_icon
          # doc.document_actions_element.button.span.click
          page.send(btn)
        end
        Watir::Wait.while { page.applicant_error_message? }
      end
    end
  end
end

Then(/^I validate for a new tab or error message "([^"]*)" in the toast alert$/) do |msg|
  on(PolicyManagementPage) do |page|
    Watir::Wait.until(timeout: 10, message: "Expected to see a toast alert saying \"#{msg}\" or a new tab") { @browser.windows.count > 1 || page.toast_container? }
    if page.toast_container?
      actual_error_text = page.applicant_error_message
      expect(actual_error_text.downcase).to include(msg.downcase), "Could not find '#{msg}' in error toast alert, the text found in the alert was \"#{actual_error_text}\" "
    else
      expect(@browser.windows.count > 1).to be_truthy, 'Expected the browser to have a new tab, but it could not be found'
    end
  end
end

Then(/^I validate for a new tab$/) do
  Watir::Wait.until { @browser.windows.count > 1 }
  expect(@browser.windows.count > 1).to be_truthy, 'Expected the browser to have a new tab, but it could not be found'
end

Then(/^I should see (\d+) tabs on documents page$/) do |expected_tabs, table|
  on(DocumentsPage) do |page|
    actual_tabs = page.tabs.lis(role: 'presentation').count { |t| t.attributes[:hidden].nil? }
    expect(actual_tabs).to be == expected_tabs, "Expected the number of tabs in the clue prefill mvr section to equal #{expected_tabs} (to match the number of products on the policy), but it was #{actual_tabs}"

    expected = table.raw.flatten

    expected.each do |message|
      actual = page.tabs.lis(role: 'presentation').map { |e| e.text.downcase }.reject { |e| e.empty? }
      found = actual.include? message.downcase
      expect(found).to be_truthy, "Expected to find \"#{message}\" tab"
    end
  end
end