@auto @policy_issuance
Feature: Communication Preference - Policy Distribution, E-billing, e-signature and text notification

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T232 @PAT-12950
  Scenario: Communication Preference - Policy Distribution, e-billing, e-signature and text notification
    Given I have created a new "auto" policy
    And I fully issue the policy
    And I navigate to "Communication Preference" using the left nav
    Then I should see at 3 tabs
      | Policy Distribution |
      | E-Billing           |
      | Text Notification   |


#    When I select "Manage Text & E-Options" option from the action menu
#    Then The "E Options" modal should be visible
#    Then I close the "E Options" modal
