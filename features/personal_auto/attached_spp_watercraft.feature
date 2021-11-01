@homeowners @attached_policy
Feature: WT - Attached SPP & Watercraft - Disable Edit of General Information from Summary

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5786 @PAT-12309 @regression
  Scenario: WT - Attached SPP & Watercraft - Disable Edit of General Information from Summary
    Given I have started a new home policy through the "auto policy coverages" modal
    And I attach "watercraft" product to home till "watercraft_operator_modal" using the fixture file "watercraft_policy_attached_to_home"
    And I attach "scheduled_property" product to home till "scheduled_property_classes_modal" using the fixture file "scheduled_property_attached_to_home"
    When I navigate to "IN - Homeowners" using the left nav
    Then I validate edit icon should not be disabled on general information modal
    When I navigate to attached product "Watercraft"
    Then I validate edit icon should be disabled on general information modal
    When I navigate to attached product "Scheduled Property"
    Then I validate edit icon should be disabled on general information modal


  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5822 @PAT-12374 @regression
  Scenario: WT - Attached SPP & Watercraft - issue wizard UI
    Given I have started a new home policy through the "auto policy coverages" modal
    And I attach "watercraft" product to home till "watercraft_operator_modal" using the fixture file "watercraft_policy_attached_to_home"
    And I attach "scheduled_property" product to home till "scheduled_property_classes_modal" using the fixture file "scheduled_property_attached_to_home"
    And I begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for home
    And I resolve any underwriter referrals using blue streak seal or approvals
    Then I verify products under home
