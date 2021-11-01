Feature: Validating the UI-Edits for homeowners policy

  #HOME - Add Product Modal
  @fixture_b_1_1 @delete_when_done @homeowners
  Scenario Outline: Verify mandatory fields - Add Product Modal
    Given I have logged in
    And I log new personal account
    When I enter an agency name
    And I add first applicant using the "first_applicant_details_1" fixture to fill Personal Account Modal
    And I save and close new personal account modal
    Then I should see the "Add Product" modal
    And I click on Begin quote on Add product modal
    Then I should see the "Add Product" modal
    And I add a product using home_product fixture and remove the state
    Then I should see "<validation message>" on the page
    Examples:
      |validation message       |
      |State is required.          |
      |Effective Date is required. |
      |Expiration Date is required.|

  @fixture_ui_edits_home_special_no_producer @delete_when_done @homeowners
  Scenario: Verify mandatory fields - Add Product Modal - Email required
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    And I navigate to my quote "IN-Homeowners" using the left nav
    And I click edit on the applicant panel and save and close the modal
    Then I should see the following errors on the page
      |Email is required|

   #General Information Modal
  @fixture_ui_edits_general_modal_mandatory_fields @delete_when_done @homeowners
  Scenario Outline: Verify mandatory fields - General Information Modal
    Given I have started a new home policy up to the "auto general info" modal
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

    #Effective date validation message in general info modal is working fine manually but not with automation
  @fixture_ui_edits_general_modal_mandatory_fields @delete_when_done @wip
  Scenario: Verify mandatory fields - General Information Modal - Effective date
    Given I have started a new home policy up to the "auto general info" modal
    And I clear the effective date field and click save and close button
    Then I should see the following errors on the page
      |Effective Date is required.|

  @fixture_ui_edits_home_special_no_producer @delete_when_done @homeowners
  Scenario: Verify mandatory fields - General Information Modal - Producer
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    And I navigate to my quote "IN-Homeowners" using the left nav
    And I click modify on general information modal and then save and close the modal
    Then I should see the following errors on the page
      |Producer is required.|

  #HOME - Property Info Modal
  @fixture_ui_edits_home_special_coverage_without_protection_class @delete_when_done @homeowners
  Scenario Outline: Verify mandatory fields - Property Information Modal
    Given I have started a new home policy up to the "property info" modal
    Then I click on Prefill Property Info button
    And I clear the address and click on protection class override checkbox and save and close the modal
    Then I click on Prefill Property Info button
    And I save and continue the "property info" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message             |
      |Premise Address is required    |
      |Built year is required.        |
      |Premise Use is required.       |
      |Number of Families is required.|
      |Number of Stories is required. |
      |Roof Type is required.         |
      |Construction is required.      |
      |Feet from recognized water source is required.|
      |Protection Class is required.                 |
      |Primary Heat is required.      |

  @fixture_ui_edits_home_special_coverage_without_protection_class @delete_when_done @homeowners
  Scenario Outline: Verify mandatory fields - Property Information Modal - All validation errors
    Given I have started a new home policy up to the "property info" modal
    Then I click on Prefill Property Info button
    And I close the property info modal and open it again
    And I save and close the "property info" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message                |
      |Complete all required fields below|

  @fixture_ui_edits_home_special_property_info_mandatory @delete_when_done @homeowners
  Scenario Outline: Verify mandatory fields - Property Information Modal - after issuance
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    And I navigate to my quote "IN-Homeowners" using the left nav
    And I click modify on property information panel and then save and close the modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message        |
      |Date Purchased is required.            |
      |Structure Type is required.            |
      |Roof Updates is required.              |

  @fixture_ui_edits_home_special_coverage_without_protection_class @delete_when_done @homeowners
  Scenario: Verify mandatory fields - Property Information Modal - protection class - quotation
    Given I have started a new home policy up to the "property info" modal
    And I have populated the property info modal
    Then I save and close the "property info" modal
    #Then I click on modify property information modal
    And I click on protection class override checkbox
    #Then I save and close the "property info" modal
    Then I should see the following errors on the page
      |Protection Class is required.       |
      #|Fire District is required           |
      #|Responding Fire Station is required |

 # @fixture_ui_edits_home_protection_class_after_issuance @delete_when_done @homeowners
 # Scenario: Verify mandatory fields - Property Information Modal - protection class - after issuance
    #Given I have started a new home policy through the "auto policy coverages" modal
    #And I begin issuance
    #And I navigate to my quote "IN-Homeowners" using the left nav
    #And I open the property info modal again
    #Then I should see the following errors on the page
     # |Protection Class is required        |
     # |Fire District is required           |
     # |Responding Fire Station is required |

  #HOME - Policy Level Coverages Modal
  @fixture_ui_edits_home_summit_condo @delete_when_done @homeowners
  Scenario: Verify mandatory fields - Policy level coverages - coverage A - Replacement Cost must be at least 30% of Coverage C
    Given I have started a new home policy up to the "auto policy coverages" modal
    And I fill the data in policy coverages modal with ui_edits_policy_coverages fixture file and save and close it
    Then I should see the following errors on the page
      |Coverage A - Replacement Cost must be at least 30% of Coverage C - Contents ($24,000)|

  @fixture_ui_edits_home_sumit @delete_when_done @homeowners
  Scenario: Verify mandatory fields - Policy level coverages - Coverage C - Contents must be at least 60% of Coverage A
    Given I have started a new home policy up to the "auto policy coverages" modal
    And I fill the data in policy coverages modal with ui_edits_policy_coverages_1 fixture file and save and close it
    Then I should see the following errors on the page
      |Coverage C - Contents must be at least 60% of Coverage A - Replacement Cost ($3,000)|

  @fixture_ui_edits_home_signature_policy @delete_when_done @homeowners
  Scenario: Verify mandatory fields - Policy level coverages - Signature - Coverage C - Contents must be at least 60% of Coverage A
    Given I have started a new home policy up to the "auto policy coverages" modal
    And I fill the data in policy coverages modal with ui_edits_policy_coverages_1 fixture file and save and close it
    Then I should see the following errors on the page
      |Coverage C - Contents must be at least 60% of Coverage A - Replacement Cost ($3,000)|

    ###################################################################

  @fixture_ui_edits_home_tenant_policy @delete_when_done @homeowners
  Scenario: Verify mandatory fields - Coverage C <$6,000 for form 4
    Given I have started a new home policy up to the "auto policy coverages" modal
    Then I should see the following errors on the page
      |Coverage C - Contents must be at least $6,000|

  @fixture_ui_edits_home_condominium @delete_when_done @homeowners
  Scenario Outline: Verify mandatory fields - Coverage C <$6,000 for form 6
    Given I have started a new home policy up to the "auto policy coverages" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message                                   |
      |Coverage A - Replacement Cost must be at least $5,000|
      |Coverage C - Contents must be at least $6,000        |

  @fixture_ui_edits_summit_tenant_policy @delete_when_done @homeowners @known_issue
  Scenario: Verify mandatory fields - Coverage C <$50,000 Summit Tenant
    Given I have started a new home policy up to the "auto policy coverages" modal
    Then I should see the following errors on the page
      |Coverage C - Contents must be at least $50,000|

  @fixture_ui_edits_home_signature_policy @delete_when_done @homeowners @known_issue
  Scenario: Verify referral for COV-A < 500,000 and Signature POLICY
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Signature Home: Coverage A limit must be at least $500,000 or above. Underwriter approval is required prior to binding.|

  @fixture_ui_edits_home_summit_condo @delete_when_done @homeowners @known_issue
  Scenario: Verify referral SUMMIT CONDO POLICY AND COV-C < 75000 AND RISK-STATE IS NOT NC
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Summit Condo - Coverage C must be at least $75,000.|

  @fixture_ui_edits_home_special_cov_c_greater @delete_when_done @homeowners @known_issue
  Scenario: Applies to all forms where Cov C > Cov A. N/A to form 4, 6, T or C.
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Coverage C limit is greater than Coverage A limit. Underwriter approval is required prior to binding.|

  @fixture_ui_edits_home_special_cov_c_less @delete_when_done @homeowners
  Scenario: Applies to Coverage C < 40% of Coverage A for form 3
    Given I have started a new home policy up to the "auto policy coverages" modal
    When I have populated the auto policy coverages modal
    Then I should see the following errors on the page
      |Coverage C - Contents must be at least 40% of Coverage A - Replacement Cost ($2,000)|

  @fixture_ui_edit_home_comprehensive @delete_when_done @homeowners @lambda
  Scenario: Applies to Coverage C < 40% of Coverage A for form 5 - comprehensive
    Given I have started a new home policy up to the "auto policy coverages" modal
    When I have populated the auto policy coverages modal
    Then I should see the following errors on the page
      |Coverage C - Contents must be at least 40% of Coverage A - Replacement Cost ($2,000)|

  #HOME - Issues to resolve
  @fixture_ui_edits_home_special_issues_to_resolve @delete_when_done @homeowners
    Scenario Outline: Verify the issues to resolve panel fields
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I should see <issue messages> present on alert side bar
    Examples:
      |issue messages                                                 |
      |Clue Report not completed                                      |
      |Underwriting Questions must be signed off to issue this policy.|
      |Itv Report not completed                                       |

  #HOME - Billing Account
  @fixture_ui_edits_home_special_issues_to_resolve @delete_when_done @homeowners
  Scenario: Verify the validation on billing account
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I start with issue wizard modal till Billing Information section
    And I should see the following red alerts on the top right corner
      | Some products do not have a billing account |

  @fixture_ui_edits_home_special_affiliation @delete_when_done @homeowners
  Scenario: Verify the validation on billing account - Affiliate discount requires EFT (or annual pay)
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    And I save policy or quote number from account summary page for "Home" policy
    And I save name email and phone number from account summary page
    When I answer all the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I start with issue wizard modal till Billing Account modal
    And I should see the warning message on billing Add product modal
      |by not selecting eft, the affiliate discount will be removed from in-homeowners -|


















