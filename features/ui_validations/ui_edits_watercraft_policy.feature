Feature: Validating the mandatory fields for Watercraft policy

  @fixture_watercraft_policy_coverage_null @delete_when_done @watercraft
  Scenario Outline: Verify UI validations for Hull and Motor information modal
    Given I have started a new watercraft policy up to the "hull and motor information" modal
    And I save and close the "hull and motor information" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message       |
      |Type of Hull is required.|
      |Year is required.        |
      |Make is required.        |
      |Model is required.       |
      |Length(ft) is required.  |
      |Motor Type is required.  |
      |Engine Size is required. |

  @fixture_watercraft_policy_new_driver @delete_when_done @watercraft
  Scenario Outline: Verify UI validations for driver modal
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    Then I should see "<validation message>" on the page
    Examples:
      |validation message                       |
      |First Name is required.                  |
      |Last Name is required.                   |
      |Date of Birth is required.               |
      |Gender is required.                      |
      |Marital Status is required.              |
      |Relationship to Applicant is required.   |
      |Years Of Boating Experience is required. |

  @fixture_watercraft_policy_compulsary_fields @delete_when_done @watercraft
  Scenario: Verify UI validations for hull and motor after issuance
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    Then I begin issuance
    And I navigate to "IN - Watercraft" using the left nav
    And I modify the watercraft vehicle panel
    And I save and close the "hull and motor information" modal
    Then I should see the following errors on the page
      |Serial/Hull ID is required.|
      |Registration Number is required.|
    And I close the "hull and motor information" modal
    Then I should see the following issue messages on alerts side bar
      | The Watercraft Serial Number is required. |
      | The Watercraft Registration Number is required. |
      #| The motor manufacturer/model is required.       |
      #| The motor year must be between 1920 and next year. |
      #| The motor serial number is required.               |

  @fixture_watercraft_policy_coverage_null @delete_when_done @watercraft
  Scenario: Verify explanation field for 'Any existing damage to any of the boats?'
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the watercraft underwriting questions "Yes" to all the questions
    Then I verify explanation field is present for all question

  @fixture_watercraft_policy_coverage_null @delete_when_done @watercraft
  Scenario Outline: Verify UI validations for blank Trailer Information Modal
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    Then I open the Trailer Information modal
    And I save and close the "trailer information" modal
    Then I should see "<validation message>" on the page
    Examples:
      |validation message                       |
      |Year is required.|
      |Make is required.|
      |Model is required.|
      |Physical Damage Limit is required.|
      |Deductible is required.           |

  @fixture_watercraft_policy_coverage_null @delete_when_done @watercraft
  Scenario: Verify UI validations for - all watercraft must have the same deductible amount.
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    Then I open the Trailer Information modal
    And I have populated the trailer information modal
    And I save and close the "trailer information" modal
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      | All watercrafts must have the same deductible amount. |

  @fixture_ui_edits_watercraft_policy_liability @delete_when_done @watercraft @lambda
  Scenario: Verify UI validations for - Watercraft Horsepower must also be greater than 0.
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    Then I should see the following issue messages on alerts side bar
      |All watercrafts which are neither Sailboats nor Personal watercrafts (Jet Ski or Waverunners) must have horse power greater than 0.|

  @fixture_ui_edits_watercraft_policy_liability @delete_when_done @watercraft
  Scenario: Verify UI validations for - Power of watercraft is invalid.
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I modify the watercraft vehicle panel
    Then I fill the data in "hull and motor information" modal with generic_hull_and_motor_personal_watercraft fixture file and save and close it
    Then I should see the following issue messages on alerts side bar
      | All watercrafts which are neither Sailboats nor Personal watercrafts (Jet Ski or Waverunners) must have horse power greater than 0. |

  @fixture_ui_edits_watercraft_policy_physical_damage @delete_when_done @watercraft
  Scenario: Verify UI validations for - Minimum $250 deductible for watercraft greater than $19,999
    Given I have started a new watercraft policy up to the "hull and motor information" modal
    And I have populated the hull and motor information modal
    Then I save and close the "hull and motor information" modal
    And I populate data in watercraft coverages modal for deductible
    And I add a watercraft operator
    Then I should see the following issue messages on alerts side bar
      | Minimum $250 deductible for watercraft greater than $19,999. |

  @fixture_watercraft_policy_coverage_null @delete_when_done @watercraft
  Scenario: Verify UI validations - The trailer year must be between 1920 and next year.
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    Then I open the Trailer Information modal
    And I have populated the trailer info modal with "trailer_information_past_year" fixture
    And I save and close the "trailer information" modal
    And I begin issuance
    Then I navigate to "IN - Watercraft" using the left nav
    Then I click on edit on 2 vehicle on watercraft vehicle panel
    When I update the year for trailer to "1875"
    Then I should see the following issue messages on alerts side bar
      |The trailer year must be between 1920 and next year.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @watercraft
  Scenario: Watercraft liability should be same as the Coverage E and MedPay should be same as Coverage F
    Given I have started a new home policy up to the "auto policy coverages" modal
    Then I have populated the auto policy coverages modal
    Then I save the coverages provided on policy level coverages modal
    And I start to add a new product
    And I add a product using watercraft_product fixture
    Then I verify watercraft liablity and medpay should be same as cov E and Cov F of home










