Feature: To validate Proposal pdf for Auto LOB

  @fixture_intigration_auto_policy_none_combined_none_pdf_validation_7 @integration
  Scenario: To validate Proposal pdf for Auto LOB
    Given I have created a new "Auto" policy
    And I begin issuance
    When I create a proposal
    And I navigate to "Account Overview" using the left nav
    And I gather account and policy numbers for "IN - Auto"
    Then I saved the "Proposal" pdf from account
    Then I validate the Proposal pdf
