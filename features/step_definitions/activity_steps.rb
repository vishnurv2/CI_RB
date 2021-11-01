When(/^I log activity for "([^"]*)" by providing description as "([^"]*)"$/) do |which, description|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    page.send("#{which.downcase}_tab")
    page.log_activity
  end
  on(PolicyManagementPage) do |page|
    modal = page.log_activity_modal
    modal.send_to = 0
    modal.wait_for_ajax
    #page.div(class: /p-autocomplete-panel/).div.click
    modal.description_element.p.send_keys(description)
    modal.log_activity_button
    page.wait_for_processing_overlay_to_close
    @description = description
  end
end

When(/^I log activities for "([^"]*)" by providing description as "([^"]*)"$/) do |which, description|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    page.send("#{which.downcase}_tab")
    page.log_activity
  end
  on(PolicyManagementPage) do |page|
    modal = page.log_activity_modal
    modal.description_element.p.send_keys(description)
    modal.log_activity_button
    page.wait_for_processing_overlay_to_close
    @description = description
  end
end

Then(/^I validate by searching "([^"]*)" and its description$/) do |text|
  on(AccountSummaryPage) do |page|
    page.activity_tab
    page.wait_for_ajax
    page.search_bar_text = @description
    page.search
    page.wait_for_processing_overlay_to_close
    sleep(1)
    expect(page.description_displayed_element.span.style('background-color')).to eq("rgba(255, 255, 0, 1)")
    expect(page.activity_type_text_element.style('background-color')).to eq("rgba(0, 0, 0, 0)")
    # page.search_bar_text = text
    # page.search
    # page.wait_for_processing_overlay_to_close
    # sleep(1)
    # expect(page.span(class: 'bg-yellow').style('background-color')).to eq("rgba(255, 255, 0, 1)")
    # expect(page.description_displayed_element.style('background-color')).to eq("rgba(0, 0, 0, 0)")
  end
end

Then(/^I validate by searching description in activity tab$/) do
  on(AccountSummaryPage) do |page|
    page.activity_tab
    page.wait_for_ajax
    page.search_bar_text = @description
    page.search
    page.wait_for_processing_overlay_to_close
    page.spans(text: @description).each do |item|
      expect(item.style('background-color')).to eq("rgba(255, 255, 0, 1)")
    end
  end
end


Then(/^I validate by searching description in activity tab using "([^"]*)" filter with option "([^"]*)"$/) do |filter, option|
  on(AccountSummaryPage) do |page|
    page.activity_tab
    page.wait_for_ajax
    page.search_bar_text = @description


    if(filter == "account/product")
      page.filter_account_product_element.click
      page.clear_filter.click
      if(option == "account")
        page.label(text: 'Accout Level only').click
      end
    else
      page.label(text: 'Quotes (1)').click
    end

    if(filter == "type")
      page.filter_type_element.click
      page.clear_filter.click
      if(option == "notes")
        page.label(text: 'Notes').click
      elsif option == "emails"
        page.label(text: 'Emails').click
      elsif option == "calls"
        page.label(text: 'Calls').click
      elsif option == "tasks"
        page.label(text: 'Tasks').click
      end
    end

    if filter == "user"
      page.filter_user_element.click
      page.clear_filter.click
      page.user_me_element.click
    end

    page.search
    page.wait_for_processing_overlay_to_close
    page.spans(text: @description).each do |item|
      expect(item.style('background-color')).to eq("rgba(255, 255, 0, 1)")
    end
  end
end

And(/^I select "([^"]*)" activity from activity modal$/) do |which|
  on(AutoPolicySummaryPage) do |page|
    page.actions_menu
    page.log_activity
    modal = page.log_activity_modal
    case which.downcase
    when 'note'
      modal.activity_type = 0
    when 'email'
      modal.activity_type = 1
    when 'call'
      modal.activity_type = 2
    when 'meeting'
      modal.activity_type = 3
    else
      puts 'no selection'
    end

  end
end


And(/^I edit "([^"]*)" activity and select the Priority Restrictive checkbox$/) do |look_activity|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    panel = page.activity_panel.find { |temp| temp.header_text.include? look_activity }
    panel.edit_note_arrow
    panel.edit_note
  end
  on(PolicyManagementPage) do |page|
    model = page.log_activity_modal
    model.priority_restrictive = true
    model.log_activity_button
    page.wait_for_processing_overlay_to_close
  end
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    page.priority_restrictive_image
    page.wait_for_ajax
  end
end

And(/^I edit again and check all the greyed options should be present$/) do
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    panel = page.activity_panel.find { |temp| temp.header_text.include? 'Note' }
    panel.edit_note_arrow
    panel.edit_note
  end
  on(PolicyManagementPage) do |page|
    model = page.log_activity_modal
    model.priority_restrictive = false
    model.bold
    model.italic
    model.underline
    model.pickerlabel_color
    model.pickerlabel_background
    model.ql_links
    model.log_activity_button
    page.wait_for_processing_overlay_to_close
  end
