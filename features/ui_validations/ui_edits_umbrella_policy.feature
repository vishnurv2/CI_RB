Feature: Validating UI validations for umbrella policy

  @fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @umbrella @lambda
  Scenario: Validation for explanation field - exotic pets kept on any of the applicant's premises
    Given I have created a new "umbrella" policy
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the umbrella underwriting question of "exotic pets" as "Yes" in underwriting questions
    Then I verify that the explanation field is present

  @fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @umbrella
  Scenario: Validation for explanation field - liability loss
    Given I have created a new "umbrella" policy
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the umbrella underwriting question of "liability loss" as "Yes" in underwriting questions
    Then I verify that the explanation field is present

  @fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @umbrella
  Scenario: Validation for explanation field - engage in regular activities
    Given I have created a new "umbrella" policy
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the umbrella underwriting question of "engage in regular activities" as "Yes" in underwriting questions
    Then I verify that the explanation field is present

  @fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @umbrella
  Scenario: Validation for explanation field - pending litigation
    Given I have created a new "umbrella" policy
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the umbrella underwriting question of "pending litigation" as "Yes" in underwriting questions
    Then I verify that the explanation field is present

  @fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @umbrella
  Scenario: Validation for explanation field - restrict coverage
    Given I have created a new "umbrella" policy
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the umbrella underwriting question of "restrict coverage" as "Yes" in underwriting questions
    Then I verify that the explanation field is present

  @fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @umbrella
  Scenario: Validation for explanation field - residence employee
    Given I have created a new "umbrella" policy
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the umbrella underwriting question of "Residence employee" as "Yes" in underwriting questions
    Then I verify that the explanation field is present

  @fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @umbrella
  Scenario: Validation for explanation field - libel or slander
    Given I have created a new "umbrella" policy
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the umbrella underwriting question of "libel or slander" as "Yes" in underwriting questions
    Then I verify that the explanation field is present

  #@fixture_umbrella_policy_enhanced_no_exposures @delete_when_done @umbrella
  #Scenario: Validation for explanation field - canceled or non-renewed
    #Given I have created a new "umbrella" policy
    #And I navigate to "Underwriting Questions" tab on quote management page
    #When I answer the all products underwriting question of "coverage canceled or non" as "Yes" in underwriting questions
    #Then I verify that the explanation field is present in all product section

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - watercraft
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Watercraft" through "ui_edits_umbrella_watercraft" fixture file
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                           |
      | The Watercraft Manufacturer is required. |
      | The Watercraft Model is required.        |
      | The Insuring Company's name, the Policy Effective Date, and the Limits of Liability are required.|
      | The Watercraft Year is required.                                                                 |
      | The Watercraft Serial Number is required.                                                        |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - watercraft - inline validations on page
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Watercraft" through "ui_edits_umbrella_watercraft" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 1 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Serial Number is required.         |
      | Year is required.                  |
      | Make is required.                  |
      | Model is required.                 |
      | Limit is required.                 |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - vehicle
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Vehicles" through "ui_edits_umbrella_vehicle" fixture file
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                     |
      | The VIN/Serial Number is required. |
      | The Vehicle Year is required.      |
      | The Insuring Company`s name, the Policy Effective Date, and the Limits of Liability are required. |
      | The Vehicle Make/Model is required.                                                               |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - vehicle - inline validations on page
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Vehicles" through "ui_edits_umbrella_vehicle" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 1 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Year is required.                  |
      | Make is required.                  |
      | Model is required.                 |
      | Identification Number is required. |
      | Limit is required.                 |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Farm land container
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Farm Land" through "ui_edits_umbrella_farmland" fixture file
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                     |
      | A description must be entered for Farming away from the residence premises Farm. |
      | A valid address, city, state, and zip code must be entered for Farming away from the residence premises Farm. |
      | A valid address, city, state, and zip code must be entered for Farm Land Rented to Others Farm.               |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Farm Land - inline validations on page
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Farm Land" through "ui_edits_umbrella_farmland" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 1 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Limit is required.                 |
      | Street is required.                |
      | City is required.                  |
      | State is required.                 |
      | Zip is required.                   |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Location/Property
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Location / Property" through "location_property" fixture file
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                           |
      | A valid address, city, state, and zip code must be entered for Additional Owner-Occupied Home – Single Family. |
      | The Insuring Company's name, the Policy Effective Date, and the Limits of Liability are required for Additional Owner-Occupied Home – Single Family. |
      | The residence premise address, city, state, and zip are required if Yes was answered to Is the address for the primary residence different than the mailing address? |
      | A valid address, city, state, and zip code must be entered for Additional Owner-Occupied Home – Multi-Family |
      | The Insuring Company's name, the Policy Effective Date, and the Limits of Liability are required for Additional Owner-Occupied Home – Multi-Family. |
      | The residence premise address, city, state, and zip are required if Yes was answered to Is the address for the primary residence different than the mailing address? |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Location/Property - inline validations on page
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Location / Property" through "location_property" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 1 product in exposures insured with another carrier panel
    And I clear the field with dismiss cross in "exposures insured with another carrier" modal
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Location / Property Address is required|
      | Street is required.                |
      | City is required.                  |
      | State is required.                 |
      | Zip is required.                   |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Business Property
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                           |
      | The Insuring Company's name, the Policy Effective Date, and the Limits of Liability are required for Rental Dwelling – Single Family.|
      | A valid address, city, state, and zip code must be entered for Rental Dwelling – Single Family.                                      |
      | A valid address, city, state, and zip code must be entered for Rental Dwelling – Multi-Family.                                       |
      | The Insuring Company's name, the Policy Effective Date, and the Limits of Liability are required for Rental Dwelling – Multi-Family. |
      | A Business Classification must be selected for Home-Based Business.                                                                  |
      | A description must be entered for Business Pursuits.                                                                                 |
      | A Residence Location must be selected for Permitted Incidental Occupancies.                                                          |
      | Party needed with each Business Pursuits another carrier exposure.                                                                   |
      #| 'I agree all questions have been reviewed and answered true, correct, and complete to the best of my ability' is required.           |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Business Property - Permitted Incidental Occupancy
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 1 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Name of Business is required.      |
      | Limit is required.                 |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Business Property - Home-Based Business
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 2 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Limit is required.                 |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Business Property - Business Pursuits
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 3 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Name of Business is required.                |
      | Description of Business is required.         |
      | Limit is required.                          |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Business Property - Single Family Rental Dwelling
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 4 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Limit is required.                 |
      | Street is required.                |
      | City is required.                  |
      | State is required.                 |
      | Zip is required.                   |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario Outline: Validation for explanation field - Business Property - Multi-Family Rental Dwelling
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 5 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see "<validation message>" on the page
    Examples:
      | validation message                 |
      | Number of units is required.       |
      | Limit is required.                 |
      | Street is required.                |
      | City is required.                  |
      | State is required.                 |
      | Zip is required.                   |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario: Validation for explanation field - Business Property - Swimming Pools at Rental Dwellings
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 6 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see the following errors on the page
      | Limit is required.                 |
      | Street is required.                |
      | City is required.                  |
      | State is required.                 |
      | Zip is required.                   |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario: Validation for explanation field - Business Property - Trampoline at Rental Dwellings
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I begin issuance
    And I navigate to "IN - Umbrella" using the left nav
    When I click on edit on 7 product in exposures insured with another carrier panel
    And I save and close the "exposures insured with another carrier" modal
    Then I should see the following errors on the page
      | Limit is required.                 |
      | Street is required.                |
      | City is required.                  |
      | State is required.                 |
      | Zip is required.                   |
      | Carrier is required.               |
      | Policy Number is required.         |
      | Effective Date is required.        |
      | Expiration Date is required.       |

  @fixture_home_policy_none_combined_none_pdf_validation @delete_when_done @umbrella
  Scenario Outline: Validation for Vacant Land Address
    Given I have created a new "home" policy
    And I add an additional Indiana "umbrella" product till "exposures_insured" using the fixture file "umbrella_policy_vacant_land"
    Then The "parcels of vacant land" modal should be visible
    And I should be able to add a vacant address
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                           |
      | A valid address, city, state, and zip code must be entered for Vacant Land Parcel |

  @fixture_umbrella_policy @delete_when_done @umbrella @wip
  Scenario Outline: Validation for explanation field - Location/Property - number of units greater than 0.
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I click on edit on 5 product in exposures insured with another carrier panel
    Then I fill the number of units as "0"
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                           |
      | Each multi-family dwelling listed must have a number of units greater than 1. |

  @fixture_ui_edits_umbrella_policy_PO_box_address @delete_when_done @umbrella
  Scenario Outline: Validation for - mailing address is to a PO Box
    Given I have started a new umbrella policy up to the "auto_policy_coverages" modal
    And I have populated the auto_policy_coverages modal
    And I add the address for residence premises
    Then I save and close the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    #And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      | issue messages                           |
      | If your mailing address is to a PO Box, you must enter an address for the primary residence. |

  @fixture_b_1_1 @delete_when_done @umbrella
  Scenario: Verify mandatory fields - Valid Email is required
    Given I have logged in
    And I log new personal account
    When I enter an agency name
    And I add first applicant using the "first_applicant_details_1" fixture to fill Personal Account Modal
    Then I update wrong email on personal account modal
    And I save and close new personal account modal
    Then I should see the following errors on the page
      |Enter valid email.|

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario: Verify the validation on billing account - Umbrella
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    And I resolve any underwriter referrals
    When I start with issue wizard modal till Billing Information section
    And I should see the following red alerts on the top right corner
      | Some products do not have a billing account |

  @fixture_umbrella_policy @delete_when_done @umbrella
  Scenario: Validation for - A description must be entered for Permitted Incidental Occupancies
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I click on add exposures insured with another carrier
    When I provide values for "Business Property" through "business_property" fixture file
    And I click on edit on 1 product in exposures insured with another carrier panel
    And I select "Other Residence" from Location of Incidental Occupancy modal
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      |A description must be entered for Permitted Incidental Occupancies.|







