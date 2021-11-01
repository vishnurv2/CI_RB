Feature: To validate Proposal pdf for Home LOB

  @fixture_home_policy_none_combined_none_pdf_validation @integration
  Scenario: To validate Proposal pdf for Home LOB
    Given I have created a new "home" policy
    And I begin issuance
    When I create a proposal
    And I navigate to "Account Overview" using the left nav
    And I gather account and policy numbers for "IN - Homeowners"
    Then I saved the "Proposal" pdf from account
    Then I validate the Proposal pdf