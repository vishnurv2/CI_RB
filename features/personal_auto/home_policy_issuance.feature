@homeowners @new_business
Feature: Home policy issuance

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T3580 @ci
  Scenario:  Home Policy fully issuance
    Given I have started a new home policy through the "auto policy coverages" modal
    And I fully issue the home policy
    Then the products status should be "INFORCE" or "ISSUED"

  # need to fix the ITV modal poping up.

  @fixture_home_policy_prefill_issuance @delete_when_done @regression @TestCaseKey=PAT-T3581
  Scenario:  Home Policy fully issuance Prefill Address
    Given I have started a new home policy through the "auto policy coverages" modal
    And I fully issue the home policy
    Then the products status should be "INFORCE" or "ISSUED"