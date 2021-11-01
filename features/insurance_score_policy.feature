@framework
Feature: Create a policy with a specific insurance score

  @fixture_auto_policy_autoplus_combined_none_clue_prefill
  Scenario:  Create a policy with a specific insurance score
    Given I have created a new "Auto" policy
    When I update the insurance score to be "Y"
    Then the policy should be updated with the correct insurance score