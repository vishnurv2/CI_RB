@umbrella @account_management
Feature: Umbrella quote management

  @fixture_quote_options_umbrella_policy @delete_when_done @PAT-4071 @regression @TestCaseKey=PAT-T204
  Scenario:  Umbrella - Validate panel one data
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    When I navigate to "Quote Management" using the left nav
    Then I validate the correct updates in panel one

  @fixture_umbrella_policy @delete_when_done @PAT-4071 @regression @TestCaseKey=PAT-T202
  Scenario:  Umbrella - Validate umbrella liability limit and umbrella uninsured motorist limit
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    When I navigate to "Quote Management" using the left nav
    And I validate ui_uim total limit must be equal to or less than limit of liability
      | umbrella_liability_limit| umbrella_uninsured_motorist_limit |
      | $1,000,000              | $1,000,000                        |
      | $2,000,000              | $1,000,000                        |
      | $2,000,000              | $2,000,000                        |
      | $6,000,000              | $1,000,000                        |
      | $6,000,000              | $2,000,000                        |
      | $6,000,000              | $3,000,000                        |
      | $6,000,000              | $4,000,000                        |
      | $6,000,000              | $5,000,000                        |
      | $6,000,000              | $6,000,000                        |
      | $10,000,000             | $1,000,000                        |
      | $10,000,000             | $2,000,000                        |
      | $10,000,000             | $3,000,000                        |
      | $10,000,000             | $4,000,000                        |
      | $10,000,000             | $5,000,000                        |
      | $10,000,000             | $6,000,000                        |
      | $10,000,000             | $7,000,000                        |
      | $10,000,000             | $8,000,000                        |
      | $10,000,000             | $9,000,000                        |
      | $10,000,000             | $10,000,000                       |

  @fixture_quote_options_umbrella_policy @delete_when_done @PAT-4071 @PAT-7450 @regression @TestCaseKey=PAT-T201
  Scenario: Validate Panel 1 and 2 bumping
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    When I navigate to "Quote Management" using the left nav
    Then I validate the correct upgrades in panel two
    And difference between the panels should be highlighted

  @fixture_quote_options_umbrella_policy @delete_when_done @PAT-4071 @PAT-7450 @regression @TestCaseKey=PAT-T203
  Scenario:  Umbrella - Apply to quote and verify the fields updated
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    When I navigate to "Quote Management" using the left nav
    Then I apply to quote and validate the updates in both the panels

  @fixture_quote_options_umbrella_policy_uim @delete_when_done @PAT-4071 @TestCaseKey=PAT-T45
  Scenario:  Umbrella - validate and update quote options on quote management page and auto policy coverages
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    When I navigate to "Quote Management" using the left nav
    Then I validate and update panel one using "quote_options_limits_update_1" fixture
    And I validate and update auto policy coverages using "quote_options_limits_update_1" fixture
    Then I validate and update panel one using "quote_options_limits_update_2" fixture
    And I validate correct updates in auto policy coverages using "quote_options_limits_update_2" fixture