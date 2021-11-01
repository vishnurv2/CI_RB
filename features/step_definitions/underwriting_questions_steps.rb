# frozen_string_literal: true

Then(/^The unflagged underwriting question answers should be "([^"]*)"$/) do |answer|
  on(UnderwritingQuestionsSummaryPage) do |page|
    RSpec.capture_assertions do
      if page.all_products_questions.present?
        page.all_products_questions.questions_grid.each do |item|
          expect(item.answer_selected).to eq(answer) unless !item.question_element.present? || item.flag?
        end
      end
    end
  end
end

Then(/^I verify product wise rows for UW questions$/) do
  on(UnderwritingQuestionsSummaryPage) do |page|
    expect(page.watercraft_questions.present?).to be_truthy
    expect(page.scheduled_property_questions.present?).to be_truthy
    expect(page.home_questions.present?).to be_truthy
  end
end

When(/^I answer the underwriting questions "([^"]*)" using (.*) fixture$/) do |ans, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for('uw_question_panel')
  on(UnderwritingQuestionsSummaryPage) do |page|
    if page.all_products_questions.present?
      page.all_products_questions.save_and_edit unless !page.all_products_questions.disabled?
      page.all_products_questions.questions_grid.each do |item|
        item.answer = ans unless !item.question_element.present?
        if !item.products.empty?
          item.products.first.product.click
          item.products.first.product.set(data['product'])
        end
        item.policy_numbers.first.policy_number_element.set(data['policy_number']) unless item.policy_numbers.empty?
        item.descriptions.first.description_element.set(data['description']) unless item.descriptions.empty?
      end
      page.all_products_questions.acknowledge.click
      page.all_products_questions.save_and_edit
    end
  end
end

Then(/^The unflagged umbrella underwriting question answers should be their default values$/) do
  on(UnderwritingQuestionsSummaryPage) do |page|
    RSpec.capture_assertions do
      page.umbrella_questions.questions_grid.each do |item|
        expect(item.answer_selected).to eq("No") unless !item.question_element.present? || item.flag?
      end
    end
  end
end

Then(/^The unflagged "([^"]*)" underwriting question answers should be "([^"]*)"$/) do |type, answer|
  on(UnderwritingQuestionsSummaryPage) do |page|
    RSpec.capture_assertions do
      page.send("#{type}_questions".snakecase).questions_grid.each do |item|
        expect(item.answer_selected).to eq(answer) unless !item.question_element.present? || item.flag?
      end
    end
  end
end

When(/^I answer the auto underwriting questions "([^"]*)" using (.*) fixture$/) do |ans, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for('uw_question_panel')
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.auto_questions.save_and_edit unless !page.auto_questions.disabled?
    page.auto_questions.questions_grid.each do |item|
      item.answer = ans unless !item.question_element.present?
      item.descriptions.first.description_element.set(data['description']) unless item.descriptions.empty?
      item.does_nanny_have_auto_insurance = ans unless !item.question_element.present? || !item.question.include?('nanny')
      item.does_nanny_operate_insured_vehicle = ans unless !item.question_element.present? || !item.question.include?('nanny') || !item.does_nanny_have_auto_insurance_text.include?('Yes')
      item.driver_suspended_revoked = 0 if item.driver_suspended_revoked_element.present?
      item.date_of_suspended_revoked = DataMagic.today if item.date_of_suspended_revoked_element.present?
      item.reason_for_suspension = "Rough Driving" if item.reason_for_suspension_element.present?
    end
    page.auto_questions.acknowledge.click
    page.auto_questions.save_and_edit
  end
end

When(/^I answer the underwriting questions$/) do
  # on(PolicyManagementPage).left_nav.navigate_to('Underwriting Questions')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    if page.all_products_questions.present?
      page.all_products_questions.acknowledge = true
      page.all_products_questions.save_and_edit
      page.wait_for_ajax
    end

    if page.auto_questions.present?
      page.auto_questions.acknowledge = true
      page.auto_questions.save_and_edit
      page.wait_for_ajax
    end
  end
end

