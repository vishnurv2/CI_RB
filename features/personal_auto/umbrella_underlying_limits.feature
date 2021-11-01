@umbrella @multiple
Feature: Umbrella - Underlying policies minimum limit


   @delete_when_done @PAT-11301 @TestCaseKey=PAT-T5272 @wip
  Scenario: Umbrella underlying policies - Limits bumping via Umbrella Snapshot
    Given I have started a new auto policy through the "auto_policy_coverages_modal" modal using the auto_below_underlying_limit_with_umbrella fixture
    And I click "Continue" button of "quote_snapshot_modal" modal
     And I save and continue "homeowners" product till "quote_snapshot_modal" modal using the hplc_below_underlying_limit fixture
     And I click "Continue" button of "quote_snapshot_modal" modal
     And I save and continue "watercraft" product till "quote_snapshot_modal" modal using the wplc_below_underlying_limit fixture
     And I click "Continue" button of "quote_snapshot_modal" modal
     And I save and continue "dwelling" product till "quote_snapshot_modal" modal using the dwelling_below_underlying_limit fixture
     And I click "Continue" button of "quote_snapshot_modal" modal
    When I save and continue "umbrella" product till "exposures_insured_modal" modal using the uplc_enhanced_coverage fixture
    Then I validate premium in "quote_snapshot_modal" modal
    When I click "error_icon" button of "quote_snapshot_modal" modal
    Then I validate underlying limit confirmation
    When I "accept" underlying limit confirmation
    Then I validate "success" toaster message "Limits bumped up successfully for underlying policy" on the page
     And I click "Continue" button of "quote_snapshot_modal" modal
     And I verify bumped up limits of underlying products


  @delete_when_done @wip @PAT-11301 @TestCaseKey=PAT-T5273
  Scenario: Umbrella underlying policies - Limits bumping via Quote Management Umbrella Snapshot
    Given I have started a new auto policy through the "auto_policy_coverages_modal" modal using the auto_below_underlying_limit_without_umbrella fixture
    And I click "Continue" button of "quote_snapshot_modal" modal
    And I save and continue "homeowners" product till "quote_snapshot_modal" modal using the hplc_below_underlying_limit fixture
    And I click "Continue" button of "quote_snapshot_modal" modal
    And I save and continue "watercraft" product till "quote_snapshot_modal" modal using the wplc_below_underlying_limit fixture
    And I click "Continue" button of "quote_snapshot_modal" modal
    And I save and continue "dwelling" product till "quote_snapshot_modal" modal using the dwelling_below_underlying_limit fixture
    And I click "Quote Management" button of "quote_snapshot_modal" modal
    When I apply to quote and add umbrella
    Then I save and continue "umbrella" product till "exposures_insured_modal" modal using the uplc_enhanced_coverage fixture
    And I validate premium in "quote_snapshot_modal" modal
    When I click "error_icon" button of "quote_snapshot_modal" modal
    Then I validate underlying limit confirmation
    When I "accept" underlying limit confirmation
    Then I validate "success" toaster message "Limits bumped up successfully for underlying policy" on the page
    And I click "Continue" button of "quote_snapshot_modal" modal
    And I verify bumped up limits of underlying products


  @delete_when_done @PAT-11301 @TestCaseKey=PAT-T5274 @wip
  Scenario: Umbrella underlying policies - Limits bumping - rejected
    Given I have started a new auto policy through the "auto_policy_coverages_modal" modal using the auto_below_underlying_limit_with_umbrella fixture
    And I click "Continue" button of "quote_snapshot_modal" modal
    And I save and continue "homeowners" product till "quote_snapshot_modal" modal using the hplc_below_underlying_limit fixture
    And I click "Continue" button of "quote_snapshot_modal" modal
    And I save and continue "watercraft" product till "quote_snapshot_modal" modal using the wplc_below_underlying_limit fixture
    And I click "Continue" button of "quote_snapshot_modal" modal
    And I save and continue "dwelling" product till "quote_snapshot_modal" modal using the dwelling_below_underlying_limit fixture
    And I click "Continue" button of "quote_snapshot_modal" modal
    When I save and continue "umbrella" product till "exposures_insured_modal" modal using the uplc_enhanced_coverage fixture
    Then I validate premium in "quote_snapshot_modal" modal
    When I click "error_icon" button of "quote_snapshot_modal" modal
    Then I validate underlying limit confirmation
    When I "reject" underlying limit confirmation
    Then I validate premium in "quote_snapshot_modal" modal