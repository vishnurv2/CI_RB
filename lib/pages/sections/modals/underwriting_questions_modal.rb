# frozen_string_literal: true


class UnderwritingQuestionsModal < BaseModal
  button(:save_and_close, name: /^SaveAndClose/, hooks: WFA_HOOKS)
  button(:save_and_continue, id: 'dynamicModalDefaultButton', hooks: WFA_HOOKS)
  checkbox(:agree_to_all_questions, id: 'QuestionsReviewedAndAnswered_2_')
  checkbox(:agree_to_all_questions_auto, id: 'QuestionsReviewedAndAnswered_7_')

  def answer_all(answer)
    labels(text: answer).each(&:click)
  end
end