When(/^I answer the umbrella underwriting questions "([^"]*)" using (.*) fixture$/) do |ans, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for('uw_question_panel')
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.umbrella_questions.save_and_edit unless !page.auto_questions.disabled?
    page.umbrella_questions.questions_grid.each do |item|
      item.answer = ans unless !item.question_element.present?
      item.dog_breed = ans unless !item.question_element.present? || !item.question.include?('dogs')
      item.injury_to_person = ans unless !item.question_element.present? || !item.question.include?('dogs')
      item.approved_fence = ans unless !item.question_element.present? || !item.question.include?('swimming pool')
      item.diving_board_slide_or_inflatable = ans unless !item.question_element.present? || !item.question.include?('pond or lake')
      item.am_best_rating = ans unless !item.question_element.present? || !item.question.include?('underlying coverage with another carrier')
      item.descriptions.first.description_element.set(data['description']) unless item.descriptions.empty?
      item.date_section.first.date_of_loss = data['date_of_loss'] unless item.date_section.empty?
      item.select_type_section.first.type_of_loss.set(data['type_of_loss']) unless item.select_type_section.empty?
      item.currency_section.first.loss_amount = data['loss_amount'] unless item.currency_section.empty?
    end
    page.umbrella_questions.acknowledge.click
    page.umbrella_questions.save_and_edit
  end
end

When(/^I answer the umbrella underwriting questions "([^"]*)"$/) do |ans|
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.umbrella_questions.save_and_edit unless !page.umbrella_questions_element.element(xpath: './/p-radiobutton/div').classes.include? 'p-radiobutton-disabled'
    page.scroll.to :top
    page.umbrella_questions.questions_grid.each do |item|
      item.answer = ans unless !item.question_element.present?
    end
    page.umbrella_questions.acknowledge.click
    page.umbrella_questions.save_and_edit
  end
end

When(/^I answer all the auto underwriting questions$/) do
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    if page.all_products_questions.present?
      page.all_products_questions.acknowledge = true
      page.all_products_questions.save_and_edit
      page.wait_for_ajax
    end

    counter = page.auto_questions_panels.count
    if counter > 0
      counter.times do
        panel = page.auto_questions_panels.find { |p| p.acknowledge? == true && p.save_element.present? }
        panel.acknowledge = true
        sleep(0.5) #Had to put hard wait because it was checking and unchecking the checkbox
        panel.save_and_edit_element.double_click
        page.wait_for_processing_overlay_to_close
        page.wait_for_ajax
        page.scroll.to :top
      end
    end
  end
end

When(/^I answer all the underwriting questions$/) do
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Quote Management')
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    if page.all_products_questions.present?
      page.all_products_questions.acknowledge = true
      page.all_products_questions.save_and_edit
      page.wait_for_ajax
    end
    page.issues_to_resolve_home
    page.issues_to_resolve_watercraft
    page.issues_to_resolve_scheduled_property
    page.issues_to_resolve_umbrella
    page.issues_to_resolve_summit_auto
    page.issues_to_resolve_signature_auto
    page.issues_to_resolve_dwelling
    counter = page.auto_questions_panels.count
    if counter > 0
      counter.times do
        panel = page.auto_questions_panels.find { |p| p.acknowledge? == true && p.save_and_edit_element.present? }
        panel.acknowledge = true
        sleep(0.5) #Had to put hard wait because it was checking and unchecking the checkbox
        panel.save_and_edit_element.double_click
        page.wait_for_processing_overlay_to_close
        page.wait_for_ajax
        sleep(0.5)
        page.scroll.to :top
      end
    end
    on(PolicyManagementPage) do |page|
      unless page.page_header_text.include? "Account Summary"
        page.left_nav.navigate_to('Account Overview')
      end
    end
    # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  end
end

