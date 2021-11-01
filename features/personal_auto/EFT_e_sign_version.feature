@account_management @auto
Feature: EFT form - provide e-sign version

  @fixture_auto_policy_applicants_details @delete_when_done @regression @PAT-11359 @wip
  Scenario: Checking for the Account level documents
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I resolve any underwriter referrals using blue streak seal or approvals
    Then I navigate till billing modal and validate it
    And I populate the billing modal with checking account details
    And I finish issuing the policy after adding billing account
    Then I save billing account details