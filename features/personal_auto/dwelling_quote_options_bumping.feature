@dwelling @account_management
Feature: Dwelling quote options bumping

  @fixture_dwelling_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T3644
  Scenario: Dwelling Policy - non premium change endorsement
    Given I have created a new "dwelling" policy
    When I navigate to "Quote Management" using the left nav
    Then Panel 2 should display upgrades for the premium and others for dwelling

    #have some doubt, will discuss this with BA
  @fixture_dwelling_policy_issuance @regression @delete_when_done @wip @TestCaseKey=PAT-T3645
  Scenario: After editing the enhanced coverage the values get bumped
    Given I have created a new "dwelling" policy
    When I navigate to "Quote Management" using the left nav
    When I upgrade deductible from the quote options page to "$5,000"

  @fixture_dwelling_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T3646
  Scenario: Validating the quote after updating package discount
    Given I have created a new "dwelling" policy
    When I navigate to "Quote Management" using the left nav
    When I upgrade package discount from the quote options page to "Yes with Auto and Homeowners"
    Then premium should be same on both the Quote panels in dwelling