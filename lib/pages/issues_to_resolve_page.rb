# frozen_string_literal: true

class IssuesToResolvePage < PolicyManagementPage
  section(:issues_needing_resolved_section, IssuesNeedingResolvedSection, xpath: '//app-issues-to-resolve/p-panel/div')

  def wait_for_modal(modal)
    Watir::Wait.until { modal.present? }
    wait_for_ajax
    raise_page_errors "waiting for modal #{modal.symbol} to appear"
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
