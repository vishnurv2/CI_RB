class LeftNavbarEzlynx < BaseSection
  div(:add_applicants, xpath: './/div[@title="Applicants"]')
  link(:create_new_applicant, xpath: './/a[@title="Create New Applicant"]')
  div(:settings, xpath: './/div[@title="Settings"]')
  link(:carrier_quoting_setup, xpath: './/a[@title="Carrier Quoting Setup"]')

end

class EzlynxNewApplicant < BaseSection
  text_field(:first_name, id: 'applicant-first-name')
  text_field(:middle_name, id: 'applicant-middle-name')
  text_field(:last_name, id: 'applicant-last-name')
  select_ezlynx(:address_state, id: 'applicant-rating-state')
  text_field(:postal_code, id: 'applicant-primaryaddress-postalcode')
  select_ezlynx(:gender, id: 'applicant-gender')
  text_field(:dob, id: 'applicant-date-of-birth')
  select_ezlynx(:marital_status, id: 'applicant-marital-status')
  text_field(:ssn, id: 'applicant-social-security-number')
  text_field(:driving_license, id: 'applicant-drivers-license-number')
  select_ezlynx(:education, id: 'applicant-education')
  select_ezlynx(:industry, id: 'applicant-industry')
  select_ezlynx(:occupation, id: 'applicant-occupation')
  text_field(:customer_since, id: 'applicant-customer-since')
  button(:save, id: 'save-personal-applicant-btn')
  button(:go_to_auto, title: 'Go To Auto')
  button(:go_to_home, title: 'Go To Home')

  #Primary Address
  select_ezlynx(:address_type, id: 'applicant-primary-address-applicantAddressType')
  text_field(:address_line_one, name: 'address1')
  text_field(:address_line_two, name: 'address2')
  text_field(:address_city, name:'addressCity')
  select_ezlynx(:primary_address_state, name: 'addressState')
  select_ezlynx(:primary_address_state, name: 'addressCounty')
  text_field(:postal_code_field, id: 'applicant-primary-address-postalcode')
  select_ezlynx(:years_at_address, name: 'yearsAtAddress')
  select_ezlynx(:phone_type, id: 'Home_PhoneType-type')
  text_field(:phone_number, id: 'Home_PhoneType-number')
  button(:add_email, id: 'applicant-add-email-btn')
  text_field(:email_address, id: 'applicant-email-0-email-address')


end

class EzPolicyInformation < BaseSection

  select_ezlynx(:prior_carrier, id: 'priorCarrier')
  text_field(:policy_expiration_date, id: 'priorPolicyExpirationDate')
  select_ezlynx(:prior_liability_limits, id: 'priorLiabilityLimits')
  select_ezlynx(:prior_policy_term, id: 'priorPolicyTerm')
  select_ezlynx(:years_with_prior_carrier, id: 'yearsWithPriorCarrier')
  select_ezlynx(:years_with_continuous_coverage, id: 'yearsWithContinuousCoverage')
  select_ezlynx(:credit_check, id: 'creditCheckAuthorized')
  select_ezlynx(:new_policy_term, id: 'newPolicyTerm')
  select_ezlynx(:quote_as_package, id: 'package')
  text_field(:policy_effective_date, id: 'effectiveDateNewPolicy')
  link(:dwelling_info_button, id: 'go-to-dwellingInfo-btn')
  link(:driver_info_button, id: 'go-to-drivers-btn')

end

class EzDriverInformation < BaseSection
  button(:add_driver, id: 'add-driver-btn')

  #Add new driver
  text_field(:driver_first_name, id: 'driver-1-first-name')
  text_field(:driver_last_name, id: 'driver-1-last-name')
  text_field(:driver_dob, id: 'driver-1-dob')
  select_ezlynx(:driver_gender, id: 'driver-1-gender')
  select_ezlynx(:driver_marital_status, id: 'driver-1-maritalStatus')
  select_ezlynx(:driver_relationship, id: 'driver-1-relationship')
  select_ezlynx(:driver_occupation_industry, id: 'driver-1-occupationIndustry')
  select_ezlynx(:driver_occupation_title, id: 'driver-1-occupationTitle')
  text_field(:driver_license, id: 'textD2DLNumber')

  ## vehicle section link
  link(:vehicle_info_button, id: 'go-to-vehicles-btn')


end

