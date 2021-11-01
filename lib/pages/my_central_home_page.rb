# frozen_string_literal: true

class MyCentralHomePage < BasePage
  page_url "https://saturn.central-insurance.com/myCentral/Responsive/Index.aspx?"

  h2(:contact_agent, text: /Contact Agent/)
  link(:agency_service_name, xpath: '//h2[text()="Contact Agent"]/following-sibling::a')
  link(:telephone_number, href: /tel/)
  link(:mail, href: /mailto/)
  link(:agency_service_link, xpath: '//h2[text()="Contact Agent"]/../div/a[contains(@href,"http")]')

  link(:view_my_policy, xpath: '//div[@class="container"]//a[contains(@href, "ViewPolicy")]')
  link(:billing_and_payments, xpath: '//div[@class="container"]//a[contains(@href, "BillingAndPayments")]')
end
