@auto @vehicle
Feature: Lease Loan Guard

  @fixture_lease_loan_non_prem_lease @delete_when_done @TestCaseKey=PAT-T227
  Scenario: Lease guard can be added to a policy without summit or signature
    Given I have started a new auto policy up to the "auto vehicle coverages" modal
    And I open the vehicle I just added
    Then The lease loan guard coverage "should not" be automatically selected
    And Lease loan guard "Lease Guard" can be added to the policy

  @regression @fixture_lease_loan_non_prem_loan @delete_when_done @TestCaseKey=PAT-T226
  Scenario: Loan guard can be added to a policy without summit or signature
    Given I have started a new auto policy up to the "auto vehicle coverages" modal
    And I open the vehicle I just added
    Then The lease loan guard coverage "should not" be automatically selected
    And Lease loan guard "Loan Guard" can be added to the policy

  @regression @fixture_lease_loan_sig_loan @delete_when_done @TestCaseKey=PAT-T3575
  Scenario: Lease guard is included on a policy with signature
    Given I have started a new auto policy up to the "auto vehicle coverages" modal
    And I open the vehicle I just added
    Then The lease loan guard coverage "should" be automatically selected
    And Loan guard can be added to the policy with limit "Remove 25% of ACV and 5 Year Limitation"

  @fixture_lease_loan_summit_loan @delete_when_done @regression @TestCaseKey=PAT-T3576
  Scenario: Lease guard is included on a policy with summit
    Given I have started a new auto policy up to the "auto vehicle coverages" modal
    And I open the vehicle I just added
    Then The lease loan guard coverage "should" be automatically selected
    And Loan guard can be added to the policy with limit "Remove 5% of ACV and 5 Year Limitation"