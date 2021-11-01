Feature: Automation can verify Umbrella PDFs

  @fixture_umbrella_policy @document_verification @wip
  Scenario: Verify contents of Umbrella Binder document
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    And I gather account and policy numbers for "IN - Umbrella"
    Then I save the "Binder" pdf
    Then I save the XML
    Then I gather additional data for Umbrella policy "IN - Umbrella"
    Then I validate the PDF for Umbrella Binder

  @fixture_umbrella_policy @document_verification @wip @pat-10441
  Scenario: Verify contents of Umbrella Quote document
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    And I gather account and policy numbers for "IN - Umbrella"
    Then I save the "Quote" pdf
    Then I save the XML
    Then I gather additional data for Umbrella policy "IN - Umbrella" quote
    Then I validate the PDF for Umbrella Quote

  @fixture_umbrella_policy @document_verification @wip
  Scenario: Verify contents of Umbrella Application document
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    And I gather account and policy numbers for "IN - Umbrella"
    Then I save the "Application" pdf
    Then I gather additional data for Umbrella policy "IN - Umbrella" application
    Then I validate the PDF for Umbrella Application