# frozen_string_literal: true

class ProducersRow < EDSL::PageObject::Section
  link(:producer_name_edit, class: 'ProducerNameEditLink', default_method: :click, hooks: WFA_HOOKS)

  td(:policy, data_label: /Policy/)
  td(:term, data_label: /Term/)
  td(:producer_name, data_label: /Producers Name/)
  td(:license_number, data_label: /License Number/)
  td(:national_producer_number, data_label: /National Producer Number/)
  td(:corporate_license_number, data_label: /Corporate License Number/)

end
