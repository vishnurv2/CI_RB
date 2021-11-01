@auto @new_business @vehicle @policy_change
Feature: Lock down changes that can be made to vehicle screen during policy change

  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @PAT-10667 @TestCaseKey=PAT-T3298 @regression
  Scenario: Lock down changes that can be made to vehicle screen during policy change
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I finish issuing the policy
    And I add a policy change and specify the effective date
    When I click on edit the first vehicle
    Then I validate fields displayed on vehicle modal
    Then I navigate to "Overrides" using the left nav
    And I select policy change option on overrides page
    Then I should see a "Territory" in override panel 1
    When I apply the "Territory" override in panel 1
    Then the "Territory" override in panel 1 should show as overridden
    Then I navigate to policies "IN - Auto Plus" using the left nav
    And I click on edit the first vehicle
    And I validate overridden status on Territory field on vehicle modal