class EzVehicleInformation < BaseSection
  text_field(:VIN, id: 'VIN-0')
  button(:vin_lookup_button, title: 'VIN Lookup')
  select_ezlynx(:year, id: 'selected-year-0')
  select_ezlynx(:make, id: 'selected-make-0')
  select_ezlynx(:model, id: 'selected-model-0')
  text_field(:sub_model, id: 'selected-subModel-0')
  text_field(:purchase_date, id: 'vehiclePurchaseDate-0')
  select_ezlynx(:vehicle_use, id: 'selected-use-0')
  text_field(:annual_miles, id: 'annual-miles-0')
  select_ezlynx(:performance, id: 'selected-performance-0')
  select_ezlynx(:ownership_type, id: 'selected-ownershipType-0')

  button(:add_another_vehicle, id: 'addVehicleButton')
  button(:add_alternate_garage, id: 'add-alternateGarage-btn')
  link(:goto_incidents_button, id: 'go-to-incidents-btn')

end

class EzIncidentsInformation < BaseSection
  button(:add_accident, id: 'add-accident-btn')
  button(:add_violation, id: 'add-violation-btn')
  button(:add_comp_loss, id: 'add-comp-loss-btn')

  link(:goto_coverage_button, id: 'go-to-coverage-btn')

end

class EzAutoCoverage < BaseSection
  select_ezlynx(:bodily_injury, id: 'bodily-injury')
  select_ezlynx(:uninsured_motorist, id: 'uninsured-motorist')
  select_ezlynx(:underinsured_motorist, id: 'underinsured-motorist')
  select_ezlynx(:property_damage, id: 'property-damage')
  select_ezlynx(:medical_payments, id: 'medical-payments')

  #State specific IN
  select_ezlynx(:uninsured_motorist_property_damage, id: 'INUMPD')

  #Credits
  select_ezlynx(:residence, id: 'residence')

  #vehcile
  select_ezlynx(:comprehensive, id: 'vehicle-0-comprehensive')
  select_ezlynx(:collision, id: 'vehicle-0-collision')
  text_field(:state_amount, id: 'textV1StatedAmt')

  link(:incidents, id: 'go-to-incidents-btn')
  link(:carrier_questions_button, id: 'go-to-carrier-questions-btn')

end

class EzDwellingInformation < BaseSection
  select_ezlynx(:dwelling_usage, id: 'dwellingUsage')
  select_ezlynx(:dwelling_type, id: 'dwellingType')
  select_ezlynx(:number_of_occupants, id: 'numberOfOccupants')
  select_ezlynx(:number_of_stories, id: 'numberOfStories')
  text_field(:square_footage, id: 'squareFootage')
  text_field(:year_built, id: 'year-built')
  select_ezlynx(:construction_style, id: 'constructionStyle')
  select_ezlynx(:roof_type, id: 'roofType')
  select_ezlynx(:foundation_type, id: 'foundationType')
  select_ezlynx(:roof_design, id: 'roofDesign')
  select_ezlynx(:exterior_walls, id: 'exteriorWalls')
  select_ezlynx(:heating_type, id: 'heatingType')
  text_field(:purchase_date, id: 'purchaseDate')
  text_field(:distance_from_fire_station, id: 'distanceFromFireStation')
  select_ezlynx(:feet_from_hydrant, id: 'feetFromHydrant')
  select_ezlynx(:protection_class, id: 'protectionClass')
  select_ezlynx(:heating_update, id: 'heatingUpdate')
  text_field(:year_updated_heating, id: 'yearUpdatedHeating')
  select_ezlynx(:electrical_update, id: 'electricalUpdate')
  text_field(:year_updated_electrical, id: 'yearUpdatedElectrical')
  select_ezlynx(:plumbing_update, id: 'plumbingUpdate')
  text_field(:year_updated_plumbing, id: 'yearUpdatedPlumbing')
  select_ezlynx(:roofing_update, id: 'roofingUpdate')
  text_field(:year_updated_roofing, id: 'yearUpdatedRoofing')
  link(:coverage_button, id: 'go-to-coverage-btn')

end

class EzHomeCoverage < BaseSection
  text_field(:dwelling, id: 'dwelling')
  text_field(:replacement_cost, id: 'estReplacementCost')
  select_ezlynx(:personal_liability, id: 'personalLiability')
  select_ezlynx(:medical_payments_home, id: 'medicalPayments')
  select_ezlynx(:all_peril_deductibles, id: 'allPerilsDeductible')
  link(:endorsements_button, id: 'go-to-endorsements-btn')
