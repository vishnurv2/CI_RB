@scheduled_property @policy_issuance
Feature: Scheduled Property policy issuance

  @fixture_scheduled_property_policy_issuance @delete_when_done @TestCaseKey=PAT-T556 @ci
  Scenario:  Policy issuance Scheduled Property
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_scheduled_property_policy_issuance_agreed_value @delete_when_done @TestCaseKey=PAT-T894 @PAT-4217 @regression
  Scenario:  Policy issuance Scheduled Property - agreed value
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    Then I validate issues to resolve and resolve it
    And I fully issue the scheduled property policy
    Then the products status should be "INFORCE" or "ISSUED"