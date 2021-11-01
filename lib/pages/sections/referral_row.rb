# frozen_string_literal: true

class ReviewSection < BasePanel
  # Not quite working
  select_button_set(:approval_status, id: 'btnApprovalstatus')
  button(:save, xpath: './/p-button[@name="Save"]/button', hooks: WFA_HOOKS)
  button(:cancel, xpath: './/p-button[@name="Cancel"]/button')
  textarea(:comments, name: 'comments')
  #on(CMIEmployeesSummaryPage).referrals_panel.first.referrals.last.text
end

class ReferralRow < EDSL::PageObject::Section
  section(:review_section, ReviewSection, xpath: './../../../..//div[contains(@class,"p-panel-content")]//div[contains(@class,"panelContent")]', how: :div)

  ## a lot of this stuff I moved to the Review Section
  span(:message, class: /text-description/)
  span(:status, xpath: './/div/p-overlaypanel/../span')#class: /status-text/)
  button(:review, xpath: './/p-button[@label="Review"]/button')
  i(:review_icon_right, class: 'review-icon fas fa-angle-right')
  i(:review_icon_down, class: 'review-icon fas fa-angle-down')
  button(:save, xpath: './/p-button[@name="Save"]/button', hooks: WFA_HOOKS)
  button(:cancel, xpath: './/p-button[@name="Cancel"]/button')
  textarea(:comments, name: 'comments')
  select_button_set(:approval_status, id: 'btnApprovalstatus')
  checkbox(:referral_checkbox, id: /chkReferral/)

  def reviewed
    reviewed_raw.tr("\n", ' ')
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end
