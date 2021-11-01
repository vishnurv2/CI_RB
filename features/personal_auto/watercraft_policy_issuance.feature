@watercraft @new_business
Feature: Watercraft policy issuance

  @fixture_watercraft_policy @delete_when_done @PAT-4293 @TestCaseKey=PAT-T576 @ci
  Scenario:  Watercraft policy issuance status Inforce or Issued
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_watercraft_policy @regression @delete_when_done @TestCaseKey=PAT-T2129
  Scenario: A watercraft policy with additional watercraft
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I fully issue watercraft policy
    Given I add an additional Indiana "watercraft" product after fully issue till "watercraft_operator_modal" using the fixture file "watercraft_policy_issuance_with_prefill"
    And I fully issue multiple watercraft policy