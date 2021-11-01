# frozen_string_literal: true

When(/^I navigate to "([^"]*)" using the left nav$/) do |opt|
  on(ReportsPage) do |page|
    if page.premium_change_modal?
      page.premium_change_modal.close
      page.wait_for_overlay_no_ajax_wait
    end
  end
  on(PolicyManagementPage) do |page|
    if page.new_personal_account_modal?
      page.new_personal_account_modal.dismiss
      page.wait_for_overlay_no_ajax_wait
    end
    page.toggle_side_navbar if page.product_collapsed?
    if (opt.downcase.include? 'quote management') || (opt.downcase.include? 'in - ')
      page.toggle_quotes
    end
    page.left_nav.navigate_to(opt)
  end
  on(ReportsPage) do |page|
    if page.premium_change_modal?
      page.premium_change_modal.close
      page.wait_for_overlay_no_ajax_wait
    end
  end
  on(PolicyManagementPage) do |page|
    if page.new_personal_account_modal?
      page.new_personal_account_modal.dismiss
      page.wait_for_overlay_no_ajax_wait
    end
  end
end

When(/^I navigate to my quote "([^"]*)" using the left nav$/) do |opt|
  on(PolicyManagementPage) do |page|
    #this is a hack to get this going today, will refactor later. #toggle quotes
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    page.left_nav.navigate_to(opt)
  end
end

