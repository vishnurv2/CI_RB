@auto @policy_issuance @indiana_auto @personal_auto
Feature: Account Summary Policy View - Add party information

    #Party information is barely started. 6-15
  @fixture_auto_policy_autoplus_combined_none_full_vin @regression @hold @wip @TestCaseKey=PAT-T3703
  Scenario: While in Policy View Mode - Party Information - Cannot edit
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I click the "Policies" tab
    And I navigate to "Party Information" using the left nav
    Then I stop
    Then The action icons and roles should not be visible

