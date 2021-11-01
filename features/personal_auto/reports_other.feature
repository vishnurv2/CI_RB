@auto @reports_validation
Feature: Features Dependent on Multiple Reports or Independent of Reports

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T268
  Scenario: Reports section
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I order CLUE and MVR reports
    And I should see the following reports available with the correct status
      | report          | status       |
      | CLUE            | Completed    |
      | MVR             | Violations   |
      | Insurance Score | Score = Z    |
      | Auto Prefill    | Not Returned |

  @fixture_auto_policy_none_combined_none @delete_when_done @regression @TestCaseKey=PAT-T267
  Scenario: A Tab Appears for Each Product
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add a product from the left nav
    Then I add an additional product using the generic_account_info fixture
    When I navigate to "Reports" using the left nav
    Then I should see at least 2 report tabs

  # PAT-8492   Predicted Clear not showing in Test, its Completed
  @delete_when_done @fixture_auto_policy_autoplus_combined_none_old_driver @regression @TestCaseKey=PAT-T266 @known_issue
  Scenario: Reports can be ordered
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I navigate to "Reports" using the left nav
    Then I should see the following reports available with the correct status
      | report       | status       |
      | Auto Prefill | Not Returned |
      | CLUE         | Not Ordered  |
    When I order the "CLUE" report
    Then the status for the "CLUE" report should change to "Predicted Clear"
    And the checkbox for ordering "CLUE" should not be visible

  @fixture_insurance_score @delete_when_done @regression @TestCaseKey=PAT-T269
  Scenario: Insurance Score Section Contains Insurance Score
    Given I have created a new "Auto" policy
    When I navigate to "Reports" using the left nav
    Then I should see my insurance score

  @fixture_auto_policy_autoplus_combined_none @delete_when_done @regression @TestCaseKey=PAT-T270
  Scenario: Territory Report Can Be Viewed
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Reports" using the left nav
    When I edit the first territory report
    Then The "territory report" modal should be visible

  @fixture_insurance_score @delete_when_done @regression @TestCaseKey=PAT-T5197
  Scenario: Reports - Manually entered Accidents and Violations
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I order CLUE and MVR reports
    And I enter and save accident and violation details in MVR report
    Then I validate accident and violation details in MVR report

  @fixture_insurance_score @delete_when_done @TestCaseKey=PAT-T5198
  Scenario: Reports - Validate dispute reasons dropdown
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I order CLUE and MVR reports
    And I validate the following dispute reasons
      | Violation Miscoded by State BMV                            |
      | Not Chargeable Due to Another Loss/Conviction on Same Date |
      | Other                                                      |


  ### Tests below have not been verified for Angular ####

  # This is being re-worked - these CLUE reports wont be able to be ordered until the policy is issued
  @regression @fixture_accidents_violations @delete_when_done @known_issue @wip @TestCaseKey=PAT-T3336
  Scenario: Accidents or Violations Can Be Disputed
    Given I have created a new "Auto" policy
    When I navigate to "Reports" using the left nav
    And I order the "CLUE" report
    And I assign drivers on the current report
    And I order the "MVR" report
    And I dispute an accident or violation
    Then I should see the disputed accident or violation

  # This is being re-worked - these CLUE reports wont be able to be ordered until the policy is issued
  @fixture_accidents_violations @delete_when_done @known_issue @wip @TestCaseKey=PAT-T3337
  Scenario: Accidents or Violations Can Be Created and Deleted
    Given I have created a new "Auto" policy
    When I navigate to "Reports" using the left nav
    Then All reports should be checked
    When I order the "CLUE" report
    And I assign drivers on the current report
    And I order the "MVR" report
    And I create an accident or violation
    Then I should see the created accident or violation
    When I delete the accident or violation
    Then I should not see the deleted accident or violation

  # This is being re-worked - these CLUE reports wont be able to be ordered untill the policy is issued
  @fixture_clue_mvr_dispute_reasons @delete_when_done @known_issue @wip @TestCaseKey=PAT-T3338
  Scenario: I Can See the CLUE and MVR Dispute Reasons Available
    Given I have created a new "Auto" policy
    When I navigate to "Reports" using the left nav
    And I order CLUE and MVR reports
    Then I should see the CLUE dispute reasons available on the CLUE modal
    When I apply to quote on the CLUE modal
    Then I should see the MVR dispute reasons available on the auto driver modal



