Feature: To validate Proposal pdf for Umbrella LOB

  @fixture_umbrella_policy @integration
  Scenario: To validate Proposal pdf for Umbrella LOB
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    When I create a proposal
    And I navigate to "Account Overview" using the left nav
    And I gather account and policy numbers for "IN - Umbrella"
    Then I saved the "Proposal" pdf from account
    Then I validate the Proposal pdf