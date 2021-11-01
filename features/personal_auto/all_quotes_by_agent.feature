@agent_validation
Feature: Create Policies as an Agent and try to edit them as a CMI employee

  @fixture_auto_policy_autoplus_combined_none_agent @regression @delete_when_done @TestCaseKey=PAT-T3693 @auto
  Scenario: Validate of the Auto Quote Created by Agent is Editable by CMI Employee
    Given I have created a new "Auto" policy
    And I save the url of created policy and logout from the agent account and login as a CMI employee with "valid creds"
    When I add 1 random drivers from the auto summary page
    Then the drivers should display in the driver grid on the auto summary page

  @fixture_home_party_loss_payee_agent @delete_when_done @regression @TestCaseKey=PAT-T3694 @homeowners
  Scenario: Validate of the Home Quote Created by Agent is Editable by CMI Employee
    Given I have started a new home policy through the "auto policy coverages" modal
    And I save the url of created policy and logout from the agent account and login as a CMI employee with "valid creds"
    Then I navigate to "Account Overview" using the left nav
    When I edit the first applicant
    Then the applicant should have changed from the "Account Summary" page

  @fixture_umbrella_policy_agent @delete_when_done @regression @TestCaseKey=PAT-T3695 @umbrella
  Scenario: Validate of the Umbrella Quote Created by Agent is Editable by CMI Employee
    Given I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I save the url of created policy and logout from the agent account and login as a CMI employee with "valid creds"
    Then I navigate to "Account Overview" using the left nav
    When I edit the first applicant
    Then the applicant should have changed from the "Account Summary" page

  @fixture_watercraft_policy_agent @delete_when_done @regression @TestCaseKey=PAT-T3696 @watercraft
  Scenario: Validate of the Watercraft Quote Created by Agent is Editable by CMI Employee
    Given I have started a new watercraft policy through the "auto_policy_coverages" modal
    And I save the url of created policy and logout from the agent account and login as a CMI employee with "valid creds"
    Then I navigate to "Account Overview" using the left nav
    When I edit the first applicant
    Then the applicant should have changed from the "Account Summary" page

  @fixture_dwelling_policy_agent @delete_when_done @regression @TestCaseKey=PAT-T3697 @dwelling
  Scenario: Validate of the Dwelling Quote Created by Agent is Editable by CMI Employee
    Given I have created a new "dwelling" policy
    And I save the url of created policy and logout from the agent account and login as a CMI employee with "valid creds"
    When I edit the first applicant
    Then the applicant should have changed from the "Account Summary" page

  @fixture_scheduled_property_policy_agent @delete_when_done @regression @TestCaseKey=PAT-T3698 @scheduled_property
  Scenario: Validate of the Schedule Property Quote Created by Agent is Editable by CMI Employee
    Given I have created a new "scheduled_property" policy
    And I save the url of created policy and logout from the agent account and login as a CMI employee with "valid creds"
    Then I navigate to "Account Overview" using the left nav
    When I edit the first applicant
    Then the applicant should have changed from the "Account Summary" page

