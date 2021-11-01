# frozen_string_literal: true

class PolicyLossesRow < BaseSection
  checkbox(:mark_for_dispute, hooks: WFA_HOOKS)
  # link(:delete, href: /DeletePolicyLoss/) # this is the trash icon for manually added losses
  # span(:delete_button, title: 'Delete Loss') # this is the old trash can, went back to links
  link(:delete_button, class: 'PolicyLossesInfoTableDisputeColumnDeleteIcon')

  span(:date, name: 'PolicyLossesInfoTableDateColumnText')
  span(:report, name: 'PolicyLossesInfoTableReportColumnText')
  span(:claim_type, name: 'PolicyLossesInfoTableClaimTypeColumnText')
  span(:amount_paid, name: 'PolicyLossesInfoTableAmountPaidColumnText')

  def delete
    delete_button_element.click
  end

  def to_h
    { date: date, report: report, claim_type: claim_type, amount_paid: amount_paid }
  end

  def mark_for_dispute=(t_or_f)
    Watir::Wait.until { mark_for_dispute_element.present? }
    mark_for_dispute_element.set t_or_f
  end
end

class DriverLossesRow < BaseSection
  checkbox(:mark_for_dispute, hooks: WFA_HOOKS)
  span(:date, name: 'DriverLossesInfoTableLossDateColumnText')
  span(:report, name: 'DriverLossesInfoTableLossReportColumnText')
  select_list(:driver_assignment, id: /DriverLossesInfoTableDriverColumnDropdown_/)
  span(:claim_type, name: 'DriverLossesInfoTableClaimTypeColumnText')
  span(:amount_paid, name: 'lDriverLossesInfoTableAmountPaidColumnText')
  span(:description, name: 'DriverLossesInfoTableDescriptionColumnText')

  def assign_first_driver
    self.driver_assignment = 1
  end
end

class PolicyLossesDisputeRow < BaseSection
  textarea(:dispute_reason, id: /^PolicyLossesInfoTableOtherDisputeReasonColumnTextbox_/, hooks: WFA_HOOKS)
end

class UnassignedLossesDisputeRow < BaseSection
  select_list(:dispute_reason, id: /DriverLossesInfoTableDisputeReasonColumnDropdown_/, hooks: WFA_HOOKS)
end

class ClueLossesModal < ReportResultsModal
  data_grid(:policy_losses, PolicyLossesRow, item: { xpath: './/tbody/tr[not(@id)]' }) # was "policy_losses_table" prior to angular AMN 1-22-2020
  data_grid(:policy_losses_dispute_reasons, PolicyLossesDisputeRow, item: { id: /tr_PolicyLossesInfoTableDisputeReasonRow_/ }) # was "policy_losses_dispute_reasons_table" prior to angular AMN 1-22-2020
  data_grid(:unassigned_driver_losses, DriverLossesRow, index: 1, item: { xpath: './/tbody/tr[not(@id) and not(contains(@class, \'row-remove\'))]', visible: true }) # was "unassigned_driver_losses_table" prior to angular AMN 1-22-2020
  data_grid(:unassigned_losses_dispute_reasons, UnassignedLossesDisputeRow, index: 1, item: { id: /tr_DriverLossesInfoTableDisputeReasonRow_/ }) # was "unassigned_losses_dispute_reasons_table" prior to angular AMN 1-22-2020

  button(:apply_to_quote, name: 'SaveAndContinue')

  def find_pl_by_date_and_type(date, type)
    date = Chronic.parse(date) if date.is_a?(String)
    policy_losses.find { |l| l.date == date.strftime('%m/%d/%Y') && l.claim_type.include?(type) }
  end

  def delete_pl_by_date_and_type(date, type)
    find_pl_by_date_and_type(date, type).delete
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end

  def policy_losses_hash
    policy_losses.map(&:to_h)
  end

  def first_unassigned_driver_loss
    Watir::Wait.until { unassigned_driver_losses.items.count.positive? }
    unassigned_driver_losses.items.first
  end
end