When(/^I answer the home underwriting questions "([^"]*)" for "([^"]*)" on premises$/) do |ans, condition|
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.home_questions.save_and_edit unless !page.auto_questions.disabled?
    page.home_questions.questions_grid.each do |item|
      if item.question_element.present?
        if item.question.include?(condition) == true
          item.dogs_on_premise = ans
          item.dog_breed = ans
        end
      end
    end
    page.home_questions.acknowledge.click
    page.home_questions.save_and_edit
  end
end

When(/^I answer the home underwriting questions "([^"]*)" for "([^"]*)" in the household$/) do |ans, condition|
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.home_questions.save_and_edit unless !page.auto_questions.disabled?
    page.home_questions.questions_grid.each do |item|
      if item.question_element.present?
        if item.question.include?(condition) == true
          item.exotic_pets = ans
          item.exotic_pets_text = 'shih tzu'
        end
      end
    end
    page.home_questions.acknowledge.click
    page.home_questions.save_and_edit
  end
end

When(/^I answer the home underwriting questions "([^"]*)" for "([^"]*)" storage tank on premises with (.*) fixture file$/) do |ans, condition, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for('uw_question_panel')
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.home_questions.save_and_edit unless !page.auto_questions.disabled?
    page.home_questions.questions_grid.each do |item|
      if item.question_element.present?
        if item.question.include?(condition) == true
          item.fuel_storage_tank = ans
          item.tank_location = data['tank_location']
          item.age_of_tank = data['age_of_tank']
          item.history_of_leaking = data['history_of_leaking']
          item.service_contract = data['service_contract']
        end
      end
    end
    page.home_questions.acknowledge.click
    page.home_questions.save_and_edit
  end
end

When(/^I answer the home underwriting questions "([^"]*)" for "([^"]*)" storage tank on premises with (.*) fixture file as no for leak and contract$/) do |ans, condition, fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  data = data_for('uw_question_panel')
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.home_questions.save_and_edit unless !page.auto_questions.disabled?
    page.home_questions.questions_grid.each do |item|
      if item.question_element.present?
        if item.question.include?(condition) == true
          item.fuel_storage_tank = ans
          item.tank_location = data['tank_location']
          item.age_of_tank = data['age_of_tank']
        end
      end
    end
    page.home_questions.acknowledge.click
    page.home_questions.save_and_edit
  end
end

When(/^I answer the home underwriting questions "([^"]*)" for "([^"]*)" residents in underwriting questions$/) do |ans, condition|
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.home_questions.save_and_edit unless !page.auto_questions.disabled?
    page.home_questions.questions_grid.each do |item|
      if item.question_element.present?
        if item.question.include?(condition) == true
          item.work_from_home_residents = ans
          item.type_of_business = 'Farming'
        end
      end
    end
    page.home_questions.acknowledge.click
    page.home_questions.save_and_edit
  end
end

When(/^I answer the home underwriting questions "([^"]*)" for "([^"]*)" in underwriting questions$/) do |ans, condition|
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.home_questions.save_and_edit unless !page.auto_questions.disabled?
    page.home_questions.questions_grid.each do |item|
      if item.question_element.present?
        if item.question.include?(condition) == true
          item.flooding_fire_landslide = ans
          item.explanation_for_hazard = 'Storm'
        end
      end
    end
    page.home_questions.acknowledge.click
    page.home_questions.save_and_edit
  end
end

When(/^I answer the watercraft underwriting questions "([^"]*)" to all the questions$/) do |ans|
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.watercraft_questions.save_and_edit unless !page.auto_questions.disabled?
    page.watercraft_questions.questions_grid.each do |item|
      item.answer = ans unless !item.question_element.present?
    end
  end
end

Then(/^I verify explanation field is present for all question$/) do
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.watercraft_questions.questions_grid.each do |item|
      if item.question.include?('Propelled or Powered, Amphibious Vehicle,')
        break
      else
        explanation_field_found = item.explanation_fields?
        expect(explanation_field_found).to be_truthy
      end
    end
  end
end

