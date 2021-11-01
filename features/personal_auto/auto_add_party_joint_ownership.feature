@auto @party_validation
Feature: Auto - Party - Joint Ownership

  @fixture_auto_policy_party_joint_ownership_only_required @delete_when_done @PAT-7463 @TestCaseKey=PAT-T414 @post_deploy_candidate @regression
  Scenario:  Auto - Party - Joint Ownership
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Joint Ownership" and add new party details
    Then I validate "Joint Ownership" role details and "save and close" the modal
