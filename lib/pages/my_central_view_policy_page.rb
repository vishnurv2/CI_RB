# frozen_string_literal: true

class MyCentralViewPolicyPage < BasePage
  page_url "https://saturn.central-insurance.com/myCentral/Responsive/ViewPolicy.aspx"

  div(:back_button, id: /back_contentContainer/)
  div(:policy_details_expand, id: /cardAccountPolicies_header/)
  i(:policy_history_pdf_icon, class: 'fas fa-file-pdf')
  span(:policy_history_date, id: /lblHistoryDate/)
  span(:policy_history_type, id: /lblHistoryType/)
  span(:policy_history_amended, id: /lblHistoryAmended/)
  span(:policy_status, id: /lblPolicyStatus/)
  #2nd row
  i(:policy_history_pdf_icon_1, xpath: '//a[contains(@href, "docId=1")]/i')
  span(:policy_history_date_1, id: /01_lblHistoryDate/)
  span(:policy_history_type_1, id: /01_lblHistoryType/)
  span(:policy_history_amended_1, id: /01_lblHistoryAmended/)
end
