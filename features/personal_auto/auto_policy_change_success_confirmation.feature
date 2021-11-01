@homeowners @policy_change @new_business
Feature: Policy change success confirmation modal

  @fixture_home_policy_none_combined_none_pdf_validation @regression @delete_when_done @TestCaseKey=PAT-T631 @PAT-6887
  Scenario: Validate policy change success confirmation modal
    Given I have created a new "home" policy
    And I fully issue the home policy
    When I select Create Policy Change for the auto product
    Then I add a policy change with "Specify Date"
    When I edit the first property from the home policy summary page with the file "policy_change_property_info_modal"
    Then I Issue Policy Change
    And I click submit on review and submit policy change modal
    Then I validate Policy Changes Issued Successfully modal
