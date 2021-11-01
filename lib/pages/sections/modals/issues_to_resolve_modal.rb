# frozen_string_literal: true

class IssueList < ::BaseSection
  i(:chevron_right, class: /fa-chevron-right/)
end

class IssuesToResolveModal < BaseModal
  button(:close, xpath: '//p-button[contains(@id, "Close")]/button', hooks: WFA_HOOKS)
  data_grid(:issues_list, IssueList)
  i(:chevron_right, class: /fa-chevron-right/)
  div(:error_validation, class: /issue-section/)
  div(:mvr_report, xpath: '//span[contains(text(), "Mvr Report not completed")]/parent::div/parent::div/parent::div')
end
