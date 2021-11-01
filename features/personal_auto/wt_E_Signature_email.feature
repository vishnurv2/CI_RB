@auto @new_business
Feature: WT - E-signature Email

  @delete_when_done @TestCaseKey=PAT-T5486 @PAT-11989 @regression
  Scenario: WT - E-signature Email - Carry Email Address Forward
    Given I have created a new "Auto" policy using the auto_existing_driver_self fixture
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_existing_driver_self"
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    And I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I start issuing the policy and verify signature carry forward functionality




