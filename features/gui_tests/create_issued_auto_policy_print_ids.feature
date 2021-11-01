@wip
Feature: Create an Auto Policy and Print Its IDs For the GUI Test Application
# this feature is used by the test application GUI
# to create policies for the developers and should
# never be modified outside of that context

  Scenario: Create an Auto Policy and Print Its IDs
    Given I have created a new "Auto" policy using the auto_policy_none_combined_none_full_vin fixture
    And I fully issue the policy
    Then I print my account ID
