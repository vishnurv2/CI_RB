
class EzGeneralInformationModal < BaseModal
  select_ezlynx(:form_type, id: 'policyFormType')
  textarea(:description, id: 'ratingDescription')
  toggle_switch_ezlynx(:select_carriers, xpath: '//span[contains(text(), "Select All Carriers")]/../child::div')
  link(:policy_info_button, id: 'go-to-policy-info-btn')
end