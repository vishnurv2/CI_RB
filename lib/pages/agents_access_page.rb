# frozen_string_literal: true

class AgentCodeModal < BaseModal
  text_field(:agent_code, id: /ddlAgentTextBox/)
  text_field(:continue, xpath: './/input[@value="Continue"]')
end

class AgentsAccessPage < BasePage
  page_url "#{Nenv.base_url}/AgentsAccess"

  link(:pl_quote, id: /quickLinkQuotePersonalLinesEntSearch/)
  section(:agent_code_modal, AgentCodeModal, xpath: '//div[contains(@class,"modal-container") and .//span[contains(text(), "Enter the Agent Code")]]')
end