When(/^I answer the umbrella underwriting question of "([^"]*)" as "([^"]*)" in underwriting questions$/) do |condition, ans|
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.umbrella_questions.save_and_edit unless !page.auto_questions.disabled?
    page.umbrella_questions.questions_grid.each do |item|
      if item.question_element.present?
        if item.question.include?(condition) == true
          item.send("#{condition.downcase.snakecase}=", ans)
        end
      end
    end
  end
end

Then(/^I verify that the explanation field is present$/) do
  on(UnderwritingQuestionsSummaryPage) do |page|
    explanation_field_found = page.umbrella_questions.explanation_field?
    expect(explanation_field_found).to be_truthy
  end
end

When(/^I answer the all products underwriting question of "([^"]*)" as "([^"]*)" in underwriting questions$/) do |condition, ans|
  on(UnderwritingQuestionsSummaryPage) do |page|
    page.all_products_questions.save_and_edit unless !page.auto_questions.disabled?
    page.all_products_questions.questions_grid.each do |item|
      if item.question_element.present?
        if item.question.include?(condition) == true
          item.send("#{condition.downcase.snakecase}=", ans)
        end
      end
    end
  end
end

Then(/^I verify that the explanation field is present in all product section$/) do
  on(UnderwritingQuestionsSummaryPage) do |page|
    explanation_field_found = page.all_products_questions.explanation_field?
    expect(explanation_field_found).to be_truthy
  end
end

Then(/^I validate that any other products question is not present anymore$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    if page.all_products_questions.present?
      question = page.all_products_questions.questions_grid.find { |i| i.question.include? 'Other than this account, is there any other insurance provided with Central?' if i.question? }
      expect(question).to be_nil
    end
  end
end

Then(/^I validate that household member in military service question is not present anymore$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.auto_questions.questions_grid.find { |i| i.question.include? 'Any household member in military service?' if i.question? }
    expect(question).to be_nil
  end
end

Then(/^I validate format of "([^"]*)" under home uw questions$/) do |text|
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.home_questions.questions_grid.find { |i| i.question.downcase.include? text.downcase if i.question? }
    question.answer = 'Yes'
    expect(question.add_another?).to be_falsey
  end
end

Then(/^I validate age of tank under fuel storage question$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.home_questions.questions_grid.find { |i| i.question.include? 'Fuel Storage tank on the premise' if i.question? }
    question.answer = 'Yes'
    question.age_of_tank = 123
  end
end

Then(/^I validate are there any dogs kept on premises question$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.home_questions.questions_grid.find { |i| i.question.include? 'Are there any dogs kept on premises' if i.question? }
    question.answer = 'Yes'
    expect(question.any_dogs_kept_on_premises?).to be_truthy
  end
end

Then(/^I validate "([^"]*)" watercraft question$/) do |text|
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.watercraft_questions.questions_grid.find { |i| i.question.include? text if i.question? }
    expect(question).not_to be_nil
  end
end

Then(/^I validate all products underwriting question section is removed$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    expect(page.all_products_questions.present?).to be_falsey
  end
end

#WIP
Then(/^I validate work from home question$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.home_questions.questions_grid.find { |i| i.question.include? 'in-home business - including day/child care' if i.question? }
    question.answer = 'Yes'
    question.do_customers_come_to_home = 'Yes'
    expect(question.how_often?).to be_truthy
  end
end

Then(/^I validate "([^"]*)" watercraft question and its fields$/) do |text|
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.watercraft_questions.questions_grid.find { |i| i.question.include? text if i.question? }
    question.suspended_revoked = 'Yes'
    expect(question.date_and_circumstances_of_suspension_revocation?).to be_truthy
    expect(question.driver_with_license_suspended?).to be_truthy
  end
end

Then(/^I validate format of "([^"]*)" under spp uw questions$/) do |text|
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.scheduled_property_questions.questions_grid.find { |i| i.question.downcase.include? text.downcase if i.question? }
    question.answer = 'Yes'
    expect(question.add_another?).to be_falsey
  end
end

Then(/^I validate are any vehicles used for delivery question$/) do
  on(PolicyManagementPage) do |page|
    collapsed = page.left_nav.find_option("Quotes").attribute_value('class').split(" ")
    page.left_nav.find_option("Quotes").click if collapsed.include? "aria-collapsed"
    unless page.page_header_text == "Quote Management"
      page.left_nav.navigate_to('Quote Management')
    end
  end
  on(QuoteManagementPage).underwriting_questions_tab
  on(UnderwritingQuestionsSummaryPage) do |page|
    question = page.auto_questions.questions_grid.find { |i| i.question.include? 'Are any vehicles used for delivery?' if i.question? }
    question.answer = 'Yes'
    question.vehicles_used_for_rural_postal_delivery = 'Yes'
    question.vehicle_used = 0
  end
end