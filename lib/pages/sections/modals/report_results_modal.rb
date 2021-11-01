# frozen_string_literal: true
#
class PolicyLosses < BaseSection
  checkbox(:mark_for_dispute, hooks: WFA_HOOKS)
  span(:report)
  td(:date, data_label: /Date Of Loss/)
  td(:claim_type, data_label: /Claim Type/)
  td(:status, data_label: /Status/)
  td(:amount_paid, data_label: /Amount Paid/)
  textarea(:dispute_remarks, xpath: '//textarea[@placeholder="Dispute Remarks"]')

  def to_h
    { date: date, report: report, claim_type: claim_type, amount_paid: amount_paid }
  end

  def mark_for_dispute=(t_or_f)
    Watir::Wait.until { mark_for_dispute_element.present? }
    mark_for_dispute_element.set t_or_f
  end
end

class ReportResultsModal < BaseModal
  checkbox(:dispute, id: /^PolicyLossesInfoTableDisputeColumnCheckbox_/)
  select_list(:reason, id: /^PolicyLossesInfoTableDisputeReasonColumnDropdown_/)
  button(:apply_to_quotes, xpath: './/p-button[@id="AcceptITV"]/button')
  button(:save_and_close_btn, xpath: './/p-button[@id="SaveandClose"]/button')
  i(:dismiss, xpath: './/i[contains(@class,"cursor-pointer")]')
  button(:modify_itv, xpath: './/p-button[@id="ModifyITV"]/button')
  #do a datagrid here.
  data_grid(:policy_losses, PolicyLosses)
end
