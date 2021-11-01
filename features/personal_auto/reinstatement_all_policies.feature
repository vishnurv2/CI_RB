@reinstatement
Feature: Reinstatement of policies

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @TestCaseKey=PAT-T3210 @auto
  Scenario: Auto Policy reinstatement
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"

  @fixture_home_policy_none_combined_none_pdf_validation @regression @delete_when_done @TestCaseKey=PAT-T3248 @homeowners
  Scenario: Homeowners Policy reinstatement
    Given I have created a new "home" policy
    And I fully issue the home policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T3249 @umbrella
  Scenario: Umbrella Policy reinstatement
    Given I have created a new "umbrella" policy
    And I fully issue the umbrella policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"

  @fixture_dwelling_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T3250 @dwelling
  Scenario: Dwelling Policy reinstatement
    Given I have created a new "dwelling" policy
    And I fully issue the dwelling policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"

  @fixture_watercraft_policy @regression @delete_when_done @regression @TestCaseKey=PAT-T3251 @watercraft
  Scenario: Watercraft Policy reinstatement
    Given I have created a new "watercraft" policy
    And I fully issue the watercraft policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"

  @fixture_scheduled_property_policy_issuance @regression @delete_when_done @TestCaseKey=PAT-T3252 @scheduled_property
  Scenario: Scheduled property Policy reinstatement
    Given I have created a new "scheduled_property" policy
    And I fully issue the scheduled property policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    When I close the cancellation modal
    Then the policy should show "cancelled"
    When I click on three dots again option "Reinstate" should be available in list
    Then I reinstate the policy
    And the policy should show "INFORCE"
