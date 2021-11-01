# frozen_string_literal: true

class ErrorModal < EDSL::PageObject::Section
  h4(:title, class: 'modal-title')
  div(:body, class: 'modal-body')
  button(:dismiss, class: 'close')
end
