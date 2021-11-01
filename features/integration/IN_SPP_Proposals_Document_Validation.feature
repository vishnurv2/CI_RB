Feature: To validate Proposal pdf for Scheduled property LOB

  @fixture_scheduled_property_policy_issuance @integration
  Scenario: To validate Proposal pdf for Scheduled property LOB
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    When I create a proposal
    And I navigate to "Account Overview" using the left nav
    And I gather account and policy numbers for "IN - Scheduled Property"
    Then I saved the "Proposal" pdf from account
    Then I validate the Proposal pdf