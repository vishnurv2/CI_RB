@umbrella @account_management
Feature: Documents page

  # PAT-10361
  @fixture_umbrella_policy_no_um @delete_when_done @PAT-4128 @regression @TestCaseKey=PAT-T42 @known_issue
  Scenario: Umbrella - validate documents under Forward To central section
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I navigate to "Quote Management" using the left nav
    When I navigate to "Documents" using the left nav
    Then I should not see "UMUIMSelectionForm" document in "Forward To Central" section
    Then I begin issuance
    When I navigate to "Documents" using the left nav
    Then I should see "UMUIMSelectionForm" document in "Forward To Central" section

  # PAT-10361
  @fixture_umbrella_policy_no_um @delete_when_done @PAT-4128 @regression @TestCaseKey=PAT-T195 @known_issue
  Scenario: Umbrella - validate documents under Forward To central section when UM limit lower than liability
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I begin issuance
    When I navigate to "Documents" using the left nav
    Then I should see "UMUIMSelectionForm" document in "Forward To Central" section

  @fixture_umbrella_policy_no_um @delete_when_done @PAT-4128 @TestCaseKey=PAT-T3300 @regression
  Scenario: Umbrella - validate documents are present after begin issuance
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    When I navigate to "Documents" using the left nav
    Then I should not see "Application" document in "Retain in Agency" section
    And I should not see "Binder" document in "Retain in Agency" section
    Then I begin issuance
    When I navigate to "Documents" using the left nav
    Then I should see "Application" document in "Retain in Agency" section
    And I should see "Binder" document in "Retain in Agency" section
    And I should see "Quote" document in "Share with Client" section

  @fixture_umbrella_policy_no_um @delete_when_done @PAT-4128 @TestCaseKey=PAT-T194
  Scenario: Umbrella - validate documents under Forward To central section when um coverage is not selected
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I begin issuance
    When I navigate to "Documents" using the left nav
    Then I should see "UIUM Option Form" document in "Forward To Central" section

  @fixture_umbrella_policy_um @delete_when_done @PAT-4128 @regression @TestCaseKey=PAT-T193
  Scenario: Umbrella - validate documents under Forward To central section when UM limit is equal to liability
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I begin issuance
    When I navigate to "Documents" using the left nav
    Then I should not see "UMUIMSelectionForm" document in "Forward To Central" section