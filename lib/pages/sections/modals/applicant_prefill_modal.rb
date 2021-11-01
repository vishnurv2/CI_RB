# frozen_string_literal: true

class ApplicantPrefillModal < BaseModal
  # span(:save_and_continue, text: 'Save & Continue', default_method: :click!)
  # #
  # def next_modal
  #   parent_container.send_keys :tab
  #   Watir::Wait.until(timeout: 5) { save_and_continue? }
  #   save_and_continue
  #   binding.pry
  #   parent_container.wait_for_ajax
  # end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
