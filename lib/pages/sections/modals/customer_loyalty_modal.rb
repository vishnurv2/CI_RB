# frozen_string_literal: true

class CustomerLoyaltyModal < ReportResultsModal
  select(:loyalty_amount, id: 'OverrideValue')
  date_field(:effective_date, id: 'EffectiveDate')
  textarea(:note, id: 'OverrideNotes', hooks: WFA_HOOKS)

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
