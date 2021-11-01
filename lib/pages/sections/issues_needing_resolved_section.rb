# frozen_string_literal: true

class IssuesToResolvedPersonalAuto < BaseSection
  button(:resolve)
end

class IssuesNeedingResolvedSection < BaseSection
  sections(:issues_to_resolve_personal_auto, IssuesToResolvedPersonalAuto, xpath: './/div[contains(@class, "sidebar-content")]/div', item: {xpath: './/div[contains(@class,"issue-section")]'})

  def find_issue_needing_resolved(issue_text)
    issues_to_resolve_personal_auto.find { |issue_row| issue_row.text.downcase.include? issue_text.downcase }
  end

  def issue_needing_resolved_exists(issue_text)
    issues_to_resolve_personal_auto.any? { |issue_row| issue_row.text.downcase.include? issue_text.downcase }
  end
end
