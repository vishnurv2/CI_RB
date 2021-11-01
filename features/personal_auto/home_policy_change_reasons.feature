@homeowners @policy_change @new_business
Feature: Home - Policy Change Reasons - Include Optional Coverages

  @delete_when_done @regression @PAT-9540 @TestCaseKey=PAT-TXXX @wip
  Scenario: Home - Policy Change Reasons - Include Optional Coverages
    Given I have created a new "home" policy using the home_limited_fungi_rot_bacteria fixture
    And I fully issue the home policy
    When I navigate to policies "IN - Homeowners" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    And I edit fungi rot liability property and limit optional coverage
    Then I navigate to policies "Open Policy Changes" using the left nav
    And I validate policy change message for optional coverages

  @delete_when_done @regression @PAT-11416 @TestCaseKey=PAT-TXXX @wip
  Scenario: Dwelling - Policy Change Reasons - Include Optional Coverages
    Given I have created a new "dwelling" policy using the dwelling_limited_fungi_rot_bacteria fixture
    And I fully issue the home policy
    When I navigate to policies "IN - Special Dwelling" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    And I edit fungi rot liability property and limit optional coverage
    Then I navigate to policies "Open Policy Changes" using the left nav
    And I validate policy change message for optional coverages


