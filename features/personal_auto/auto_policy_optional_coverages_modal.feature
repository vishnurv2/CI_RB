@auto @coverage_validation @indiana_auto @personal_auto
Feature: Policies can have optional coverages

  @TestCaseKey=PAT-T120
  Scenario: Agents Can View Manual Policy Coverages by CMI Employees
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I open the policy level optional coverages
    Then I should see the "Auto Policy Optional Coverages" modal
    Then I should see these auto policy optional coverages available
      | coverage                    |
      | Corporate Auto Coverage     |
      | Extended Non Owned Coverage |
      | Mexico Coverage             |
      | Manual Coverage             |

  @delete_when_done @fixture_a_7_9 @TestCaseKey=PAT-T119
  Scenario: Optional Coverages Can Be Modified
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I modify the auto policy optional coverages
    Then I should see the modified auto policy optional coverage selections in the panel
    And I should see the modified auto policy optional coverage selections in the modal

  @delete_when_done @fixture_manual_coverage_created_deleted @TestCaseKey=PAT-T121
  Scenario: Manual Policy Coverages Can Be Added and Deleted
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I add a manual policy optional coverage
    Then I should see the manual policy optional coverage I added
    When I delete the manual policy optional coverage I added
    Then I should not see the manual policy optional coverage I added

