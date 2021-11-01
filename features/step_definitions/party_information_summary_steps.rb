# frozen_string_literal: true

Then(/^I should see parties in the table$/) do
  expect(on(PartyInformationSummaryPage).tr(xpath: './/tbody/tr[not(contains(@class, "ui-widget-header"))]').present?).to be_truthy, "Expected to Find a Party Row in the Table, Excluding the Header Rows, But One Could Not Be Found"
end

# ------ Everything below this line is unverified ------------------------------------- #

And(/^I begin the issuance of the policy$/) do
  on(QuoteManagementPage).begin_issuance
end

Then(/^I should see the party in the included parties panel$/) do
  on(PartyInformationSummaryPage) do |page|
    name = data_for('included_parties_panel')['name']
    role = data_for('included_parties_panel')['role']
    expect(page.included_parties_panel.find_party(name, role)).not_to be_nil, "Expected a row with a name starting with \"#{name}\" and a role of \"#{role}\" to exist in the included parties table but it was not found"
  end
end

And(/^I add the party for the (.*)$/) do |fixture_file|
  #Helpers::Fixtures.load_fixture(fixture_file.snakecase)
  RubyExcelHelper.safe_load_fixture_file(fixture_file)
  on(PartyInformationSummaryPage).add_party data_for('included_parties_panel')['role']
end

And(/^I add the party$/) do
  on(PartyInformationSummaryPage).add_party data_for('included_parties_panel')['role']
end

And(/^I edit the party$/) do
  on(PartyInformationSummaryPage).included_parties_panel.find_party(data_for('included_parties_panel')['name'], data_for('included_parties_panel')['role']).edit
end

Then(/^the appropriate "([^"]*)" party modal should be visible$/) do |panel_name|
  on(PartyInformationSummaryPage) do |page|
    modal_name = "#{data_for("#{panel_name}_parties_panel")['role'].snakecase}_party_modal"
    modal = page.send(modal_name)
    expect(!modal.nil? && modal.present?).to be_truthy, "Expected PartyInformationSummaryPage.#{modal_name} to be present, but it was not"
  end
end

When(/^I add a role$/) do
  on(PartyInformationSummaryPage) do |page|
    added_role = data_for('added_role')
    role = added_role['role']
    page.send("#{data_for('included_parties_panel')['role'].snakecase}_party_modal").add_role(role, added_role["#{role.snakecase}_role_info"])
  end
end

Then(/^I should see the role I added$/) do
  on(PartyInformationSummaryPage) do |page|
    name = data_for('included_parties_panel')['name']
    role = data_for('included_parties_panel')['role']
    added_role = data_for('added_role')['role']
    expect(page.included_parties_panel.find_party(name, [role, added_role])).not_to be_nil, "Expected to find a party in the grid with the name #{name} and the roles #{role} and #{added_role}"
  end
end

Then(/^The saved driver on Account Overview will have the role "(.*)"$/) do |role|
  on(AccountSummaryPage) do |page|
    actual_role = page.applicants_panel.applicants.last.contact.split(',').last.strip
    expect(role.downcase).to eq(actual_role.downcase), "Expected the added driver to have the role: \"#{role}\", but found \"#{actual_role}\""
  end
end

Then(/^The saved driver will have the role "(.*)"$/) do |role|
  on(PartyInformationSummaryPage) do |page|
    party = page.included_parties_panel.parties.find { |p| p.name.start_with? @saved_driver }
    expect(party).not_to be_nil, "Expected to find a party with a name starting with \"#{@saved_driver}\" but did not"
    expect(party.contains_role?(role)).to be_truthy, "Expected the #{@saved_driver} party to include the \"#{role}\" role but it did not, the roles found were #{party.roles}"
  end
end

Then(/^I (should|should not) see the disabled trashcan with an error message$/) do |should_or_not|
  on(PartyInformationSummaryPage) do |page|
    trashcan = page.included_parties_panel.disabled_trashcan_element
    RSpec.capture_assertions do
      expect(trashcan.present? == (should_or_not == 'should')).to be_truthy, "Expected the Party Information Summary Page's included parties panel#{should_or_not.gsub 'should', ''} to include a disabled trashcan icon"
      (expect(trashcan.title.start_with?('Party is the last')).to be_truthy, "Expected the Party Information Summary Page's included parties panel's disabled trash can's title to start with the text 'Party is the last'") if should_or_not == 'should' && trashcan.present?
    end
  end
end

And(/^I start to add the party$/) do
  on(PartyInformationSummaryPage).start_to_add_party
end