Then(/^I verify sequencing of products across the application in "([^"]*)"$/) do |opt|
  dictionary = { 1 => "IN - Auto", 2 => "IN - Homeowners", 3 => "IN - Special Dwelling", 4 => "IN - Umbrella", 5 => "IN - Scheduled Property", 6 => "IN - Summit Watercraft" }
  on(PolicyManagementPage) do |page|
    case opt.downcase
    when 'quotes'
      collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
      page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
      for a in 1..6 do
        expect(page.left_nav.div(id: 'Quotes').ul.li(index: a).text.include?(dictionary[a])).to be_truthy
      end

    when 'documents'
      page.left_nav.find_option("Documents").click
      page.wait_for_ajax
      for a in 1..6 do
        expect(on(DocumentsPage).tr(index: a + 1).text.include?(dictionary[a])).to be_truthy
      end
      ## document page filter dropdown
      for a in 1..6 do
        expect(on(DocumentsPage).div(id: 'productList').text.split(",")[a + 1].include?(dictionary[a])).to be_truthy
      end

    when 'referrals'
      page.left_nav.find_option("referrals").click
      page.wait_for_ajax
      for a in 1..6 do
        expect(on(ReferralsPage).tr(index: a + 1).text.include?(dictionary[a])).to be_truthy
      end

    when 'reports'
      page.left_nav.find_option("reports").click
      page.wait_for_ajax
      for a in 1..6 do
        expect(on(ReportsPage).tbody.tr(index: a - 1).text.include?(dictionary[a])).to be_truthy
        on(ReportsPage).tbody.tr(index: a - 1).i().click
      end
      ## reports page filter dropdown
      for a in 1..6 do
        expect(on(ReportsPage).product_dropdown.options[a].include?(dictionary[a])).to be_truthy
      end

    when 'overrides'
      page.left_nav.find_option("overrides").click
      page.wait_for_ajax
      for a in 1..6 do
        on(OverridesPage).div(class: 'scroll-for-fixed-header').div(class: 'ng-star-inserted', index: a + 1).i().click
        expect(on(OverridesPage).div(class: 'scroll-for-fixed-header').div(class: 'ng-star-inserted', index: a + 1).text.include?(dictionary[a])).to be_truthy
      end
      #filter dropdown
      for a in 1..6 do
        expect(on(OverridesPage).div(id: 'productList').text.split(",")[a].include?(dictionary[a])).to be_truthy
      end

      ## log activity/note ,related to dropdown
    when 'log activity / note'
      page.button(ptooltip: 'Log activity / note').click
      for a in 1..6 do
        expect(page.log_activity_modal.related_to.options[a].include?(dictionary[a])).to be_truthy
      end
      page.log_activity_modal.related_to.click
      page.log_activity_modal.attach_file
      page.wait_for_ajax
      #Insert file --> documents tab
      for a in 1..6 do
        expect(page.insert_file_modal.tbody.tr(index: (a.to_i) - 1).text.include?(dictionary[a])).to be_truthy
      end
      page.insert_file_modal.span(text: 'Cancel').click
      page.log_activity_modal.close

    when 'send email'
      page.button(ptooltip: 'Send an email').click
      for a in 1..6 do
        expect(page.log_activity_modal.related_to.options[a].include?(dictionary[a])).to be_truthy
      end
      page.log_activity_modal.related_to.click
      page.log_activity_modal.attach_file
      page.wait_for_ajax
      #Insert file --> documents tab
      for a in 1..6 do
        expect(page.insert_file_modal.tbody.tr(index: (a.to_i) - 1).text.include?(dictionary[a])).to be_truthy
      end
      page.insert_file_modal.span(text: 'Cancel').click
      page.log_activity_modal.close

    when 'underwriting referrals'
      collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
      page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
      page.left_nav.find_option("Quote Management").click
      page.wait_for_ajax
      page.a(id: 'viewUnderwritingReferrals').click
      page.wait_for_ajax
      for a in 1..6 do
        expect(page.underwriting_referrals_modal.div(class: 'no-panel-padding ng-star-inserted', index: (a.to_i) - 1).span(class: 'bold-text').text.include?(dictionary[a])).to be_truthy
      end
      page.underwriting_referrals_modal.close
      page.wait_for_ajax

    when 'account summary quotes'
      page.left_nav.find_option("Account Overview").click
      page.wait_for_ajax
      for a in 1..6 do
        #  expect(page.div(id: 'p-panel-57').tr(index: (a.to_i)).text.include?(dictionary[a])).to be_truthy
        expect(on(AccountSummaryPage).product_list.tr(index: (a.to_i)).text.include?(dictionary[a])).to be_truthy
      end

    when 'activity tab'
      page.left_nav.find_option("Account Overview").click
      page.wait_for_ajax
      on(AccountSummaryPage).activity_tab
      page.wait_for_ajax
      on(AccountSummaryPage).div(class: 'pull-right').span.click
      for a in 1..6 do
        expect(on(AccountSummaryPage).div(class: 'overley-panel').div(class: 'p-grid ng-star-inserted', index: (a.to_i) + 1).text.include?(dictionary[a])).to be_truthy
      end

    when 'notes tab'
      page.left_nav.find_option("Account Overview").click
      page.wait_for_ajax
      on(AccountSummaryPage).notes_tab
      page.wait_for_ajax
      for a in 1..6 do
        expect(on(AccountSummaryPage).div(class: 'overley-panel').div(class: 'p-grid ng-star-inserted', index: (a.to_i) + 1).text.include?(dictionary[a])).to be_truthy
      end

    when 'emails tab'
      page.left_nav.find_option("Account Overview").click
      page.wait_for_ajax
      on(AccountSummaryPage).emails_tab
      page.wait_for_ajax
      for a in 1..6 do
        expect(on(AccountSummaryPage).div(class: 'overley-panel').div(class: 'p-grid ng-star-inserted', index: (a.to_i) + 1).text.include?(dictionary[a])).to be_truthy
      end

    when 'calls tab'
      page.left_nav.find_option("Account Overview").click
      page.wait_for_ajax
      on(AccountSummaryPage).calls_tab
      page.wait_for_ajax
      for a in 1..6 do
        expect(on(AccountSummaryPage).div(class: 'overley-panel').div(class: 'p-grid ng-star-inserted', index: (a.to_i) + 1).text.include?(dictionary[a])).to be_truthy
      end

    when 'tasks tab'
      page.left_nav.find_option("Account Overview").click
      page.wait_for_ajax
      on(AccountSummaryPage).tasks_tab
      page.wait_for_ajax
      for a in 1..6 do
        expect(on(AccountSummaryPage).div(class: 'overley-panel').div(class: 'p-grid ng-star-inserted', index: (a.to_i) + 1).text.include?(dictionary[a])).to be_truthy
      end

    else
      puts 'Invalid choice'
    end
  end
end

