Feature: Validating the mandatory fields for Auto policy

  #Auto - General Info Modal
  @fixture_ui_edits_general_modal_mandatory_fields_auto @delete_when_done @auto
  Scenario Outline: Verify mandatory fields - General Information Modal - Auto
    Given I have started a new auto policy up to the "auto general info" modal
    Then I add effective date before 2017
    And I try to add new address to check the fields
    Then I should see "<validation message>" on the page
    Examples:
      |validation message       |
      |Effective Date must be 11/1/2017 or later. Rates prior to 11/1/2017 do not exist on our new policy system|
      |Street is required.                                                                                      |
      |City is required.                                                                                        |
      |State is required.                                                                                       |
      |Zip is required.                                                                                         |

  @fixture_ui_edits_general_modal_mandatory_fields_auto @lambda @delete_when_done @auto
  Scenario: Verify mandatory fields - General Information Modal - Auto - Policy Mailing address
    Given I have started a new auto policy up to the "auto general info" modal
    And I clear the field with dismiss cross in "auto general info" modal
    Then I should see the following errors on the page
      |Policy Mailing Address is required|

    #Effective date validation message in general info modal is working fine manually but not with automation
  @fixture_ui_edits_general_modal_mandatory_fields_auto @delete_when_done @auto @wip
  Scenario: Verify mandatory fields - Auto - General Information Modal - Effective date
    Given I have started a new auto policy up to the "auto general info" modal
    And I clear the effective date field and click save and close button
    Then I should see the following errors on the page
      |Effective Date is required.|

  @fixture_ui_edit_auto_policy_future_effective_date @delete_when_done @auto
  Scenario: Verify mandatory fields - Auto - General Information Modal - future effective date
    Given I have created a new "Auto" policy
    Then I should see the following issue messages on alerts side bar
     | Effective Date greater than 12 months in the future is invalid.|

  @fixture_ui_edits_auto_special_no_producer @delete_when_done @auto
  Scenario: Verify mandatory fields - Auto - General Information Modal - Producer
    Given I have started a new auto policy through the "auto vehicle coverages" modal
    And I begin issuance
    And I navigate to my quote "IN - Auto" using the left nav
    And I click modify on general information modal and then save and close the modal
    Then I should see the following errors on the page
      |Producer is required.|

  @fixture_ui_edits_auto_special_no_producer @delete_when_done @auto
  Scenario Outline: Verify mandatory fields auto - Add Product Modal - Email required
    Given I have started a new auto policy through the "auto vehicle coverages" modal
    And I begin issuance
    And I navigate to my quote "IN - Auto" using the left nav
    And I click edit on the applicant panel and save and close the modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message           |
      |Email is required            |
      |Provide a valid email address|

  #Auto - Vehicle Modal
  @fixture_manual_coverage_created_deleted @delete_when_done @auto
  Scenario Outline: Verify mandatory fields - Auto - Vehicle Modal
    Given I have started a new auto policy up to the "auto vehicle" modal
    And I clear the field with dismiss cross in "auto vehicle" modal
    And I save and close the "auto vehicle" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message                |
      |Identification Number is required.|
      |Purchase Date is required.|
      |Vehicle Use is required.  |
      |Annual Miles is required. |
      |Garage Address is required|
      |Performance is required.  |

  @fixture_manual_coverage_created_deleted @delete_when_done @auto
  Scenario Outline: Verify mandatory fields - Auto - Vehicle Modal - YMM
    Given I have started a new auto policy up to the "auto vehicle" modal
    And I clear the field with dismiss cross in "auto vehicle" modal
    And I save and close the "auto vehicle" modal
    Then I should see the following errors on the page
      |Identification Number is required.|
      |Purchase Date is required.|
      |Vehicle Use is required.  |
      |Annual Miles is required. |
      |Garage Address is required|
      |Performance is required.  |
    And I choose Year/Make/Model for the identification type
    Then I should see "<validation message>" on the page
    Examples:
      |validation message|
      |Year is required. |
      |Make is required. |
      |Model is required.|
      |Style is required.|

  @fixture_manual_coverage_created_deleted @delete_when_done @auto
  Scenario: Verify mandatory fields - Auto - Vehicle Modal - at least one vehicle required
    Given I have started a new auto policy up to the "auto vehicle" modal
    And I close the "auto vehicle" modal
    Then I should see the following errors on the page
      |At least one vehicle must be specified for quote. No vehicle specified in the request.|

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario: Verify mandatory fields - Auto - Vehicle Modal - at least one vehicle must be garaged in IN
    Given I have started a new auto policy up to the "auto vehicle" modal
    And I have loaded the fixture file named "2016_cadillac_escalade_full_vin_ohio_garage"
    When I have populated the auto vehicle modal
    And I populate garage address of Ohio
    And I save and close the "auto vehicle" modal
    Then I should see the following errors on the page
      |Risk State is IN; at least one vehicle must be garaged in IN|

  #Auto - Vehicle coverage modal
  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario Outline: Verify mandatory fields - Auto - Vehicle Coverages Modal
    Given I have started a new auto policy through the "auto vehicle" modal
    And I fill the data in auto vehicle coverages modal with ui_edits_auto_vehicle_coverages fixture file and save and close it
    Then I should see "<validation message>" on the page
    Examples:
      |validation message       |
      |The selected value is already included. Please select a different value or de-select the coverage|
      |The selected value is already included. Please select a different value or de-select the coverage|
      |The selected value is already included. Please select a different value or de-select the coverage|
      |Premium is required                                                                              |
      |Description of Coverage is required                                                              |
      |Total Limit (Per Disablement) is required                                                        |

  @fixture_ui_edits_auto_randon_vin @delete_when_done @auto
  Scenario Outline: Verify the Invalid VIN on Vehicle Modal in Auto
    Given I have started a new auto policy up to the "auto vehicle" modal
    When I have populated the auto vehicle modal
    And I deselect Agreed field from vehicle modal
    And I save and continue on the auto vehicle modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message       |
      |Invalid VIN|
      |Vehicle Make is required|
      |Vehicle Model is required|

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario: Verify mandatory fields - Auto - Vehicle Coverages Modal - Vehicle must be 25 years or older to qualify as Limited Use Auto
    Given I have started a new auto policy up to the "auto vehicle" modal
    When I populate the auto vehicle modal with the data in the a_3_1_c_3 fixture without saving modal
    Then I change the vehicle type to "Limited Use Auto" on vehicle modal
    Then I should see the following errors on the page
      |The Vehicle must be 25 years or older to qualify as Limited Use Auto. Vehicle year to be found 2016|

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario: Verify mandatory fields - Auto - Vehicle Coverages Modal - Collision not valid
    Given I have started a new auto policy through the "auto vehicle" modal
    And I populate data in vehicle coverages modal for Collision and save and close it
    Then I should see the following errors on the page
      |Collision coverage requires Other Than Collision Coverage|

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario: Verify mandatory fields - Auto - Vehicle Coverages Modal - Loan/Lease guard requires other than collision coverage
    Given I have started a new auto policy through the "auto vehicle" modal
    And I populate data in vehicle coverages modal for Loan Lease guard and save and close it
    Then I should see the following issue messages on alerts side bar
      |Lease / Loan Guard requires Other Than Collision and Collision Coverages|

  #Auto - Issues to resolve
  @fixture_ui_edits_auto_special_no_producer @delete_when_done @auto
  Scenario Outline: Verify the issues to resolve panel fields in Auto
    Given I have started a new auto policy through the "auto vehicle coverages" modal
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      |issue messages                                                 |
      |Clue Report not completed                                      |
      |Underwriting Questions must be signed off to issue this policy.|
      |Mvr Report not completed                                       |
      |A producer must be specified for policy Issuance.              |
      |Underwriting Questions must be signed off to issue this policy.|

  #Auto - Driver Modal
  @fixture_auto_policy_party_loss_payee @delete_when_done @auto
  Scenario: Verify mandatory fields - Auto - Driver Modal - at least one driver required
    Given I have started a new auto policy up to the "auto driver" modal
    And I close the "auto driver" modal
    Then I should see the following errors on the page
      |At least one driver must be specified for quote. No driver specified in the request.|

  @fixture_ui_edits_auto_driver_relationship @delete_when_done @auto @lambda
  Scenario: Verify mandatory fields - Auto - Driver Modal - relation to self
    Given I have started a new auto policy up to the "auto driver" modal
    When I have populated the auto driver modal
    And I save and close the "auto driver" modal
    Then I should see the following issue messages on alerts side bar
      |If driver is an applicant Driver relation to Insured must be Self|

  @fixture_ui_edits_auto_driver_relationship @delete_when_done @auto
  Scenario Outline: Verify mandatory fields - Auto - Driver Modal - relation must not be self
    Given I have started a new auto policy up to the "auto driver" modal
    And I have loaded the fixture file named "generic_fake_driver_must_not_be_self"
    When I have populated the auto driver modal
    And I save and close the "auto driver" modal
    Then I should see <issue messages> present on alert side bar
    Examples:
      |issue messages                                                                                                                                      |
      |If driver is not an applicant Driver relation to Insured must not be Self                                                                           |
      |The license number you entered does not match the required format on file for Indiana. The format is 1 Alpha + 9 Numeric or 9 Numeric or 10 Numeric.|

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario Outline: Verify mandatory fields - Auto - License state and number required
    Given I have started a new auto policy up to the "auto driver" modal
    And I have loaded the fixture file named "generic_fake_driver_no_license"
    When I have populated the auto driver modal
    And I save and close the "auto driver" modal
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                    |
      | Driver license number is required |
      | Driver license State is required  |

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario Outline: Verify mandatory fields - Auto - Accidents and Violations
    Given I have started a new auto policy up to the "auto driver" modal
    And I have loaded the fixture file named "generic_fake_driver"
    When I have populated the auto driver modal
    And I add a blank accident and a blank violation
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Accident Date is required. |
      | Accident Type is required. |
      | Description is required.   |

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario Outline: Verify mandatory fields - Auto - Driver Modal
    Given I have started a new auto policy up to the "auto driver" modal
    And I fill the data in "auto driver" modal with ui_edit_no_generic_fake_driver fixture file and save and close it
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | First Name is required. |
      | Last Name is required.  |
      | Date of Birth is required. |
      | Gender is required.        |
      | Marital Status is required.|
      | Relationship to Applicant is required.|

  #Auto - Billing Account
  @fixture_auto_policy_party_loss_payee @delete_when_done @auto
  Scenario: Verify the validation on billing account for auto LOB
    Given I have started a new auto policy through the "auto vehicle coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I start with issue wizard modal till Billing Information section
    And I should see the following red alerts on the top right corner
      | Some products do not have a billing account |

  @fixture_ui_edits_auto_policy_affiliation @delete_when_done @auto
  Scenario: Verify the validation on billing account- Auto - Affiliate discount requires EFT (or annual pay)
    Given I have started a new auto policy through the "auto driver" modal
    And I begin issuance
    And I save policy or quote number from account summary page for "Auto" policy
    And I save name email and phone number from account summary page
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I start with issue wizard modal till Billing Account modal
    And I should see the warning message on billing Add product modal
      |by not selecting eft, the affiliate discount will be removed from in-personalauto -|

  #Auto - Add party
  @fixture_auto_party_trust_only_required @delete_when_done @auto
  Scenario: Validating mandatory fields of auto party modal - business
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust"
    And I save and close the "add applicant" modal
    Then I should see the following errors on the page
      | Organization Name is required. |

  @fixture_auto_party_trust_only_required @delete_when_done @auto
  Scenario Outline: Validating mandatory fields of auto party modal - Individual
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Applicant"
    And I save and close add applicant modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message    |
      |First Name is required.|
      |Last Name is required. |
      |Date of Birth is required.|
      |Street is required.       |
      |City is required.         |
      |State is required.        |
      |Zip is required.          |

  #Auto - Policy Level Coverages
  @fixture_extended_non_owned_coverage_named_non_owner @delete_when_done @auto
  Scenario: Verify validation message - Extended Non Owned coverage with Named Individual requires a Driver
    Given I have started a new auto policy up to the "auto policy coverages" modal
    And I have populated the auto policy coverages modal
    Then I should see the following errors on the page
      |Vehicles are not eligible on a Named Non-Owner Auto Policy. Any vehicle(s) found will be removed upon Save|
    And I save and close the "auto policy coverages" modal
    Then I should see the following errors on the page
      |Only one driver applies when Named Non Owned with Named Individual coverage is selected.|

   #Auto - Policy Level Optional Coverages
  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario Outline: Verify validation message - Manual Coverage
    Given I have created a new "Auto" policy
    And I open the policy level optional coverages
    When I have populated the Auto Policy Optional Coverages modal
    And I save and close the "auto policy optional coverages" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message                 |
      |Premium is required                |
      |Description of Coverage is required|

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario Outline: Verify validation message - Manual Coverage after begin issuance
    Given I have created a new "Auto" policy
    Then I begin issuance
    And I navigate to "IN - Auto" using the left nav
    And I open the policy level optional coverages
    When I have populated the Auto Policy Optional Coverages modal
    And I save and close the "auto policy optional coverages" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message                 |
      |Premium is required                |
      |Description of Coverage is required|

  @fixture_auto_policy_corporate_coverage @delete_when_done @auto
  Scenario Outline: Validating message  - At least one vehicle must be rated business use to have corporate auto
    Given I have created a new "Auto" policy
    And I open the policy level optional coverages
    When I populate auto policy optional coverages with Corporate Auto coverage
    And I save and close the "auto policy optional coverages" modal
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      |issue messages                                                                   |
      | At least one vehicle must be rated business use to have corporate auto coverage |
      | Corporate Auto party is required when corporate auto coverage is selected       |

  @fixture_auto_policy_gary_p_adams @delete_when_done @auto @wip
  Scenario: Validating message  - Driver Selection is Needed to Determine an Accurate Premium
    Given I have started a new auto policy up to the "auto policy coverages" modal
    And I have populated the auto policy coverages modal
    Then I save and continue the "auto policy coverages" modal
    And I remove the vehicles and driver from vehicle and driver found modal
    And I begin issuance

  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_4 @delete_when_done @auto
  Scenario: Validating message - Not all drivers were assigned to a vehicle
    Given I have created a new "auto" policy
    And I have loaded the fixture file named "driver_consistency"
    When I add a driver from the policy summary page using the data for "additional driver"
    Then I should see the following errors on the page
      |Not all drivers were assigned to a vehicle|

  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_4 @delete_when_done @auto
  Scenario: Validating message - Primary Driver cannot be Occasional Driver on the same Vehicle
    Given I have created a new "auto" policy
    And I have loaded the fixture file named "driver_consistency"
    When I add a driver from the policy summary page using the data for "additional driver"
    Then I should see the following issue messages on alerts side bar
      | All drivers must be assigned to a vehicle either as Primary or Occasional driver |

  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_4 @delete_when_done @auto
  Scenario: Validating message - Not all vehicles were assigned a principal driver
    Given I have created a new "auto" policy
    When I start adding another new vehicle to the auto policy
    When I populate the auto vehicle modal with the data in the 2016_cadillac_escalade_other_vehicle fixture
    Then I should see the following errors on the page
      | Not all vehicles were assigned a principal driver |

  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_4 @delete_when_done @auto
  Scenario: Validating message - The Vehicle must be 10 years or older to qualify as classic/classic-limited.
    Given I have created a new "auto" policy
    And I click on edit the first vehicle
    Then I update the Type as "Classic - Limited"
    Then I should see the following errors on the page
      | The Vehicle must be 10 years or older to qualify as classic/classic-limited. Vehicle year to be found 2016 |

  @fixture_auto_policy_applicants_details @delete_when_done @auto
  Scenario: Verify message - A driver with the same license number or Name and date of birth already exists on the Policy
    Given I have created a new "auto" policy
    And I begin issuance
    Then I navigate to "IN - Auto" using the left nav
    And I have loaded the fixture file named "generic_fake_driver"
    When I add a driver from the policy summary page using the data for "auto_driver_modal"
    Then I should see the following issue messages on alerts side bar
      | A driver with the same license number or Name and date of birth already exists on the Policy |




















