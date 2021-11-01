# frozen_string_literal: true

class AlertsSideBar < BaseSection
  section(:issues_needing_resolved_section, IssuesNeedingResolvedSection, xpath: '//app-issues-to-resolve/div')

  img(:happy_alert_bell, xpath: '//img[@src="assets/images/happy-alert-bell.svg"]')
  span(:no_issues_title, class: /no-issues-title/)
  span(:no_issues_subtext, class: /no-issues-sub-text/)

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
