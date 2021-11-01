Then(/^I check for underwriter referrals and login as CMI user to resolve it in case it is there$/) do

  if on(CMIEmployeesSummaryPage).empty_referrals.nil?

    saved_policy_url = @browser.url
    if on(PolicyManagementPage).left_nav.present?
      on(PolicyManagementPage) do |page|
        sleep(2)
        @browser.refresh
        page.wait_for_processing_overlay_to_close
        if page.user_avatar_element.present?
          page.user_avatar_element.click
          sleep(0.5)
          page.log_out
          @browser.refresh
          page.wait_for_overlay_no_ajax_wait
          if page.user_avatar_element.present?
            @browser.refresh
            page.wait_for_processing_overlay_to_close
            page.user_avatar_element.click
            sleep(0.5)
            page.log_out
            page.wait_for_processing_overlay_to_close
          end
        end
      end
    end
    # Helpers::Fixtures.load_fixture('valid_creds')
    RubyExcelHelper.safe_load_fixture_file('valid_creds')
    # visit(PolicyManagementPage)
    visit(LoginPage).populate
    @browser.refresh
    visit(PolicyManagementPage)
    @browser.goto(saved_policy_url)
  end
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")

    if on(CMIEmployeesSummaryPage).empty_referrals.nil?
      # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
      on(CMIEmployeesSummaryPage) do |page|
        counter = page.referrals_panel.count
        counter.times do
          panel = page.referrals_panel.find { |panel| panel.referrals.first.status == "AWAITING REVIEW" }
          panel.referrals.each do |question|
            # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
            question.review
            question.span(text: 'Approve').double_click
            question.comments = "test"
            question.save
          end
        end
      end
    end
    saved_policy_url = @browser.url
    on(PolicyManagementPage) do |page|
      unless page.page_header_text.include? "Account Summary"
        page.left_nav.navigate_to('Account Overview')
      end
    end
    # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
    page.wait_for_processing_overlay_to_close
    if on(PolicyManagementPage).left_nav.present?
      on(PolicyManagementPage) do |page|
        sleep(2)
        page.user_avatar_element.click
        page.log_out
      end
    end
    # Helpers::Fixtures.load_fixture('agent_creds')
    RubyExcelHelper.safe_load_fixture_file('agent_creds')
    # visit(PolicyManagementPage)
    visit(LoginPage).populate
    @browser.refresh
    visit(PolicyManagementPage)
    @browser.goto(saved_policy_url)
  end

end

And(/^I check for underwriter referrals and login as CMI user to resolve it in case it is there using blue streak seal$/) do

  if on(CMIEmployeesSummaryPage).empty_referrals.nil?

    saved_policy_url = @browser.url
    @browser.refresh
    if on(PolicyManagementPage).left_nav.present?
      on(PolicyManagementPage) do |page|
        sleep(2)
        page.user_avatar_element.click
        page.log_out
      end
    end
    Helpers::Fixtures.load_fixture('valid_creds')
    visit(LoginPage).populate
    visit(PolicyManagementPage)
    @browser.goto(saved_policy_url)
  end
  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_nav.navigate_to("Referrals")

    on(PolicyManagementPage) do |page|
      page.left_nav.find_option("Referrals").scroll.to
      unless page.page_header_text.include? "Referrals"
        page.left_nav.navigate_to('Referrals')
      end
      # page.left_navigate_to_if_not_on("Referrals")
    end
    if on(CMIEmployeesSummaryPage).empty_referrals.nil?
      # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
      if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
        on(CMIEmployeesSummaryPage) do |page|
          counter = page.referrals_panel.count
          if counter > 0
            counter.times do
              panel = page.referrals_panel.find { |p| p.blue_streak_seal? == true }
              panel.blue_streak_seal = true
              panel.reason_for_applying_seal = 'test'
              panel.seal_authorized_by = 0
              panel.apply_seal
              page.wait_for_processing_overlay_to_close
              page.wait_for_ajax
              page.scroll.to :top
            end
          end
        end
      end
      saved_policy_url = @browser.url
      if on(PolicyManagementPage).left_nav.present?
        on(PolicyManagementPage) do |page|
          sleep(2)
          page.user_avatar_element.click
          page.log_out
        end
      end
      Helpers::Fixtures.load_fixture('agent_creds')
      visit(LoginPage).populate
      visit(PolicyManagementPage)
      @browser.goto(saved_policy_url)
    end
  end
end
