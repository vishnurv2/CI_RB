@document
Feature: Home Policy Overrides

  @fixture_home_policy_none_combined_none_pdf_validation @document_verification @regression @wip @modification_required @TestCaseKey=PAT-T3578 @homeowners
  Scenario: Verify contents of Home Binder document
    Given I have created a new "home" policy
    Then I should see a "Protection Class" in override panel 1 for home
    Then I should see a "Package Discount" in override panel 1 for home
    Then I should see a "Territory - Premise Address" in override panel 1 for home
    Then I should see a "Inspection" in override panel 1 for home
    Then I should see a "Transition Credit" in override panel 1 for home
    Then I should see a "Flood Score" in override panel 1 for home

  @fixture_umbrella_policy @document_verification @regression @wip @done @TestCaseKey=PAT-T3579 @umbrella
  Scenario: Verify contents of Umbrella Binder document
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    Then I should see a "Package Discount" in override panel 1 for home