end

class EzEndorsement < BaseSection
  link(:carrier_questions_button, id: 'go-to-carrier-questions-btn')
end

class EzCarrierQuestions < BaseSection
  select_ezlynx(:pay_in_full_discount, id: 'annualpayplan1__49')
  link(:finish_button, id: 'go-to-finish-btn')
end

class EzValidLastPage < BaseSection
  button(:submit_to_carriers_button, id: 'submit-to-carriers-btn')
end

class EZSubmitCarrier < BaseSection
  button(:submit_carriers_button, id: 'submit-to-carriers-btn')
end

class EzSelectCarrierPage < BaseSection
  button(:submit_button, id: 'submit-carriers-btn')
end

class EzSubmit < BaseSection
  button(:submit_button, id: 'submit-carriers-btn')
end

class EzQuoteResults < BaseSection
  button(:answer_questions_button, xpath: '//span[contains(text()," Answer Questions ")]/..')
  button(:submit_answers_button, xpath: '//span[contains(text(),"  Submit  ")]/..')
  div(:progress_bar, xpath: '//mat-progress-bar[@role="progressbar"]')
  link(:access_quote_button, xpath: '//span[contains(text()," Access Quote ")]/ancestor::a')
end

class EzSideBar < BaseSection

end

class EzlynxCarrierSetup < BaseSection
  button(:view_details_button, xpath: '//mat-card-actions[@class="mat-card-actions carrier-status-view-details"]/button')
  link(:logins, xpath: '//div[contains(text(),"Logins")]')
  text_field(:username, id: 'mat-input-1')
  text_field(:producer_code, id: 'mat-input-2')
  text_field(:password, id: 'mat-input-3')
  button(:save_button, xpath: '//span[contains(text()," Save and Test ")]/ancestor::button')
end

class EzlynxManagementPage < BasePage

  section(:left_nav_bar, LeftNavbarEzlynx, class: /nav-menu ng/)
  section(:personal_lines_applicant, EzlynxNewApplicant, id: 'applicantdiv')
  section(:side_bar, EzSideBar, class: 'sidebar-overflow')
  section(:carrier_setup_page, EzlynxCarrierSetup, xpath: '//h2[contains(text(),"Manage Carriers")]//ancestor::carriers')


  #Home
  section(:ez_general_information_modal, EzGeneralInformationModal, class: 'ez-page-body with-page-header')
  section(:ez_policy_information_modal, EzPolicyInformation, class: 'ez-page-body with-page-header')
  section(:ez_dwelling_information_modal, EzDwellingInformation, class: 'ez-page-body with-page-header')
  section(:ez_home_coverage_info_modal, EzHomeCoverage, xpath: '//h4[contains(text(),"Coverage Information")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_endorsement_information_modal, EzEndorsement, xpath: '//h4[contains(text(),"Endorsements Information")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_carrier_questions_modal, EzCarrierQuestions, xpath: '//h4[contains(text(),"Carrier Questions")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_valid_last_page_modal, EzValidLastPage, xpath: '//span[contains(text()," Correcting the following items will increase the accuracy of your quote ")]//ancestor::div[@class="ezlynx-5-app"]')


  #Auto
  section(:ez_driver_information, EzDriverInformation, xpath: '//span[contains(text(),"Drivers")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_vehicle_information, EzVehicleInformation, xpath: '//span[contains(text(),"Vehicles")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_incidents_information, EzIncidentsInformation, xpath: '//span[contains(text(),"Incidents")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_auto_coverage, EzAutoCoverage, xpath: '//span[contains(text(),"Coverage")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_select_carrier_modal, EzSelectCarrierPage, xpath: '//span[contains(text()," Select Carriers ")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_quote_results_modal, EzQuoteResults, xpath: '//h2[contains(text(),"Quote Results")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_submit_to_carrier_modal, EZSubmitCarrier, xpath: '//span[contains(text(),"Valid")]//ancestor::div[@class="ezlynx-5-app"]')
  section(:ez_select_carrier_for_auto_modal, EzSubmit, xpath: '//h2[contains(text(),"Submit to Carriers")]//ancestor::div[@class="ezlynx-5-app"]')



end