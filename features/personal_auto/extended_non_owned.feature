@extended_non_owned_coverage @auto
Feature: Extended Non-Owned Coverage

  @fixture_extended_non_owned_coverage @PAT-6845 @TestCaseKey=PAT-T3642 @post_deploy_candidate @regression
  Scenario: Adding Extended Non-Owned Coverage
    Given I have created a new "Auto" policy
    When I add the policy level optional coverage "Extended Non-Owned Coverage"
#    And I provide details for auto policy optional coverages modal "Extended Non-Owned Coverage"
    Then the policy should have the coverage "Extended Non-Owned Coverage"

    #    bug PAT-11674
  @regression @fixture_extended_non_owned_coverage @TestCaseKey=PAT-T3643 @known_issue
  Scenario: One Driver Rated Displays Extended Non-Owned Validation Message
    Given I have created a new "Auto" policy
    And I navigate to "Quote Management" using the left nav
    And I navigate to "IN - Auto" using the left nav
    When I add the policy level optional coverage "Extended Non-Owned Coverage"
#    And I provide details for auto policy optional coverages modal "Extended Non-Owned Coverage"
    And I begin issuance
    And I navigate to "Account Overview" using the left nav
    Then The saved driver on Account Overview will have the role "Extended Non Owned Driver"
