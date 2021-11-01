# frozen_string_literal: true

class ReferralsPanel < BasePanel
  sections(:referrals, ReferralRow, xpath: '.', item: { xpath: './/p-panel/div', how: :elements })
  div(:no_referrals_, class: ['noReferrals', 'ng-star-inserted'])
  checkbox(:blue_streak_seal, id: /blueStreakSeal/)
  textarea(:reason_for_applying_seal, id: /reasonForApplyingSeal/)
  button(:apply_seal, xpath: './/p-button[@id="applySeal"]/button')
  select(:seal_authorized_by, id: /sealAuthorizedBy/)
  span(:chevron_right, class: /pi-angle-right/)
  span(:chevron_down, class: /pi-angle-down/)
  select(:filter_dropdown, xpath: './/div[contains(@class,"p-dropdown")]/..')

  def referral_messages
    referrals.map(&:message)
  end

  def find_referral(message)
    referrals_element.find_by(:message, message)
  end
end
