class ReviewReferralsModal < BaseModal
  textarea(:comments_area, id: /commonComments/)
  button(:approve, class: /p-button-success/)
  button(:decline, class: /p-button-danger/)
end