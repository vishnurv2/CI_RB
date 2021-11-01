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
  section(:review_section, ReviewSection, xpath: '//div[contains(@class,"p-toggleable-content")]', how: :div)
  #section(:review_section, ReviewSection, xpath: '.././/div[contains(@class,"p-toggleable-content")]', how: :div)

  ## a lot of this stuff I moved to the Review Section
  p(:message, class: /text-description/)
  span(:status, xpath: './/div/p-overlaypanel/../span') #class: /status-text/)
  button(:review, xpath: './/p-button[@label="Review"]/button')
  i(:review_icon_right, class: 'review-icon fas fa-angle-right')
  i(:review_icon_down, class: 'review-icon fas fa-angle-down')

  def reviewed
    reviewed_raw.tr("\n", ' ')
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
  end
end

class ReferralsPanel < BasePanel
  select(:filter_dropdown, xpath: './/div[contains(@class,"p-dropdown")]/..')
  sections(:referrals, ReferralRow, xpath: '.', item: { xpath: './/p-panel[contains(@class,"expandIcon")]/div', how: :divs })
  # sections(:referrals, ReferralRow, xpath: '.', item: {xpath: './/p-accordiontab//div[contains(@class,"ui-accordion-header ui-state-default")]', how: :divs})
  div(:no_referrals_, class: ['noReferrals', 'ng-star-inserted'])
  checkbox(:blue_streak_seal, id: /blueStreakSeal/)
  textarea(:reason_for_applying_seal, id: /reasonForApplyingSeal/)
  button(:apply_seal, xpath: './/p-button[@id="applySeal"]/button')
  select(:seal_authorized_by, id: /sealAuthorizedBy/)
  span(:chevron_right, class: /pi-angle-right/)
  span(:chevron_down, class: /pi-angle-down/)

  def referral_messages
    referrals.map(&:message)
  end

  def find_referral(message)
    referrals_element.find_by(:message, message)
  end
end

class UnderwritingReferralsModal < BaseModal
  sections(:referrals_panel, ReferralsPanel, xpath: './/div[@class="underwriting-referrals"]', item: { xpath: './/p-panel[not(contains(@class,"expandIcon"))]/div', how: :divs })
  # sections(:referrals_panel, ReferralsPanel, xpath: './/div[@class="underwriting-referrals"]', item: {xpath: './/p-panel/div', how: :divs})
  button(:close, xpath: '//p-button[@id="Close"]/button')
  button(:contact_underwriter, xpath: '//p-button[@id="ContactUnderwriter"]/button')
  span(:uw_name, xpath: './/div[contains(text()," Contact your underwriter on the following prior to binding. ")]/following-sibling::div//span')
  div(:uw_title, xpath: './/div[contains(text()," Contact your underwriter on the following prior to binding. ")]/following-sibling::div/div  ')
  a(:uw_email, xpath: './/div//span//a[contains(text(),"@central-insurance.com")]')
  span(:uw_phone, xpath: './/div[contains(text()," Contact your underwriter on the following prior to binding. ")]/following-sibling::div//div/following-sibling::div//span')
end