Then(/^I (should|should not) see the trust party information fields$/) do |should_or_not_str|
  on(PartyInformationSummaryPage) do |page|
    modal = page.trust_party_modal
    not_str = should_or_not_str.remove 'should'
    should_or_not = should_or_not_str == 'should'
    RSpec.capture_assertions do
      expect((modal.name? && modal.name_element.present?) == should_or_not).to be_truthy, "Expected#{not_str} to see the name text box on the trust party modal"
      expect((modal.also_known_as? && modal.also_known_as_element.present?) == should_or_not).to be_truthy, "Expected#{not_str} to see the name text box on the trust party modal"
      expect((modal.email? && modal.email_element.present?) == should_or_not).to be_truthy, "Expected#{not_str} to see the name text box on the trust party modal"
      expect((modal.phone_number? && modal.phone_number_element.present?) == should_or_not).to be_truthy, "Expected#{not_str} to see the name text box on the trust party modal"
    end
  end
end

And(/^I should not be able to remove the applicant$/) do
  on(PartyInformationSummaryPage) do |page|
    role_info = page.applicant_party_modal.applicant_role_info
    account_applicant_title_text = 'This is the last applicant on the account and cannot be removed until another applicant is added.'
    policy_applicant_title_text = 'This is the last applicant on the policy and cannot be removed until another applicant is added.'
    RSpec.capture_assertions do
      expect(role_info.account_level_applicant_element.attribute('class').include? 'cmi-toggle-btn-disabled').to be_truthy(), "Expected the Account Applicant button on the Applicant's role info tab to be disabled but it was not"
      expect(role_info.policy_applicant_element.attribute('class').include? 'cmi-toggle-btn-disabled').to be_truthy(), "Expected the Policy Applicant button on the Applicant's role info tab to be disabled but it was not"
      expect(role_info.account_level_applicant_element.parent.attribute('title').include? account_applicant_title_text).to be_truthy(), "Expected the Account Applicant button on the Applicant's role info tab's title to include '#{account_applicant_title_text}' but it did not"
      expect(role_info.policy_applicant_element.parent.attribute('title').include? policy_applicant_title_text).to be_truthy(), "Expected the Account Applicant button on the Applicant's role info tab's title to include '#{policy_applicant_title_text}' but it did not"
    end
  end
end


When(/^I edit the first party in the "([^"]*)" parties panel$/) do |panel_name|
  on(PartyInformationSummaryPage) do |page|
    row = page.send("#{panel_name.snakecase}_parties_panel").parties.items.first
    row.scroll.to
    row.edit_other
  end
end

Then(/^I should see the party in the (included|other) parties panel using the data for "([^"]*)"$/) do |panel_name, data_entry|
  party = data_for(data_entry)["#{panel_name}_parties_panel"]
  panel = on(PartyInformationSummaryPage).send("#{panel_name}_parties_panel")
  expect(panel.find_party(party['name'], party['role'])).not_to be_nil, "Expected to find a party matching #{party}, but it was not found"
end

Then(/^The Party Information Summary controls should be disabled$/) do
  on(PartyInformationSummaryPage) do |page|
    RSpec.capture_assertions do
      expect(page.label(text: 'Role Type').present?).to be_falsey, 'Expected not to see a Role Type label, but it was present'
      expect(page.included_parties_panel.parties.items.first.edit_element.present?).to be_falsey, 'Expected not to see an edit span on the first included party, but it wsa present'
    end
  end
end

Then(/^I select party type as "([^"]*)" and verify the role options$/) do |party_type, table|
  expected = table.rows.flatten
  on(AccountSummaryPage) do |page|
    if !page.applicants_panel.add_party_modal?
      page.applicants_panel.add_applicant_button
      Watir::Wait.until(timeout: 30) { page.applicants_panel.menu? }
      page.applicants_panel.add_party_menu if page.applicants_panel.add_party_menu?
      Watir::Wait.until(timeout: 30) { page.applicants_panel.add_party_modal? || parent_container.errors? }
    end
    modal = page.applicants_panel.add_party_modal
    modal.select_add_party_type = party_type
    modal.role.click
    select_list = page.div(class: /p-dropdown-items/).lis.map(&:text)
    # select_list = modal.role.options
    RSpec.capture_assertions do
      expected.each do |value|
        expect(select_list.include?(value)).to be_truthy, "Option #{value} not found"
      end
    end
  end
end

Then(/^I select party type as "([^"]*)" and verify disabled options$/) do |party_type|
  on(AccountSummaryPage) do |page|
    if !page.applicants_panel.add_party_modal?
      page.applicants_panel.add_applicant_button
      Watir::Wait.until(timeout: 30) { page.applicants_panel.menu? }
      page.applicants_panel.add_party_menu if page.applicants_panel.add_party_menu?
      Watir::Wait.until(timeout: 30) { page.applicants_panel.add_party_modal? || parent_container.errors? }
    end
    modal = page.applicants_panel.add_party_modal
    modal.select_add_party_type = party_type
    modal.role_element.click
    expect(page.div(class: /p-dropdown-items-wrapper/).div(id: 'DriverRoleOption').parent.classes.include? 'p-disabled').to be_truthy
    expect(page.div(class: /p-dropdown-items-wrapper/).div(id: 'TrusteeRoleOption').parent.classes.include? 'p-disabled').to be_truthy
    end
end