end

And(/^I click on the "([^"]*)" tab$/) do |which|
  on(AccountSummaryPage) do |page|
    page.send("#{which.downcase}_tab")
  end
end

And(/^I edit "([^"]*)" activity and verified the gray area$/) do |look_activity|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    panel = page.activity_panel.find { |temp| temp.header_text.include? look_activity }
    panel.edit_note_arrow
    panel.edit_note
  end
  on(PolicyManagementPage) do |page|
    model = page.log_activity_modal
    model.bold
    model.italic
    model.underline
    model.pickerlabel_color
    model.pickerlabel_background
    model.ql_links
    model.description_element.p.send_keys('abc')
    model.log_activity_button
    model.log_activity_button
    page.wait_for_processing_overlay_to_close
  end
end

When(/^I log activity for "([^"]*)" by providing description as "([^"]*)" and click on the attach file$/) do |which, description|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    page.send("#{which.downcase}_tab")
    page.log_activity
  end
  on(PolicyManagementPage) do |page|
    modal = page.log_activity_modal
    modal.send_to = 0
    modal.wait_for_ajax
    #page.div(class: /p-autocomplete-panel/).div.click
    modal.description_element.p.send_keys(description)
    modal.attach_file
    modal.wait_for_ajax
    @description = description
  end
end

When(/^I upload the "([^"]*)" as an other document for activity$/) do |pdf_file|
  on(PolicyManagementPage) do |page|
    attach_modal = page.insert_file_modal
    attach_modal.upload_new
    attach_modal.wait_for_ajax
    filename = File.join(Dir.pwd, "fixtures/#{pdf_file}.pdf")
    attach_modal.file_to_upload = filename
    Watir::Wait.until { attach_modal.related_to_element.present? }
    page.wait_for_ajax
    attach_modal.account_level = true
    # attach_modal.populate
    attach_modal.insert_button
    page.wait_for_processing_overlay_to_close
    modal = page.log_activity_modal
    modal.log_activity_button
    page.wait_for_ajax
  end
end

Then(/^I validate by searching "([^"]*)" in activity tab$/) do |text|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to("Account Overview")
    end
  end
  on(AccountSummaryPage) do |page|
    page.activity_tab
    page.wait_for_ajax
    page.search_bar_text = text
    page.search
    page.wait_for_processing_overlay_to_close
    sleep(1)
    expect(page.span(class: 'bg-yellow').style('background-color')).to eq("rgba(255, 255, 0, 1)")
  end
end

And(/^I validate a new tab opens on clicking view quote$/) do
  on(AccountSummaryPage) do |page|
    panel = page.activity_panel.find {|panel| panel.text.downcase.include? 'quote saved'}
    panel.ellipsis_icon
    page.view_quote
  end
  Watir::Wait.until { @browser.windows.count > 1 }
  expect(@browser.windows.count > 1).to be_truthy, 'Expected the browser to have a new tab, but it could not be found'
end

When(/^I log activity for "([^"]*)"$/) do |which|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    page.send("#{which.downcase}_tab")
    page.log_activity
  end
end

Then(/^I should see the following options for send to$/) do |table|
  expected = table.rows.flatten
  on(PolicyManagementPage) do |page|
    modal = page.log_activity_modal
    select_list = modal.send_to.options true
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found"
      end
    end
  end
end

When(/^I log activity for "([^"]*)" by providing description as "([^"]*)" related to "([^"]*)"$/) do |which, description, related_to|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    page.send("#{which.downcase}_tab")
    page.log_activity
  end
  on(PolicyManagementPage) do |page|
    modal = page.log_activity_modal
    modal.send_to = 0
    modal.wait_for_ajax
    if(related_to == 'account')
      modal.related_to = 0
    elsif related_to == 'product'
      modal.related_to = 1
    end
    #page.div(class: /p-autocomplete-panel/).div.click
    modal.description_element.p.send_keys(description)
    modal.log_activity_button
    page.wait_for_processing_overlay_to_close
    @description = description
  end
end


When(/^I log activities for "([^"]*)" by providing description as "([^"]*)" related to "([^"]*)"$/) do |which, description, related_to|
  on(PolicyManagementPage) do |page|
    unless page.page_header_text == "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
  end
  on(AccountSummaryPage) do |page|
    # page.left_navigate_to_if_not_on('Account Overview')
    page.send("#{which.downcase}_tab")
    page.log_activity
  end
  on(PolicyManagementPage) do |page|
    modal = page.log_activity_modal
    if(related_to == 'account')
      modal.related_to = 0
    elsif related_to == 'product'
      modal.related_to = 1
    end
    modal.description_element.p.send_keys(description)
    modal.log_activity_button
    page.wait_for_processing_overlay_to_close
    @description = description
  end
end
