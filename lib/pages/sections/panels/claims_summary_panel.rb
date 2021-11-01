# frozen_string_literal: true

class ClaimsRow < ::BaseSection

end

class ClaimsSummaryPanel < BasePanel

  PAGE_WAIT_HOOKS ||= CptHook.define_hooks do
    before(:click).call(:wait_until_visible)
  end

  sections(:claims, ClaimsRow, how: :tbody, index: 0, item: { how: :trs, role: 'row' })
  link(:report_a_claim, text: /Report a Claim/, hooks: PAGE_WAIT_HOOKS)
  ul(:claims_button_list, xpath: '//ul[@class = "dropdown-menu"]')

  def wait_until_visible
    wait_for_ajax
    Watir::Wait.until(timeout: 60) { report_a_claim? }
  end

  def force_report_claim_click
    report_a_claim.click!
  end
end
