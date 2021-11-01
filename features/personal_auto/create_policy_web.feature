@wip
Feature: Auto policies can be created from Jenkins

  Background:
    Given I modify the effective dates

  @fixture_auto_policy_none_combined_none @known_issue @TestCaseKey=PAT-T3673
  Scenario:  Basic Auto Policy
    Given I have created a new "auto" policy
    Then I send account via email

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T3674
  Scenario: Fully Issuing a Policy
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    Then I finish issuing the policy
    Then I send account via email

  @fixture_home_policy_none_combined_none_loss_settlement @TestCaseKey=PAT-T3675
  Scenario:  HOME New Home Policy with
    Given I have created a new "home" policy
    Then I send account via email

  @fixture_umbrella_policy_enhanced_no_exposures @TestCaseKey=PAT-T3676
  Scenario:  Umbrella - Create new umbrella policy with no exposures
    Given I have created a new "umbrella" policy
    Then I send account via email

  @fixture_scheduled_property_policy_issuance @TestCaseKey=PAT-T3677
  Scenario:  Policy issuance Scheduled Property
    Given I have created a new "scheduled_property" policy
    Then I send account via email

  @fixture_watercraft_policy @TestCaseKey=PAT-T3678
  Scenario:  Watercraft - Create new watercraft policy
    Given I have created a new "watercraft" policy
    Then I send account via email

  @fixture_dwelling_policy_issuance @TestCaseKey=PAT-T3679
  Scenario: Dwelling - Create new dwelling policy
    Given I have created a new "dwelling" policy
    Then I send account via email

  @fixture_home_policy_issuance @TestCaseKey=PAT-T3680
  Scenario:  Home Policy fully issuance
    Given I have started a new home policy through the "auto policy coverages" modal
    And I fully issue the home policy
    Then I send account via email

  @fixture_auto_policy_exposure_vehicle @TestCaseKey=PAT-T3681
  Scenario:  Policy issuance of Auto and Home
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    Then I send account via email

  @fixture_umbrella_policy @TestCaseKey=PAT-T3682
  Scenario:  Umbrella - policy issuance
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I fully issue the umbrella policy
    Then I send account via email

  @fixture_auto_policy_exposure_vehicle @TestCaseKey=PAT-T3683
  Scenario:  Policy issuance of Auto and Umbrella
    Given I have created a new "Auto" policy
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    Then I send account via email
