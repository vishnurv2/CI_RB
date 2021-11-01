@wip
Feature: Create an Auto Policy and Print Its IDs For the GUI Test Application
# this feature is used by the test application GUI
# to create policies for the developers and should
# never be modified outside of that context

  Scenario: Create an Auto Policy and Print Its IDs
    Given I have created a new "Auto" policy using the auto_policy_none_combined_none_full_vin fixture
    #Given I have started a new auto policy through the "auto_general_info" modal using the <auto_policy_none_combined_none> fixture
    Then I print my policy ID and account ID
