# frozen_string_literal: true

class AddressScrubbingAlertSection < EDSL::PageObject::Section
  button(:use_suggested, text: 'Use Suggested Address')
  button(:use_entered, text: 'Use As Entered', default_method: :click!)
  button(:remain_and_correct, text: 'Edit', default_method: :click!)
  button(:confirm_selection, text: 'Confirm Selection')

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end
