@wip
Feature: Create a Prefill Auto Policy and Print Its IDs For the GUI Test Application
# this feature is used by the test application GUI
# to create policies for the developers and should
# never be modified outside of that context

  Scenario: Create a Prefill Auto Policy and Print Its IDs
    Given I have started a new auto policy through the "auto prefill" modal using the create_prefill_auto_policy_for_gui fixture
    Then I print my policy ID and account ID
