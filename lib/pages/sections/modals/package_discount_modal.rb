# frozen_string_literal: true

class PackageDiscountModal < ReportResultsModal
  CLICK_SET = lambda do |name, cont, value|
    ele = cont.send("#{name}_element")
    ele.set? == value ? ele.assert_enabled : ele.click!
  end
  checkbox(:add_discount, id: 'Add', assign_method: CLICK_SET)
  date_field(:effective_date, id: 'EffectiveDate')
  textarea(:note, id: 'Note', hooks: WFA_HOOKS)

  span(:validation_message, class: 'field-validation-error')

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
