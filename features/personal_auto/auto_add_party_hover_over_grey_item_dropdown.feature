@auto @party_validation
Feature: Hover over messages should present for greyed items which cant be chosen in role dropdown

  @fixture_auto_policy_party_applicant_only_required @PAT-7994 @delete_when_done @regression @TestCaseKey=PAT-T459
  Scenario: Validate Parties modal headers
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I validate the columns in parties modal
    And I select party type as "Individual" and role as "Applicant" and add new party details
    Then I validate "Applicant" role details and "save and close" the modal

  @fixture_auto_policy_party_applicant_only_required @PAT-7994 @delete_when_done @regression @TestCaseKey=PAT-T588
  Scenario: Validate hover over message on greyed options - driver and trustee
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and validate hover over message

