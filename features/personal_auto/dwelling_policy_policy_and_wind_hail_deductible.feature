@dwelling @account_management
Feature: Dwelling policy deductibles - policy and wind/hail

  @fixture_dwelling_policy_issuance @delete_when_done @PAT-11591 @regression @TestCaseKey=PAT-5780
  Scenario:  Dwelling - Wind/Hail Deductibles (Cov B, D & E consideration)
    Given I have started a new dwelling policy up to the "auto policy coverages" modal
    Then I enter coverage A and validate wind hail deductible values as per policy deductible value