When(/^I navigate to policies "([^"]*)" using the left nav$/) do |opt|
  on(ReportsPage) do |page|
    if page.premium_change_modal?
      page.premium_change_modal.close
      page.wait_for_overlay_no_ajax_wait
    end
  end
  on(PolicyManagementPage) do |page|
    #this is a hack to get this going today, will refactor later. #toggle quotes

    collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
    page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"

    page.left_nav.navigate_to(opt)
  end
  on(ReportsPage) do |page|
    if page.premium_change_modal?
      page.premium_change_modal.close
      page.wait_for_overlay_no_ajax_wait
    end
  end
end

# ------ Everything below this line is unverified ------------------------------------- #

When(/^I search for "([^"]*)" using the navbar$/) do |term|
  @navbar_search_term = term
  on(PolicyManagementPage).nav_bar.search_for(term)
end

Then(/^I should be viewing the search results for that term$/) do
  expect(@browser.url).to start_with("#{Nenv.base_url}/PolicyManagement/?search=#{@navbar_search_term}")
end

When(/^I navigate to "([^"]*)" using the navbar$/) do |arg|
  @browser.goto("#{@browser.url}#")
  on(PolicyManagementPage).nav_bar.navigate_to(arg)
end

When(/^I select "([^"]*)" in the left nav$/) do |opt|
  @browser.goto("#{@browser.url}#")
  on(PolicyManagementPage) do |page|
    page.toggle_side_navbar
    page.left_nav.select_option(opt)
  rescue Exception => e
    raise e unless /divCustomLoading/.match?(e.message) # divProcessingPageOverlay

    page.wait_for_processing_overlay_to_close
    page.toggle_side_navbar
    page.left_nav.select_option(opt)
  end
end

And(/^the menu option for "([^"]*)" is highlighted in the left nav$/) do |opt|
  on(PolicyManagementPage) do |page|
    close_button = page.button(class: 'close')
    close_button.click if close_button.present?
    page.toggle_side_navbar if page.toggle_side_navbar_link?
    expect(page.left_nav.find_option(opt)&.active?).to be_truthy
  end
end

And(/^I (should|should not) see "([^"]*)" in the left nav$/) do |should_or_not, option|
  expected_not_str = should_or_not.gsub('should', '')
  actual_not_str = ' not'.gsub(expected_not_str, '')
  on(PolicyManagementPage) do |page|
    expect(page.left_nav.find_option(option)).not_to be_nil, "Expected#{expected_not_str} to see '#{option}' in the left nav, but it was#{actual_not_str} found"
  end
end

And(/^I click "([^"]*)" button of "([^"]*)" modal$/) do |btn, modal|
  on(PolicyManagementPage) do |page|
    if btn == 'Continue'
      page.quote_snapshot_modal.do_next_quote
    elsif btn == 'error_icon'
      page.quote_snapshot_modal.premium_exclamation_error_icon_element.click
    elsif btn == 'Quote Management'
      page.quote_snapshot_modal.quote_management
    end
  end
end

When(/^I click edit on the applicant panel and open driver tab$/) do
  on(AccountSummaryPage) do |page|
    page.applicants_panel.applicants.first.edit_element.click
    modal = page.add_applicant_modal
    modal.driver_tab_element.click
    page.wait_for_ajax
  end
end

Then(/^I validate premium in "([^"]*)" modal$/) do |modal|
  on(PolicyManagementPage) do |page|
    expect(page.quote_snapshot_modal.total_premium).to eq("$---.--")
  end
end

Then(/^I validate underlying limit confirmation$/) do
  on(PolicyManagementPage) do |page|
    if page.underlying_limit_confirmation_modal?
      expect(page.underlying_limit_confirmation_modal?).to be_truthy
      expect(page.underlying_limit_confirmation_modal.dialog_message).to eq("Underlying limits are not at the minimum required by Central, do you want to continue with limits increased on the underlying policy(s)?")
    end
  end
end

When(/^I "([^"]*)" underlying limit confirmation$/) do |confirmation|
  on(PolicyManagementPage) do |page|
    if confirmation == 'accept'
      page.underlying_limit_confirmation_modal.accept_button
    else
      page.underlying_limit_confirmation_modal.reject_button
    end
  end
end

