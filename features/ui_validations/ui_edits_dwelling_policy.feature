Feature: Validating the mandatory fields for dwelling policy

    #DWELLING - Add Product Modal
  @fixture_b_1_1 @delete_when_done @dwelling
  Scenario Outline: Verify mandatory fields - Add Product Modal - Dwelling
    Given I have logged in
    And I log new personal account
    When I enter an agency name
    And I add first applicant using the first_applicant_details fixture
    And I save and close new personal account modal
    And I click on Begin quote on Add product modal
    Then I should see the "Add Product" modal
    And I add a product using dwelling_product fixture and remove the state
    Then I should see "<validation message>" on the page
    Examples:
      |validation message             |
      |State is required.          |
      |Effective Date is required. |
      |Expiration Date is required.|

  @fixture_ui_edits_dwelling_special_no_producer @delete_when_done @dwelling
  Scenario: Verify mandatory fields dwelling - Add Product Modal - Email required
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    And I navigate to my quote "IN - Special Dwelling" using the left nav
    And I click edit on the applicant panel and save and close the modal
    Then I should see the following errors on the page
      |Email is required|


     #General Information Modal
  @fixture_ui_edits_general_modal_mandatory_fields_dwelling @delete_when_done @dwelling
  Scenario Outline: Verify mandatory fields - General Information Modal - Dwelling
    Given I have started a new dwelling policy up to the "auto general info" modal
    Then I add effective date before 2017
    And I try to add new address to check the fields
    Then I should see "<validation message>" on the page
    Examples:
      |validation message             |
      |Effective Date must be 11/1/2017 or later. Rates prior to 11/1/2017 do not exist on our new policy system|
      |Street is required.                                                                                      |
      |City is required.                                                                                        |
      |State is required.                                                                                       |
      |Zip is required.                                                                                         |

    #Effective date validation message in general info modal is working fine manually but not with automation
  @fixture_ui_edits_general_modal_mandatory_fields_dwelling @delete_when_done @dwelling @wip
  Scenario: Verify mandatory fields - Dwelling - General Information Modal - Effective date
    Given I have started a new dwelling policy up to the "auto general info" modal
    And I clear the effective date field and click save and close button
    Then I should see the following errors on the page
      |Effective Date is required.|

  @fixture_ui_edits_dwelling_special_no_producer @delete_when_done @dwelling
  Scenario: Verify mandatory fields - Dwelling - General Information Modal - Producer
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    And I navigate to my quote "IN - Special Dwelling" using the left nav
    And I click modify on general information modal and then save and close the modal
    Then I should see the following errors on the page
      |Producer is required.|

  #Dwelling - Property Info Modal
  @fixture_ui_edits_dwelling_coverage_without_protection_class @delete_when_done @dwelling
  Scenario Outline: Verify mandatory fields - Dwelling - Property Information Modal
    Given I have started a new dwelling policy up to the "property info" modal
    And I fill data for rating tier and premise address
    Then I click on Prefill Property Info button
    And I click on protection class override checkbox and save and close the modal
    And I clear the field with dismiss cross in "property info" modal
    Then I click on Prefill Property Info button
    Then I should see "<validation message>" on the page
    Examples:
      |validation message             |
      #|Rating Tier is required.       |
      |Premise Address is required    |
      |Built year is required.        |
      |Premise Use is required.       |
      |Occupancy is required.         |
      |Number of Families is required.|
      |Roof Type is required.         |
      |Construction is required.      |
      |Feet from recognized water source is required.|
      #|Territory is required.                        |
      |Protection Class is required.                 |
      |Primary Heat is required.                     |

  @fixture_ui_edits_dwelling_coverage_without_protection_class @delete_when_done @dwelling
  Scenario Outline: Verify mandatory fields - Dwelling - Property Information Modal - All validation errors
    Given I have started a new dwelling policy up to the "property info" modal
    And I fill data for rating tier and premise address
    Then I click on Prefill Property Info button
    And I close the property info modal and open it again
    And I save and close the "property info" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message             |
      |Complete all required fields below|

  @fixture_ui_edits_dwelling_special_property_info_mandatory @delete_when_done @dwelling
  Scenario Outline: Verify mandatory fields - Dwelling - Property Information Modal - after issuance
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    And I navigate to my quote "IN - Special Dwelling" using the left nav
    And I click modify on property information panel and then save and close the modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message                     |
      |Complete all required fields below     |
      |Date Purchased is required.            |
      |Roof Updates is required.              |
      |Structure Type is required.            |

  @fixture_ui_edits_dwelling_coverage_without_protection_class @delete_when_done @dwelling
  Scenario: Verify mandatory fields - Dwelling - Property Information Modal - protection class - quotation
    Given I have started a new dwelling policy up to the "property info" modal
    And I have populated the property info modal
    Then I save and close the "property info" modal
    #Then I click on modify property information modal
    And I click on protection class override checkbox
    #Then I save and close the "property info" modal
    Then I should see the following errors on the page
      |Protection Class is required.        |
      #|Fire District is required           |

     #Dwelling - Issues to resolve
  @fixture_ui_edits_dwelling_special_no_producer @delete_when_done @dwelling
  Scenario Outline: Verify the issues to resolve panel fields in Dwelling
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      |issue messages                                                 |
      |Clue Report not completed                                      |
      |Underwriting Questions must be signed off to issue this policy.|
      |Itv Report not completed                                       |
      |A producer must be specified for policy Issuance.              |
      |Email is required                                              |

    #Dwelling - Billing Account
  @fixture_dwelling_policy_issuance @delete_when_done @dwelling
  Scenario: Verify the validation on billing account
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I start with issue wizard modal till Billing Information section
    And I should see the following red alerts on the top right corner
      | Some products do not have a billing account |

  @fixture_ui_edits_dwelling_special_affiliation @delete_when_done @dwelling @wip
  Scenario: Verify the validation on billing account- Dwelling - Affiliate discount requires EFT (or annual pay)
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    And I save policy or quote number from account summary page for "Dwelling" policy
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I start with issue wizard modal till Billing Account modal
    And I should see the warning message on billing Add product modal
      |by not selecting eft, the affiliate discount will be removed from in-special dwelling -|

  # Dwelling - Policy Coverages
  @fixture_dwelling_policy_issuance @delete_when_done @dwelling
  Scenario: Verify the validation Coverage A or Coverage C is required for Dwelling.
    Given I have started a new dwelling policy up to the "auto policy coverages" modal
    And I click on save and continue button on dwelling policy coverages
    Then I should see the following errors on the page
      |Coverage A or Coverage C is required for Dwelling.|

  @fixture_dwelling_policy_issuance @delete_when_done @dwelling
  Scenario Outline: Verify the validation Coverage C and Coverage E validations
    Given I have started a new dwelling policy up to the "auto policy coverages" modal
    And I fill the data in policy coverages modal with ui_edits_dwelling_policy_coverages fixture file and save and close it
    And I click on save and continue button on dwelling policy coverages
    Then I should see "<validation message>" on the page
    Examples:
      |validation message             |
      |Total Limit must be at least $5,000|
      |Total Limit value must be in increments of 100|
      |Total Limit value must be in increments of 100|
      |Additional Limit is required                  |
      |Additional Limit value must be in increments of 1000|

  @fixture_dwelling_policy_issuance @delete_when_done @dwelling
  Scenario: Verify the validation Coverage L is selected, must also have Coverage M
    Given I have started a new dwelling policy up to the "auto policy coverages" modal
    And I fill the data in policy coverages modal with ui_edits_dwelling_policy_coverages_1 fixture file and save and close it
    And I click on save and continue button on dwelling policy coverages
    Then I should see the following errors on the page
      |When Coverage L is selected, must also have Coverage M.|

  @fixture_dwelling_policy_issuance @delete_when_done @dwelling @lambda
  Scenario: Verify the validation Coverage M is selected, must also have Coverage L
    Given I have started a new dwelling policy up to the "auto policy coverages" modal
    And I fill the data in policy coverages modal with ui_edits_dwelling_policy_coverages_2 fixture file and save and close it
    And I click on save and continue button on dwelling policy coverages
    Then I should see the following errors on the page
      |When Coverage M is selected, must also have Coverage L.|

    #Dwelling - Optional Coverages Modal
  @fixture_dwelling_policy_issuance @delete_when_done @dwelling
  Scenario Outline: Verify the validation on dwelling optional policy coverages modal
    Given I have started a new dwelling policy up to the "auto policy optional coverages" modal
    And I fill the data in "auto policy optional coverages" modal with ui_edits_dwelling_optional_policy_coverages fixture file and save and close it
    Then I should see "<validation message>" on the page
    Examples:
      |validation message             |
      |Coverage A to Replacement Cost Percentage is required|
      |Type of Business is required                         |
      |Liability Limit is required                          |
      |Med Pay is required                                  |
      |Course of Construction Type is required              |
      |Is the Applicant the General Contractor? is required |
      |Start Date of Construction is required               |
      |Estimated Completion Date is required                |
      |Occupied During Construction is required             |
      |Deductible is required                               |
      |Masonry Veneer Coverage is required                  |
      |At least one field must have something other than the included limit selected. If you do not wish to increase your limits above the included amount, please de-select the coverage.|
      |Total Limit is required                                                                                                                                                            |
      |Premium is required                                                                                                                                                                |
      |Description of Coverage is required                                                                                                                                                |
      |The selected value is already included. Please select a different value or de-select the coverage                                                                                  |
      |Total Limit is required                                                                                                                                                            |
      |On Premises must be at least $1,000                                                                                                                                                |
      |On Premises is required                                                                                                                                                            |
      #|Off Premises must be at least $1,000                                                                                                                                               |
      #|Off Premises is required                                                                                                                                                           |
      |Total Limit is required                                                                                                                                                            |
      |Amount is required                                                                                                                                                                 |

  @fixture_dwelling_policy_issuance @delete_when_done @dwelling
  Scenario Outline: Verify the validation on dwelling optional policy coverages modal - after issuance
    Given I have started a new dwelling policy up to the "auto policy optional coverages" modal
    And I fill the data in "auto policy optional coverages" modal with ui_edits_dwelling_optional_policy_coverages_issuance fixture file and save and close it
    And I begin issuance
    And I navigate to my quote "IN - Special Dwelling" using the left nav
    Then I open the optional policy coverage modal again
    Then I should see "<validation message>" on the page
    Examples:
      |validation message             |
      |Description of Animal is required|
      |Name of Business is required     |
      |Description of Business is required|
      |Name of Canine is required         |
      |Breed of Canine is required        |
      |Description of Specified Structure is required|
      |Description of Structure is required          |

