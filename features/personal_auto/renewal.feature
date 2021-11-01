@auto @renewal @indiana_auto @personal_auto
Feature: Renewals

  @regression @fixture_auto_policy_prerenewal_date @wip @TestCaseKey=PAT-T3342 @delete_when_done
  Scenario: Pre-Renewal and Renewal Policies Appear in Product Grid
    Given I have created a new "auto" policy
    #And I change all referral statuses to Approved
    And I fully issue the policy
    And I prerenew the policy through swagger
    And I have opened the account summary opened previously
    Then I should see a policy with the status "Pre-Renewal"
    And The policy change count should be 1
    When I navigate to "Quotes (0)" using the left nav
    And I begin issuance
    And I navigate to "Quote Options" using the left nav
    And I finish issuing the policy
    Then I should see a policy with the status "Renewal"
    And I should not see a policy with the status "Pre-Renewal"
