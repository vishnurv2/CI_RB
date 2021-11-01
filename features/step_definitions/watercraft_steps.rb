And(/^I add a watercraft operator$/) do
  @watercraft_operator = data_for('watercraft_operator_modal')
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Watercraft')
  on(AutoPolicySummaryPage).watercraft_operators_panel.add_watercraft_operator
  on(PolicyManagementPage) do |page|
    modal = page.watercraft_operator_modal
    modal.populate_with(@watercraft_operator)
    modal.save_and_close
    page.wait_for_processing_overlay_to_close
    page.scroll.to :top
  end
end

Then(/^I fully issue watercraft policy$/) do
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Watercraft')
  on(AutoPolicySummaryPage).issue
  on(QuoteManagementPage) do |page|
    page.wait_for_ajax
    page.thank_you_modal.close if page.thank_you_modal.present?
  end

  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  # on(UnderwritingQuestionsSummaryPage).all_products_issues_to_resolve # AMN 6-29-2021 Account Underwriting Questions Have Been Removed
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_watercraft

  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    unless page.page_header_text.include? "Referrals"
      page.left_nav.navigate_to('Referrals')
    end
  end

  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    # on(CMIEmployeesSummaryPage).expand_each_policy_referrals
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage).referrals_panel.each do |panel|
        panel.referrals.each do |question|
          if question.status.downcase.include? "awaiting review"
            on(CMIEmployeesSummaryPage).wait_for_ajax
            question.review
            question.span(text: 'Approve').click
            question.comments = "test"
            question.save
          end
        end
      end
    end
  end
  #on(PolicyManagementPage).left_navigate_to_if_not_on("Reports")
  #on(ReportsPage).resolve_issues_to_resolve
  #on(PolicyManagementPage).refresh_alerts
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).issue
  on(AutoPolicySummaryPage).navigate_issue_wizard
end

Then(/^I fully issue multiple watercraft policy$/) do
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Watercraft')
  on(AutoPolicySummaryPage).issue
  on(QuoteManagementPage) do |page|
    page.wait_for_ajax
    page.thank_you_modal.close if page.thank_you_modal.present?
  end

  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage).issues_to_resolve_watercraft

  on(PolicyManagementPage) do |page|
    page.left_nav.find_option("Referrals").scroll.to
    page.left_navigate_to_if_not_on("Referrals")
  end
  if on(CMIEmployeesSummaryPage).empty_referrals.nil?
    if on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.count > 0
      on(CMIEmployeesSummaryPage) do |page|
        counter = page.referrals_panel.count
        if counter > 0
          counter.times do
            panel = page.referrals_panel.find { |p| p.blue_streak_seal? == true }
            if !panel.nil?
              panel.blue_streak_seal = true
              panel.reason_for_applying_seal = 'test'
              panel.seal_authorized_by = 0
              panel.apply_seal
              page.wait_for_processing_overlay_to_close
              page.wait_for_ajax
              page.scroll.to :top
            end
            if panel.nil?
              panel = page.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == "AWAITING REVIEW" } }
              if !panel.nil?
                counter = panel.referrals.count
                counter.times do
                  panel = page.referrals_panel.find { |panel| panel.referrals.find { |question| question.status == "AWAITING REVIEW" } }
                  if !panel.nil?
                    question = panel.referrals.find { |question| question.status == "AWAITING REVIEW" }
                    question.review
                    question.span(text: 'Approve').double_click
                    question.comments = "test"
                    question.save
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).issue
  on(AutoPolicySummaryPage).navigate_issue_wizard
end

Then(/^I open the Trailer Information modal$/) do
  on(AutoPolicySummaryPage) do |page|
    page.watercraft_vehicle_panel.add_trailer
  end
end

Then(/^I validate select existing party dropdown on watercraft drivers modal$/) do
  on(PolicyManagementPage) do |page|
    modal = page.watercraft_operator_modal
    organization_name = @added_applicant["organization_name"]
    select_list = modal.existing_party.options true
    expect(select_list.include?(organization_name)).to be_falsey
  end
end

And(/^I validate save and add another watercraft button on "([^"]*)" modal$/) do |modal|
  on(PolicyManagementPage) do |page|
    modal = page.send("#{modal.snakecase}_modal")
    expect(modal.save_and_add_another_watercraft?).to be_truthy
  end
end

Then(/^I validate tooltip messages for motor disabled fields on "([^"]*)" modal$/) do |modal|
  on(PolicyManagementPage) do |page|
    modal = page.send("#{modal.snakecase}_modal")
    modal.has_motor = 'yes'
    modal.motor_type = 1
    modal.motor_year_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_serial_number_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_make_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.physical_damage_limit_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_model_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.engine_size_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').present?).to be_falsey

    modal.motor_type = 2
    modal.motor_year_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_serial_number_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_make_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.physical_damage_limit_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_model_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.engine_size_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').present?).to be_falsey

    modal.motor_type = 4
    modal.motor_year_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_serial_number_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_make_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.physical_damage_limit_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.motor_model_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
    page.hull_and_motor_information_modal.engine_size_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("This information does not apply to the type of motor selected.")
  end
end


Then(/^I validate motor identification number$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.watercraft_vehicle_panel
    panel.vehicles.first.view_motors
    expect(panel.make_modal_text_element.small.text).to eq(@motor_serial_number = data_for('hull_and_motor_information_modal')['motor_serial_number'])
  end
end

Then(/^I verify view motors and hide motors button$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.watercraft_vehicle_panel
    expect(panel.vehicles.first.view_motors?).to be_truthy
    panel.vehicles.first.view_motors
    expect(panel.vehicles.first.hide_motors?).to be_truthy
  end
end

Then(/^I validate that deductible column is not present in motor details$/) do
  on(AutoPolicySummaryPage) do |page|
    panel = page.watercraft_vehicle_panel
    panel.vehicles.first.view_motors
    expect(panel.motor_deductible_column?).to be_falsey
  end
end

And(/^I add a product using (.*) fixture$/) do |fixture_file|
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  @first_product = data_for('add_product_modal')
  on_current_page do |page|
    modal = page.add_product_modal
    modal.populate_with(@first_product)
    modal.save_and_begin_quote_element.click
    #page.wait_for_processing_overlay_to_close

    #address scrubbing is called in address_details= used by fixture
    #modal.address_scrubber_alert.scroll.to
    #modal.user_entered_element.preceding_sibling.click
  end
end