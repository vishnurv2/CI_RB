@auto @account_management
Feature: Issues To Resolve

  @delete_when_done @fixture_issues_to_resolve @regression @TestCaseKey=PAT-T225
  Scenario Outline: Invalid Drivers License Number Issue To Resolve Appears
    Given I have created a new "auto" policy
    And I begin issuance
    And I navigate to "IN - Auto Plus" using the left nav
    When I edit the first "<object_to_edit>" and ignore validations
    Then I should see an issue to resolve containing "<issue_to_resolve_message>"
    When I open the issue to resolve containing "<issue_to_resolve_message>"
    Then The "auto <object_to_edit>" modal should be visible
    Examples:
      | object_to_edit | issue_to_resolve_message                                          |
      | driver         | The license number you entered does not match the required format |

  @regression @fixture_auto_policy_none_combined_none_full_vin @delete_when_done @TestCaseKey=PAT-T223
  Scenario: MVR Issue to Resolve Navigates to Reports
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I should see an issue to resolve containing "MVR"
    When I open the issue to resolve containing "MVR"
    Then I should open "order reports modal"

  @regression @delete_when_done @fixture_issues_to_resolve @TestCaseKey=PAT-T222
  Scenario: Issues To Resolve Appear and Navigate Correctly
    Given I have created a new "Auto" policy
    And I begin issuance
    And I navigate to "IN - Auto Plus" using the left nav
    When I edit the first "vehicle" and ignore validations
    Then The issues to resolve should load the appropriate modals
      | issue                          | modal              |
      | Complete Identification Number | auto vehicle modal |

  @regression @delete_when_done @fixture_issues_to_resolve @TestCaseKey=PAT-T224
  Scenario: Issues To Resolve Appear and Navigate Correctly to pages
    Given I have created a new "Auto" policy
    And I begin issuance
    And I navigate to "IN - Auto Plus" using the left nav
    When I edit the first "vehicle" and ignore validations
    Then The issues to resolve should load the appropriate pages
      | issue                  | page             |
      | Underwriting Questions | Quote Management |
    Then The issues to resolve should load the appropriate modals
      | issue       | modal               |
      | Clue Report | order reports modal |
    Then The issues to resolve should load the appropriate modals
      | issue       | modal               |
      | Mvr Report  | order reports modal |

