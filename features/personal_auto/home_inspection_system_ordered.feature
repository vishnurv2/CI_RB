@homeowners @new_business
Feature: Homeowners - Inspection System Ordered

  @fixture_home_inspection_system_ordered @delete_when_done @PAT-7126 @TestCaseKey=PAT-T520 @regression
  Scenario: Homeowners- Inspection - System - Ordered
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    Then I order reports apart from inspection order
    And I resolve any underwriter referrals using blue streak seal or approvals
    When I finish issuing the policy
    Then the products status should be "INFORCE" or "ISSUED"



