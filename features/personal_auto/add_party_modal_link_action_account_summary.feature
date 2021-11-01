@auto @party_validation
Feature: Add Party Modal - Link Action from Acct Summary

  @fixture_auto_policy_party_loss_payee @delete_when_done @PAT-7334 @TestCaseKey=PAT-T363 @post_deploy_candidate @regression
  Scenario:  Add Party Modal - Link Action from Acct Summary
    Given I have created a new "Auto" policy
    And I navigate to "Account Overview" using the left nav
    Then I select party type as "Individual" and verify the role options
      | role                |
      | Applicant           |
      | Additional Insured  |
      | Additional Interest |
      | Contact             |
      | Driver              |
      | Excluded Driver     |
      | Joint Ownership     |
      | Non Rated Driver    |
      | Trustee             |
      | LLC Member          |
    And I select party type as "Business Entity" and verify the role options
      | role                |
      | Additional Insured  |
      | Additional Interest |
      | Corporate Auto      |
      | Lessor              |
      | Loss Payee          |
      | Trust               |
      | Mortgagee           |
      | LLC                 |
    Then I select party type as "Individual" and verify disabled options
