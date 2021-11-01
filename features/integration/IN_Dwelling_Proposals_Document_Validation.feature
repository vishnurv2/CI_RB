Feature: To validate Proposal pdf for Dwelling LOB

  @fixture_dwelling_policy_issuance @integration
  Scenario: To validate Proposal pdf for Dwelling LOB
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    When I create a proposal
    And I navigate to "Account Overview" using the left nav
    And I gather account and policy numbers for "IN - Special Dwelling"
    Then I saved the "Proposal" pdf from account
    Then I validate the Proposal pdf