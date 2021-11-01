Feature: To validate Proposal pdf for Watercraft LOB

  @fixture_watercraft_policy @integration
  Scenario: To validate Proposal pdf for Watercraft LOB
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I begin issuance
    When I create a proposal
    And I navigate to "Account Overview" using the left nav
    And I gather account and policy numbers for "IN - Summit Watercraft"
    Then I saved the "Proposal" pdf from account
    Then I validate the Proposal pdf