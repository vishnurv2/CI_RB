@umbrella @account_management
Feature: Umbrella - Policy level coverages

  @fixture_umbrella_policy @delete_when_done @PAT-4056 @regression @TestCaseKey=PAT-T199
  Scenario:  Umbrella - Policy level coverages modal through modify button
    Given I have started a new umbrella policy through the "applicant_prefill" modal
    And I click on modify umbrella coverage information
    Then The "auto policy coverages" modal should be visible

  @fixture_umbrella_policy @delete_when_done @PAT-4056 @regression @TestCaseKey=PAT-T196
  Scenario:  Umbrella - Policy level coverages modal through add product modal
    Given I have started a new umbrella policy up to the "auto_policy_coverages" modal
    Then The "auto policy coverages" modal should be visible

  @fixture_umbrella_policy @delete_when_done @PAT-4056 @TestCaseKey=PAT-T197
  Scenario:  Umbrella - Validate total limit liability and total limit in Policy level coverages modal
    Given I have started a new umbrella policy up to the "auto_policy_coverages" modal
    Then The "auto policy coverages" modal should be visible
    And I validate total limit must be equal to or less than limit of liability
      | total_limit_liability| total_limit |
      | $1,000,000           | $1,000,000  |
      | $2,000,000           | $1,000,000  |
      | $2,000,000           | $2,000,000  |
      | $6,000,000           | $1,000,000  |
      | $6,000,000           | $2,000,000  |
      | $6,000,000           | $3,000,000  |
      | $6,000,000           | $4,000,000  |
      | $6,000,000           | $5,000,000  |
      | $6,000,000           | $6,000,000  |
      | $10,000,000          | $1,000,000  |
      | $10,000,000          | $2,000,000  |
      | $10,000,000          | $3,000,000  |
      | $10,000,000          | $4,000,000  |
      | $10,000,000          | $5,000,000  |
      | $10,000,000          | $6,000,000  |
      | $10,000,000          | $7,000,000  |
      | $10,000,000          | $8,000,000  |
      | $10,000,000          | $9,000,000  |
      | $10,000,000          | $10,000,000 |

  @fixture_umbrella_policy @delete_when_done @PAT-4056 @PAT-7429 @regression @TestCaseKey=PAT-T22
  Scenario:  Umbrella - Validate default values in Policy level coverages modal
    Given I have started a new umbrella policy up to the "auto_policy_coverages" modal
    Then The "auto policy coverages" modal should be visible
    And I validate default values in umbrella policy coverages modal

  @fixture_umbrella_policy @delete_when_done @PAT-4056 @PAT-7517 @regression @TestCaseKey=PAT-T198
  Scenario:  Umbrella - Validate default values of uninsured or underinsured coverage
    Given I have started a new umbrella policy up to the "auto_policy_coverages" modal
    Then The "auto policy coverages" modal should be visible
    And I validate default values of uninsured underinsured coverage