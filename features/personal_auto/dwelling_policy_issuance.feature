Feature: Dwelling policy issuance

  @fixture_dwelling_policy_issuance @delete_when_done @TestCaseKey=PAT-T1684 @ci @dwelling @policy_issuance
  Scenario:  Fully issue Dwelling policy
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I fully issue the dwelling policy
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_dwelling_policy_issuance @delete_when_done @TestCaseKey=PAT-T1685 @dwelling @account_management
  Scenario:  Create Dwelling Quote
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And the account summary should have an applicant
    Then the property information I entered should be displayed in the property information panel