Then(/^I validate "([^"]*)" toaster message "([^"]*)" on the page$/) do |type, validation_message|
  @toasters = []
  on(PolicyManagementPage) do |page|
    if type == 'success'
      msg = page.toast_container.divs(class: 'toast-success').to_a.map { |x| x.text }
      STDOUT.puts msg[0]
      expect(msg[0]).to eq(validation_message)
    end
    if type == 'error'
      msg = page.toast_container.divs(class: 'toast-error').to_a.map { |x| x.text }
      expect(msg[0]).to eq(validation_message)
    end
  end
end


And(/^I navigate to "([^"]*)" in left nav$/) do |opt|
  @browser.goto("#{@browser.url}#")
  on(PolicyManagementPage) do |page|
    # HACK - singleing out quote options
    timeout = if opt.downcase == "quote options"
                "120".to_i
              else
                Nenv.browser_timeout
              end

    start = Time.now
    Timeout.timeout(timeout) do
      page.left_nav.click_menu_item(opt)
    end
  rescue Timeout::Error => e
    AppErrorHelper.screenshot_error(nil, self)
    stop = Time.now
    time = stop - start
    page.raise_page_loading(e, time, opt)
  end
end

And(/^I add a product from the left nav$/) do
  @browser.goto("#{@browser.url}#")
  on(PolicyManagementPage) do |page|
    page.new_personal_account_modal.close_icon_element.click if page.new_personal_account_modal?
    start = Time.now
    Timeout.timeout(Nenv.browser_timeout) do
      page.left_nav.add_product if page.left_nav.add_product?
      if page.left_nav.actions?
        page.left_nav.actions
        page.left_nav.new_quote
      end
    end
  rescue Timeout::Error => e
    AppErrorHelper.screenshot_error(nil, self)
    stop = Time.now
    time = stop - start
    page.raise_page_loading(e, time, 'Add Product Left Nav Plus Button')
  end
end

Then(/^The red dot (should|should not) be present on bell icon$/) do |op|
  on(PolicyManagementPage) do |page|
    page.wait_for_ajax
    expect(page.left_nav.bell_icon?).to be_truthy, 'Bell icon should be present'
    res = op.include?('should not') ? false : true
    expect(page.left_nav.bell_alert_icon_badge?).to eq(res), "Expected#{op.gsub('should', '')} to have the red dot on the bell icon"
  end
end

And(/^I navigate to "([^"]*)" tab on quote management page$/) do |tab|
  on(PolicyManagementPage) do |page|
    page.toggle_side_navbar if page.product_collapsed?
    page.left_nav.find_option('Quote Management').scroll.to
    unless page.page_header_text.include? "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
    # page.left_navigate_to_if_not_on('Quote Management')
  end
  on(QuoteManagementPage).send("#{tab}_tab".snakecase)
end

And(/^I navigate to "([^"]*)" under open policies using left nav$/) do |opt|
  on(PolicyManagementPage) do |page|
    #this is a hack to get this going today, will refactor later. #toggle quotes

    collapsed = page.left_nav.find_option("Policies").attribute_value('class').split(" ")
    page.left_nav.find_option("Policies").click if collapsed.include? "aria-collapsed"

    page.left_nav.navigate_to(opt)
  end
end

Then(/^The red dot (should|should not) be present on issues to resolve link$/) do |option_text|
  on(PolicyManagementPage) do |page|
    if option_text == 'should'
      expect(page.left_nav.issues_to_resolve_element.present?).to be_truthy
    elsif option_text == 'should not'
      expect(page.left_nav.issues_to_resolve_element.present?).to be_falsey
    end

    #expect(page.left_nav.red_dot?).to eq(which == 'should'), "Expected#{which.gsub('should', '')} to have the red dot on the issues to resolve link"
  end
end

And(/^I navigate to attached product "([^"]*)"$/) do |opt|
  on(PolicyManagementPage) do |page|
    if page.new_personal_account_modal?
      page.new_personal_account_modal.dismiss
      page.wait_for_overlay_no_ajax_wait
    end
    page.toggle_side_navbar if page.product_collapsed?
    if (opt.downcase.include? 'quote management') || (opt.downcase.include? 'in - ')
      page.toggle_quotes
    end
    page.left_nav.navigate_to_attached_product(opt)
  end
end