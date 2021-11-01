@auto @account_management
Feature: Auto General Info

  @TestCaseKey=PAT-T111
  Scenario: Using an Existing Account Open the Auto General Info Modal
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I open the auto general info modal
    Then The "Auto General Info" modal should be visible
    Then I close the "Auto General Info" modal

  @TestCaseKey=PAT-T108
  Scenario: Using an Existing Account Modify the Auto General Info
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I modify the auto general info
    Then I should see the new auto general info

  @TestCaseKey=PAT-T110
  Scenario: Auto General Info Manual Loss Validation Messages Appear
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add an invalid manual loss to the auto general info
    Then I should see the manual loss validation messages

  @TestCaseKey=PAT-T109
  Scenario: Auto General Info Expiration Date 1 Year After Effective Date
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I enter an effective date on the auto general info
    Then the expiration date on the auto general info is 1 year after the effective date

  @fixture_auto_policy_none_combined_none @TestCaseKey=PAT-T113
  Scenario: Auto General Info Add and delete loss
    Given I have created a new "Auto" policy
    When I add a loss to the auto general info
    Then the auto general info modal should have a loss
    When I delete the losses on the auto general info modal
    Then the auto general info modal should not have a loss
