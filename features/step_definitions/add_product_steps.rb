# frozen_string_literal: true

When(/^I check (automobile|residential|umbrella|scheduled property|watercraft|renters) on the add product modal$/) do |product|
  product = product.snakecase
  on(AccountSummaryPage) do |page|
    page.product_list.add_product unless page.add_product_modal?
    m = page.add_product_modal
    m.personal_products.send(product).add(1)
    m.save_and_begin_quote
  end
end

Then(/^the new product controls (should|should not) be visible on the add product modal$/) do |should_or_not|
  on(PolicyManagementPage) do |page|
    should_or_not_boolean = (should_or_not == 'should')
    expected_str = should_or_not.gsub('should', '')
    actual_str = 'should not'.gsub(should_or_not, '')
    RSpec.capture_assertions do
      expect(page.add_product_modal.state_element.present?).to eq(should_or_not_boolean), "Expected#{expected_str} to see the state field on the add product modal, but it could#{actual_str} be found"
      expect(page.add_product_modal.policy_effective_date_element.present?).to eq(should_or_not_boolean), "Expected#{expected_str} to see the state field on the add product modal, but it could#{actual_str} be found"
      expect(page.add_product_modal.policy_expiration_date_element.present?).to eq(should_or_not_boolean), "Expected#{expected_str} to see the state field on the add product modal, but it could#{actual_str} be found"
    end
  end
end

When(/^I select (automobile|residential|umbrella|scheduled property|watercraft|renters) on the add product modal$/) do |product|
  product = product.snakecase
  on(AccountSummaryPage) do |page|
    page.product_list.add_product unless page.add_product_modal?
    m = page.add_product_modal
    m.personal_products.send(product).add(1)
  end
end

Then(/^I verify sequencing of all selected products$/) do
  modal = on(PolicyManagementPage).send("#{which.snakecase}_modal")
  modal.create_account
  on(PolicyManagementPage).wait_for_ajax
  on(AccountSummaryPage) do |page|
    page.product_list.add_product unless page.add_product_modal?
    m = page.add_product_modal
    m.personal_products.automobile_element.click
    m.personal_products.residential_element.click
    m.personal_products.umbrella_element.click
    m.personal_products.scheduled_property_element.click
    m.personal_products.watercraft_element.click
    m.personal_products.dwelling_element.click
    expect(m.auto_select?).to be_truthy
    expect(m.home_select?).to be_truthy
    expect(m.dwelling_select?).to be_truthy
    expect(m.umbrella_select?).to be_truthy
    expect(m.spp_select?).to be_truthy
    expect(m.watercraft_select?).to be_truthy
  end
end

Then(/^I validate hover over message on add product modal$/) do
  on(AccountSummaryPage) do |page|
    page.product_list.add_product unless page.add_product_modal?
    m = page.add_product_modal
    m.state_eff_date_section.last.state_element.hover
    expect(page.div(class: 'p-tooltip p-component p-tooltip-right').text).to eq("Same state and effective date was selected above")
  end
end